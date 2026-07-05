# Build scripts — OpenCV Free (core + selected contrib)

Cross-compiles **OpenCV 5.0 + selected contrib** (face, tracking, aruco, text)
into an Android AAR (`arm64-v8a`), published to Maven Central + JitPack as
`dev.ffmpegkit-maintained:opencv-contrib-android`.

> ⚠️ **Heavy: ~20-40 min.** Output goes to `cache/`. The full contrib set (all 30+
> modules) + x86_64 is the **Pro** build (private repo → Gumroad).

## Prerequisites

- Android **NDK r27c** (`ANDROID_NDK_HOME`), **SDK**, **CMake 3.22+**, **Ninja**,
  **Python 3**, **JDK 17**, **ant**.
- `git submodule update --init --recursive`

## Run

```bash
export ANDROID_NDK_HOME=$ANDROID_SDK_ROOT/ndk/27.2.12479018
./build-scripts/build-opencv-android.sh
```

Output → `library/build/outputs/aar/`. Then `./gradlew :library:publishToMavenLocal`
(JitPack) or the `publish-maven.yml` workflow (Maven Central).

## Files

- **`config-contrib-free.py`** — ABI + `BUILD_LIST` (core + face/tracking/aruco/text),
  arm64-v8a, 16 KB aligned.
- **`build-opencv-android.sh`** — runs OpenCV's `build_sdk.py` + `build_java_shared_aar.py`.

Module names may need small adjustments to the exact OpenCV 5.0 naming
(`calib`/`calib3d`, `features`/`features2d`) — verify against the pinned tag.
