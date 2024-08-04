#!/bin/bash

export LEWIX_ROOT_DIR=$(readlink -f .)
export LEWIX_VERSION=$(cat VERSION.txt)
export LEWIX_ISO_NAME="lewix_$LEWIX_VERSION"
export LEWIX_MNT_FOLDER="$(readlink -f /mnt/lewix)"
export LEWIX_MNT_ROOT_DIR=$LEWIX_MNT_FOLDER/root
export LEWIX_STATE_FILE="$(readlink -f $LEWIX_ROOT_DIR/STATE.txt)"

echo "LEWIX_ROOT_DIR: $LEWIX_ROOT_DIR"
echo "LEWIX_VERSION: $LEWIX_VERSION"
echo "LEWIX_ISO_NAME: $LEWIX_ISO_NAME"
echo "LEWIX_MNT_FOLDER: $LEWIX_MNT_FOLDER"
echo "LEWIX_STATE_FILE: $LEWIX_STATE_FILE"

lewix_state_get() {
    local key=$1
    grep "^${key}=" "$LEWIX_STATE_FILE" | cut -d'=' -f2
}

lewix_state_set() {
    local key=$1
    local value=$2

    if grep -q "^${key}=" "$LEWIX_STATE_FILE"; then
        awk -v key="$key" -v value="$value" -F '=' '
        $1 == key { $2 = value }
        { print }' "$LEWIX_STATE_FILE" > "$LEWIX_STATE_FILE.tmp" && mv "$LEWIX_STATE_FILE.tmp" "$LEWIX_STATE_FILE"
    else
        echo "$key=$value" >> "$LEWIX_STATE_FILE"
    fi
}

export -f lewix_state_get
export -f lewix_state_set
