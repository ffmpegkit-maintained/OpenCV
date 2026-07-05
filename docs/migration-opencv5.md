# Migrating from OpenCV 4.x to 5.0 on Android

OpenCV 5.0 is a major release. Beyond API cleanups, **several modules moved from
core to `opencv_contrib`** — which matters a lot on Android, because the official
AAR (`org.opencv:opencv:5.0.0.1`) ships **core only**. Code that compiled against
the 4.x AAR may fail to resolve on 5.0.

## Modules that moved core → contrib in 5.0

| Was in 4.x core | In 5.0 it's in… | Affected APIs (examples) |
|---|---|---|
| Classic ML | `ml` (contrib) | `SVM`, `KNearest`, `DTrees`, `Boost`, `ANN_MLP`, `RTrees` |
| Haar / HOG detection | `xobjdetect` (contrib) | Haar `CascadeClassifier`, `HOGDescriptor` |
| Graph API | `gapi` (contrib) | `cv::gapi::*` pipelines |

> `objdetect` still exists in 5.0 core (QR, ArUco-lite, DNN-based face/detection),
> but the **Haar cascade** and **HOG** paths were split out into `xobjdetect`.

## Symptoms you'll see

- `error: cannot find symbol` / `Unresolved reference` for `org.opencv.ml.*`,
  `HOGDescriptor`, or Haar-based `CascadeClassifier` usage.
- Runtime `UnsatisfiedLinkError` if you mix a 4.x native lib with 5.0 Java.
- Model/classifier XML files that no longer load because the module is absent.

## Your options

1. **Stay on the official AAR** and drop the moved features (if you don't need them).
2. **Rebuild the SDK** from `opencv` + `opencv_contrib` 5.0 yourself — the
   supported-but-painful route (CMake, NDK r27c, `build_sdk.py --extra_modules_path`,
   30–60 min builds, ABI juggling).
3. **Use [OpenCV Pro](https://www.jokobee.com/opencv)** — a prebuilt AAR that
   already bundles core + all of contrib for 5.0. Swap one Gradle line and your
   `ml`, Haar/HOG, and G-API code resolves again. `arm64-v8a` + `x86_64`.

## Quick mapping

```kotlin
// 4.x (official AAR): worked
import org.opencv.ml.SVM              // ❌ not in 5.0 official AAR
import org.opencv.objdetect.CascadeClassifier  // Haar path ❌ in 5.0 official AAR

// 5.0 with OpenCV Pro (contrib included): works again
import org.opencv.ml.SVM              // ✅
import org.opencv.xobjdetect.*        // ✅ Haar / HOG
```

See also **[Official vs Contrib](official-vs-contrib.md)** for the full module list.
