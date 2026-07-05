#!/usr/bin/env bash
#
# Cross-compiles OpenCV 5.0 + SELECTED contrib (face, tracking, aruco, text) into
# an Android AAR — the FREE tier (arm64-v8a). Published to Maven Central + JitPack.
#
# ⚠️ HEAVY: ~20-40 min (fewer modules / one ABI than Pro). Uses cache/.
# Requires: Android NDK r27c, CMake 3.22+, Python 3, Ninja, JDK 17, ant.
#
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OPENCV="$ROOT/opencv"
CONTRIB="$ROOT/opencv_contrib"
BUILD="$ROOT/cache/android-build"
OUT="$ROOT/library/build/outputs/aar"

: "${ANDROID_NDK_HOME:?set ANDROID_NDK_HOME to NDK r27c}"
command -v cmake >/dev/null || { echo "CMake 3.22+ required"; exit 1; }
command -v python3 >/dev/null || { echo "Python 3 required"; exit 1; }
[ -d "$OPENCV/platforms/android" ] || { echo "opencv submodule missing → git submodule update --init --recursive"; exit 1; }
[ -d "$CONTRIB/modules" ]          || { echo "opencv_contrib submodule missing"; exit 1; }

mkdir -p "$BUILD" "$OUT"

echo "[1/2] Building OpenCV + selected contrib (arm64-v8a)…"
python3 "$OPENCV/platforms/android/build_sdk.py" \
  --config       "$ROOT/build-scripts/config-contrib-free.py" \
  --extra_modules_path "$CONTRIB/modules" \
  --ndk_path     "$ANDROID_NDK_HOME" \
  --sdk_path     "${ANDROID_SDK_ROOT:-${ANDROID_HOME:-}}" \
  "$BUILD" \
  "$OPENCV"

echo "[2/2] Packaging AAR…"
python3 "$OPENCV/platforms/android/build_java_shared_aar.py" \
  --opencv_version "5.0.0" \
  --output_dir     "$OUT" \
  "$BUILD/o4a"

echo "Done:"; ls -la "$OUT"/*.aar 2>/dev/null || echo "  (no .aar — inspect $BUILD)"
