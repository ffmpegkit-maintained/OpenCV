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
  --no_samples_build \
  "$BUILD" \
  "$OPENCV"

# --- 1b) Populate the Gradle library module from the built SDK ------------
# So `:library:publishToMavenCentral` publishes the REAL AAR (org.opencv classes
# + native .so), not an empty one. Verify with :library:publishToMavenLocal first.
SDK="$BUILD/OpenCV-android-sdk/sdk"
if [ -d "$SDK/java/src/org" ]; then
  echo "[1b] Populating library/ from SDK for Maven publish…"
  rm -rf "$ROOT/library/src/main/java/org" "$ROOT/library/src/main/jniLibs" "$ROOT/library/src/main/res"
  mkdir -p "$ROOT/library/src/main/java"
  cp -r "$SDK/java/src/org" "$ROOT/library/src/main/java/org"
  [ -d "$SDK/java/res" ] && cp -r "$SDK/java/res" "$ROOT/library/src/main/res"
  for abidir in "$SDK/native/libs"/*/; do
    abi=$(basename "$abidir"); mkdir -p "$ROOT/library/src/main/jniLibs/$abi"
    cp "$abidir"/*.so "$ROOT/library/src/main/jniLibs/$abi/"
    cxx=$(find "$ANDROID_NDK_HOME" -name "libc++_shared.so" -path "*$abi*" 2>/dev/null | head -1)
    [ -n "$cxx" ] && cp "$cxx" "$ROOT/library/src/main/jniLibs/$abi/"
  done
fi

echo "[2/2] Packaging AAR…"
# build_java_shared_aar.py takes the built OpenCV-android-sdk dir, auto-detects the
# version from version.hpp, and writes ./outputs/opencv_java_shared_<ver>.aar.
cd "$ROOT"
python3 "$OPENCV/platforms/android/build_java_shared_aar.py" \
  --ndk_location      "$ANDROID_NDK_HOME" \
  --java_version      17 \
  --android_compile_sdk 35 \
  --android_min_sdk   24 \
  --android_target_sdk 35 \
  "$BUILD/OpenCV-android-sdk"

mkdir -p "$OUT"
cp "$ROOT"/outputs/opencv_java_shared_*.aar "$OUT/" 2>/dev/null || true
echo "Done:"; ls -la "$OUT"/*.aar "$ROOT"/outputs/*.aar 2>/dev/null || echo "  (check $ROOT/outputs/)"
