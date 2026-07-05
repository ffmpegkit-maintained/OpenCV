# ABI + module config for OpenCV's platforms/android/build_sdk.py — FREE build.
#
# FREE = OpenCV 5.0 core + the MOST-REQUESTED contrib modules
# (face, tracking, aruco, text), arm64-v8a only, NDK r27c, 16 KB aligned.
# The full contrib set is the Pro build (private repo).
#
# build_sdk.py evaluates this with `ABI` in scope and reads `ABIs`.

# BUILD_LIST restricts which modules are compiled (core deps pulled automatically).
# NB: ArUco is in CORE objdetect in OpenCV 5.0 (not a contrib module) — it comes
# with objdetect below. Free contrib additions vs the official AAR: face, tracking, text.
SELECTED = (
    "core,imgproc,imgcodecs,videoio,video,calib,features,dnn,objdetect,photo,java,"
    "face,tracking,text"
)

_vars = dict(
    ANDROID_STL="c++_shared",
    ANDROID_PLATFORM="android-24",
    BUILD_LIST=SELECTED,
    # 16 KB page alignment (Android 15 ready)
    CMAKE_SHARED_LINKER_FLAGS="-Wl,-z,max-page-size=16384 -Wl,-z,common-page-size=16384",
    BUILD_ANDROID_EXAMPLES="OFF",
    BUILD_TESTS="OFF",
    BUILD_PERF_TESTS="OFF",
)

ABIs = [
    ABI("3", "arm64-v8a", None, 24, cmake_vars=_vars),   # Free = arm64-v8a only (api 24)
]
