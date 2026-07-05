# Example — Face recognition (requires OpenCV **Pro**)

Face **recognition** — matching a face to an identity — uses the `face` contrib
module (`FaceRecognizerSF`, `LBPHFaceRecognizer`). This module is **not** in the
official AAR. This example shows the code; to run it you need
**[OpenCV Pro](https://www.jokobee.com/opencv)** (core + contrib prebuilt).

## Dependency (Pro)

```kotlin
// OpenCV Pro AAR (from Jokobee) — drop the .aar in app/libs/
dependencies {
    implementation(files("libs/opencv-android-pro-5.0.0.aar"))
}
```

## Kotlin — SFace recognition (embeddings + cosine match)

```kotlin
import org.opencv.core.*
import org.opencv.face.FaceRecognizerSF   // ⟵ contrib module: needs Pro

class FaceMatcher(modelPath: String) {
    private val sf = FaceRecognizerSF.create(modelPath, "")

    // alignedFace = a face crop already aligned (e.g. from FaceDetectorYN landmarks)
    fun embed(alignedFace: Mat): Mat {
        val feature = Mat()
        sf.feature(alignedFace, feature)
        return feature.clone()
    }

    fun isSamePerson(a: Mat, b: Mat, threshold: Double = 0.363): Boolean {
        val score = sf.match(a, b, FaceRecognizerSF.FR_COSINE)
        return score >= threshold   // cosine: higher = more similar
    }
}
```

`org.opencv.face.*` will not resolve with the official AAR — that's the whole
point. With OpenCV Pro it's just there, one Gradle line, no rebuild.

Other contrib-only recognisers: `LBPHFaceRecognizer`, `EigenFaceRecognizer`,
`FisherFaceRecognizer` (all in `org.opencv.face`).

→ **[Get OpenCV Pro](https://www.jokobee.com/opencv)** — $24 individual / $62 team.
