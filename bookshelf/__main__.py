import sys

from . import mc_versions, version

if __name__ == "__main__":
    if len(sys.argv) > 1:
        command = sys.argv[1]
        if command == "version":
            print(str(version())) # noqa: T201
        elif command == "mc_versions":
            print(str(mc_versions())) # noqa: T201
        else:
            print(f"Unknown command: {command}") # noqa: T201
