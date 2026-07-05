# Example — Face recognition (`face` contrib module)

Face **recognition** — matching a face to an identity — uses the `face` contrib
module (`FaceRecognizerSF`, `LBPHFaceRecognizer`). It's **not** in the official
AAR, but it **is** in our Free build (`face` is one of the selected contrib
modules).

## Dependency (Free)

```kotlin
dependencies {
    implementation("dev.ffmpegkit-maintained:opencv-contrib-android:5.0.0")
}
```

> Need the *full* contrib set (ml, Haar/HOG, gapi, ximgproc, …), optimised DNN, or
> pre-integrated models? That's [OpenCV Pro](https://www.jokobee.com/opencv).

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
