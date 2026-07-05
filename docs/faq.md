# FAQ

## How do I add OpenCV to my Android app?

One Gradle line with the official package:

```kotlin
implementation("org.opencv:opencv:5.0.0.1")
```

Then initialise before use:

```kotlin
if (!OpenCVLoader.initLocal()) {
    Log.e("OpenCV", "initialisation failed")
}
```

No NDK, no manual `.so` copying — the AAR bundles the native libs.

## Why is `org.opencv.ml` / SVM missing in 5.0?

Classic ML moved from **core to `opencv_contrib`** in OpenCV 5.0, and the official
AAR ships core only. Same story for Haar cascades / HOG (`xobjdetect`) and G-API
(`gapi`). See the [Migration Guide](migration-opencv5.md). To get them back without
rebuilding the SDK, use [OpenCV Pro](https://www.jokobee.com/opencv).

## Why don't my Haar cascades work anymore after upgrading?

Because the Haar/HOG detection code moved to the `xobjdetect` contrib module in
5.0. It's not in the official AAR. Either stay on 4.x, rebuild with contrib, or
use OpenCV Pro.

## Can I get face recognition with the official AAR?

**Face detection** yes (DNN / `objdetect`). **Face recognition** (`LBPHFaceRecognizer`,
`FaceRecognizerSF`) is in the `face` contrib module — not in the official AAR.
See [examples/face-recognition-contrib](../examples/face-recognition-contrib).

## Do I need to rebuild OpenCV to get contrib modules?

Normally yes — and it's the #1 pain point devs report (CMake errors, broken NDK
toolchains, ABI mismatches, days lost). [OpenCV Pro](https://www.jokobee.com/opencv)
is a prebuilt AAR with core + all contrib, so you skip the rebuild entirely.

## Which ABIs does OpenCV Pro support?

`arm64-v8a` and `x86_64` (covers modern devices + emulators). API 24+, 16 KB page
aligned (Android 15 ready).

## Is this the official OpenCV?

No. The **official** AAR is `org.opencv:opencv` on Maven Central — use it for the
core modules (we link to it and provide examples). **OpenCV Pro** by Jokobee is a
separate, prebuilt **core + contrib** AAR for the modules the official package
doesn't ship.

## Contact

**Jokobee** · https://www.jokobee.com · contact@jokobee.com
