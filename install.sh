#!/bin/bash

# Source the nix installer
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$SCRIPT_DIR/nix.sh"

npm i -g vsce ovsx