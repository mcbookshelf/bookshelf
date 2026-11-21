"""Serve the documentation, rebuild it when a source changes and tell the open pages."""

import json
import subprocess
import sys
import threading
from collections.abc import Callable, Iterable
from functools import partial
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from queue import Empty, Queue

import watchfiles

from mcbookshelf import constants

CLIENT = "/__livereload/client.js"
EVENTS = "/__livereload/events"
SCRIPT = f'<script src="{CLIENT}" type="module"></script>'.encode()
IGNORED = (".mo", ".py", ".pyc", "switcher.json")

type Result = dict[str, object]


def serve(
    worker: Worker,
    address: tuple[str, int],
    watched: Iterable[Path],
    *,
    build: Callable[[list[str]], Result],
    ready: Callable[[], None],
) -> None:
    """Serve until interrupted what `build` makes of each batch of changes, the first one empty."""
    output = worker.output
    with Server(address, partial(Handler, directory=str(output))) as server:
        try:
            build([])
            threading.Thread(target=server.serve_forever, daemon=True).start()
            try:
                ready()
                changes = watchfiles.watch(*watched, watch_filter=Sources(output), debounce=300)
                for batch in changes:
                    paths = sorted(path for _, path in batch)
                    server.announce(change(build(paths), paths))
            finally:
                # Asked to stop first: its thread fails on a socket closed under it
                server.shutdown()
        finally:
            worker.stop()


def change(result: Result, paths: list[str]) -> Result:
    """What the open pages need to know: the pages written, or that anything may have changed."""
    static = [path for path in paths if "_static" in Path(path).parts]
    return {
        "pages": result.get("pages", []),
        "css": any(path.endswith(".css") for path in static),
        "all": bool(result.get("fresh")) or any(not path.endswith(".css") for path in static),
    }


class Sources(watchfiles.DefaultFilter):
    """The changes worth a build: not what a build writes, here or in the default output."""

    ignore_dirs = (*watchfiles.DefaultFilter.ignore_dirs, "_build")

    def __init__(self, output: Path) -> None:
        super().__init__()
        self.output = output.resolve()

    def __call__(self, change: watchfiles.Change, path: str) -> bool:
        built = self.output in Path(path).resolve().parents
        return super().__call__(change, path) and not built and not path.endswith(IGNORED)


class Worker:
    """The process that holds Sphinx between the builds, started again if it ever stops."""

    def __init__(self, output: Path, builder: str, language: str) -> None:
        self.output = output
        self.arguments = [str(constants.DOCS_DIR), str(output), builder, language]
        self.process: subprocess.Popen[str] | None = None
        self.results: Queue[str] = Queue()

    def start(self, *, fresh: bool) -> Result:
        """Start a new worker and wait for its first build, on an empty state when `fresh`."""
        self.stop()
        command = [sys.executable, "-m", "mcbookshelf.sphinx.worker", *self.arguments]
        # In a group of its own, the worker is not interrupted with this process
        group = subprocess.CREATE_NEW_PROCESS_GROUP if sys.platform == "win32" else 0
        self.process = subprocess.Popen(
            [*command, "fresh" if fresh else "kept"], cwd=constants.DOCS_DIR, encoding="utf-8",
            stdin=subprocess.PIPE, stdout=subprocess.PIPE, creationflags=group,
            start_new_session=sys.platform != "win32",
        )
        self.results = Queue()
        threading.Thread(target=self._read, args=(self.process, self.results), daemon=True).start()
        result = self._result() or {"error": "the documentation worker stopped while starting"}
        return {**result, "fresh": fresh}

    def build(self, paths: list[str]) -> Result:
        """Build after some changes, in a new worker when there is none or it has stopped."""
        if self.process is None:
            return self.start(fresh=False)
        if self.process.stdin is None or self.process.poll() is not None:
            return self.start(fresh=True)
        self.process.stdin.write(json.dumps(paths) + "\n")
        self.process.stdin.flush()
        return self._result() or self.start(fresh=True)

    def stop(self) -> None:
        if self.process is not None:
            self.process.kill()
            self.process.wait()
            self.process = None

    @staticmethod
    def _read(process: subprocess.Popen[str], results: Queue[str]) -> None:
        if process.stdout is not None:
            for line in process.stdout:
                results.put(line)
        results.put("")

    def _result(self) -> Result | None:
        # Waited for in short steps, as a wait with no timeout cannot be interrupted on Windows
        while True:
            try:
                line = self.results.get(timeout=0.2)
            except Empty:
                continue
            return json.loads(line) if line else None


class Server(ThreadingHTTPServer):
    """The built pages, and a stream of the changes for the pages left open."""

    daemon_threads = True

    def __init__(self, address: tuple[str, int], handler: Callable[..., Handler]) -> None:
        super().__init__(address, handler)
        self.pages: set[Queue[str]] = set()

    def announce(self, change: Result) -> None:
        for page in tuple(self.pages):
            page.put(json.dumps(change))


class Handler(SimpleHTTPRequestHandler):

    server: Server

    def do_GET(self) -> None:
        route = self.path.partition("?")[0]
        if route == EVENTS:
            self.stream()
        elif route == CLIENT:
            self.reply(Path(__file__).with_name("livereload.js").read_bytes(), "text/javascript")
        elif (page := self.page(route)) is not None:
            self.reply(page.read_bytes().replace(b"</body>", SCRIPT + b"</body>", 1), "text/html")
        else:
            super().do_GET()

    def page(self, route: str) -> Path | None:
        """The HTML file a route shows, which gets the reload script on its way out."""
        path = Path(self.translate_path(route))
        if route.endswith("/"):
            path /= "index.html"
        return path if path.suffix == ".html" and path.is_file() else None

    def reply(self, body: bytes, kind: str) -> None:
        self.send_response(200)
        self.send_header("Content-Type", f"{kind}; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def stream(self) -> None:
        """Send each change as an event, with a comment now and then to notice a closed page."""
        changes: Queue[str] = Queue()
        self.server.pages.add(changes)
        self.send_response(200)
        self.send_header("Content-Type", "text/event-stream")
        self.end_headers()
        try:
            while True:
                try:
                    self.wfile.write(f"data: {changes.get(timeout=15)}\n\n".encode())
                except Empty:
                    self.wfile.write(b": waiting\n\n")
                self.wfile.flush()
        except OSError:
            pass
        finally:
            self.server.pages.discard(changes)

    def end_headers(self) -> None:
        # Kept by the browser but checked on each use: a reload only loads what changed
        self.send_header("Cache-Control", "no-cache")
        super().end_headers()

    def log_message(self, format: str, *args: object) -> None:  # noqa: A002
        pass
