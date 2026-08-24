#! /bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

"$SCRIPT_DIR"/clean.sh
"$SCRIPT_DIR"/build.sh