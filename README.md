# OpenCV for Android — Quick Start & Pro Builds

Get OpenCV running on Android in minutes, and get the **contrib modules** the
official package leaves out.

## Quick Start (Official AAR)

The fastest way to use OpenCV on Android — one Gradle line, no NDK:

```kotlin
dependencies {
    implementation("org.opencv:opencv:5.0.0.1")
}
```

This is the **official** OpenCV package on Maven Central, maintained by the
OpenCV team (and ARM). It includes the core modules: `imgproc`, `video`, `dnn`,
`features`, `calib`, `objdetect`, `photo`, `stitching`.

→ See **[examples/](examples/)** for ready-to-use Kotlin code (image processing,
edge detection, DNN face detection).

---

## Need contrib modules?

The official AAR does **not** include the `opencv_contrib` modules. To get them,
the usual answer is *"rebuild the whole SDK from source with opencv_contrib"* —
CMake, the NDK toolchain, ABI mismatches, hours lost. If you need any of these:

| Module | What it does | Official AAR | Pro |
|---|---|:---:|:---:|
| `face` | Face recognition (`LBPHFaceRecognizer`, `FaceRecognizerSF`) | ✗ | ✅ |
| `tracking` | Advanced trackers (CSRT, KCF, MOSSE) | ✗ | ✅ |
| `aruco` | ArUco markers, ChArUco boards (AR, calibration) | ✗ | ✅ |
| `text` | Scene text detection (EAST, DB, CRNN) | ✗ | ✅ |
| `xfeatures2d` | SURF, DAISY, StarDetector, BEBLID | ✗ | ✅ |
| `ml` | Classic ML (SVM, KNN, DTrees) — **moved out of core in 5.0** | ✗ | ✅ |
| `xobjdetect` | Haar cascades, HOG — **moved out of core in 5.0** | ✗ | ✅ |
| `gapi` | Graph API — **moved out of core in 5.0** | ✗ | ✅ |
| `ximgproc`, `xphoto`, `bgsegm`, `optflow`, `img_hash`, … | 25+ more contrib modules | ✗ | ✅ |

**→ [Get OpenCV Pro](https://www.jokobee.com/opencv)** — OpenCV 5.0 + **all**
contrib modules, prebuilt AAR, one Gradle line, no rebuild. `arm64-v8a` + `x86_64`.

---

## Upgrading from OpenCV 4.x to 5.0?

Several modules **moved from core to contrib** in OpenCV 5.0. If your app uses
`ml` (SVM/KNN), Haar cascades, HOG detectors, or G-API, they are **no longer in
the official AAR** — code that worked on 4.x will fail to resolve on 5.0.

→ See the **[Migration Guide](docs/migration-opencv5.md)** for the full list and
your options.

---

## What's here

- **[examples/](examples/)** — copy-paste Kotlin: basic image processing, DNN
  face detection (official), and face **recognition** (needs Pro).
- **[docs/official-vs-contrib.md](docs/official-vs-contrib.md)** — exactly what's
  in the official AAR vs what needs contrib.
- **[docs/migration-opencv5.md](docs/migration-opencv5.md)** — 4.x → 5.0 moves.
- **[docs/faq.md](docs/faq.md)** — common questions.
- **[Wiki](../../wiki)** — Quick Start, comparison table, migration, FAQ, Pro integration.

---

## By Jokobee

A product by **[Jokobee](https://www.jokobee.com)** — we maintain prebuilt
Android native libraries so you keep shipping instead of fighting CMake.

Also from Jokobee: [FFmpegKit](https://www.jokobee.com/ffmpegkit) ·
[yt-dlp for Android](https://www.jokobee.com/ytdlp) ·
[Whisper](https://www.jokobee.com/whisper)

Contact: **contact@jokobee.com**

## License

The examples and docs in this repo are Apache-2.0 (aligned with OpenCV upstream).
OpenCV itself is Apache-2.0.
