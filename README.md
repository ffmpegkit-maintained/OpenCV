# OpenCV + Contrib for Android

[![Maven Central](https://img.shields.io/maven-central/v/dev.ffmpegkit-maintained/opencv-contrib-android)](https://central.sonatype.com/artifact/dev.ffmpegkit-maintained/opencv-contrib-android)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![Website](https://img.shields.io/badge/website-jokobee.com-blue.svg)](https://www.jokobee.com)

**The `opencv_contrib` modules the official AAR doesn't ship — prebuilt, one Gradle
line, no NDK, no rebuild.**

The official OpenCV package (`org.opencv:opencv`, maintained by the OpenCV team) is
great but ships **core only**. To get contrib modules — face recognition, tracking,
ArUco, text detection — you normally have to rebuild the whole SDK from source
(CMake, NDK, hours lost). We prebuild them for you.

## Install (Free)

```kotlin
dependencies {
    implementation("dev.ffmpegkit-maintained:opencv-contrib-android:5.0.0")
}
```

OpenCV 5.0 **core + the most-requested contrib modules** — `arm64-v8a`:

| Included (Free) | |
|---|---|
| Core | core, imgproc, video, calib, features, dnn, objdetect (incl. **ArUco** in 5.0), photo |
| **Contrib** | **face** (recognition), **tracking** (CSRT/KCF/MOSSE), **text** (scene text) |

→ See **[examples/](examples/)** for ready-to-use Kotlin (edge detection, DNN face
detection, **face recognition**).

## Free vs Pro vs Official

| | Official AAR | **Free** (this) | **Pro** |
|---|:---:|:---:|:---:|
| Core modules | ✅ | ✅ | ✅ |
| face, tracking, text (contrib) | ✗ | ✅ | ✅ |
| **Full contrib** (ml, Haar/HOG, gapi, ximgproc, +25) | ✗ | ✗ | ✅ |
| Optimised DNN + pre-integrated models (face, OCR, doc-scan) | ✗ | ✗ | ✅ |
| ABI | arm64-v8a | arm64-v8a | arm64-v8a + x86_64 |
| Channel | Maven Central | Maven Central / JitPack | Gumroad |
| Price | Free | **Free** | $24 / $62 team |

**→ [Get OpenCV Pro](https://www.jokobee.com/opencv)** for the complete contrib set,
optimised DNN builds, and pre-integrated models (document scanning, face, OCR).

## Upgrading from OpenCV 4.x to 5.0?

`ml`, Haar/HOG (`xobjdetect`), and G-API moved **out of core** into contrib in 5.0 —
so the official AAR no longer resolves them. Those are in **Pro**. See the
[Migration Guide](docs/migration-opencv5.md).

## What's here

- **[examples/](examples/)** — copy-paste Kotlin (basic imgproc, DNN face detection,
  face recognition).
- **[docs/official-vs-contrib.md](docs/official-vs-contrib.md)** · [migration](docs/migration-opencv5.md) · [faq](docs/faq.md)
- **[Wiki](../../wiki)** — Quick Start, comparison, migration, FAQ, Pro integration.

## By Jokobee

Prebuilt Android native libraries so you keep shipping instead of fighting CMake.
Also: [FFmpegKit](https://www.jokobee.com/ffmpegkit) ·
[yt-dlp](https://www.jokobee.com/ytdlp) · [Whisper](https://www.jokobee.com/whisper)

**[Jokobee](https://www.jokobee.com)** · contact@jokobee.com · Apache-2.0
(same as OpenCV upstream).
