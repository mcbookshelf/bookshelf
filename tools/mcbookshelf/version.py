type Version = tuple[int, int, int]


def parse_version(text: str) -> Version:
    major, minor, patch = (int(p) for p in text.split("."))
    return major, minor, patch
