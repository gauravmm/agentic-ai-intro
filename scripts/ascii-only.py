#!/usr/bin/env python3
"""Fail on non-ASCII characters that are not on the allowlist below.

The allowlist is everything the deck used when the hook was added; it is a
snapshot to be audited down, not a set of approved characters.
"""

import sys
import unicodedata

ALLOWED = set(
    "→↔↗↘"  # RIGHTWARDS, LEFT RIGHT, NE, SE ARROW
    "·•◆…"  # MIDDLE DOT, BULLET, BLACK DIAMOND, ELLIPSIS
    "×÷≠≈≤≥"  # MULTIPLICATION .. GREATER-THAN OR EQUAL
    "¾⅛"  # VULGAR FRACTION THREE QUARTERS, ONE EIGHTH
    "‍️⚕"  # ZWJ, VARIATION SELECTOR-16, STAFF OF AESCULAPIUS
)

# Emoji are deliberate slide content here --- avatars in the figures, the title
# logo --- not stray typography, so the whole emoji block is fine. The pieces
# that build ZWJ sequences live outside it and are allowlisted above.
EMOJI = range(0x1F300, 0x1FAFF + 1)


def main(paths: list[str]) -> int:
    bad = False
    for path in paths:
        with open(path, encoding="utf-8") as handle:
            for lineno, line in enumerate(handle, 1):
                for ch in line:
                    if ord(ch) > 127 and ch not in ALLOWED and ord(ch) not in EMOJI:
                        name = unicodedata.name(ch, "unnamed")
                        print(f"{path}:{lineno}: U+{ord(ch):04X} {name}")
                        bad = True
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
