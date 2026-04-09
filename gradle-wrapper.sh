#!/usr/bin/env sh
set -e
APP_HOME=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)
PROPS_FILE="$APP_HOME/gradle/wrapper/gradle-wrapper.properties"
DIST_URL=$(grep '^distributionUrl=' "$PROPS_FILE" | cut -d= -f2- | sed 's#\\:#:#g')
DIST_NAME=$(basename "$DIST_URL")
DIST_DIR="$HOME/.gradle/wrapper/dists/${DIST_NAME%.zip}"
ZIP_PATH="$DIST_DIR/$DIST_NAME"
mkdir -p "$DIST_DIR"
if [ ! -f "$ZIP_PATH" ]; then
  if command -v curl >/dev/null 2>&1; then
    curl -L "$DIST_URL" -o "$ZIP_PATH"
  elif command -v wget >/dev/null 2>&1; then
    wget "$DIST_URL" -O "$ZIP_PATH"
  else
    echo "Error: curl o wget requerido para descargar Gradle." >&2
    exit 1
  fi
fi
UNZIP_DIR="$DIST_DIR/unpacked"
if [ ! -d "$UNZIP_DIR" ]; then
  mkdir -p "$UNZIP_DIR"
  unzip -q -o "$ZIP_PATH" -d "$UNZIP_DIR"
fi
GRADLE_BIN=$(find "$UNZIP_DIR" -type f -path '*/bin/gradle' | head -n 1)
if [ -z "$GRADLE_BIN" ]; then
  echo "Error: no se encontró gradle dentro del wrapper." >&2
  exit 1
fi
exec "$GRADLE_BIN" "$@"
