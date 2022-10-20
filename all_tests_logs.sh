#!/bin/bash
SUFF="$1"
if [ -n "$SUFF" ] && [[ "$SUFF" != .* ]]; then
    SUFF=".$SUFF"
fi

for f in tests/test_*.nim; do
    out="$f.logs$SUFF"
    echo $out
    nim c -r "$f" > "$out"
done
