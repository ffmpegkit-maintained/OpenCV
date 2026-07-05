# Example — Basic image processing (official AAR)

Grayscale + Gaussian blur + Canny edge detection on a bitmap. Works with the
**official** OpenCV package — no contrib needed.

## Dependency

```kotlin
// build.gradle.kts (module)
dependencies {
    implementation("org.opencv:opencv:5.0.0.1")
}
```

## Kotlin

```kotlin
import android.graphics.Bitmap
import org.opencv.android.OpenCVLoader
import org.opencv.android.Utils
import org.opencv.core.Mat
import org.opencv.imgproc.Imgproc

fun detectEdges(input: Bitmap): Bitmap {
    check(OpenCVLoader.initLocal()) { "OpenCV failed to load" }

    val src = Mat()
    Utils.bitmapToMat(input, src)

    val gray = Mat()
    Imgproc.cvtColor(src, gray, Imgproc.COLOR_RGBA2GRAY)
    Imgproc.GaussianBlur(gray, gray, org.opencv.core.Size(5.0, 5.0), 0.0)

    val edges = Mat()
    Imgproc.Canny(gray, edges, 80.0, 160.0)

    val out = Bitmap.createBitmap(edges.cols(), edges.rows(), Bitmap.Config.ARGB_8888)
    Imgproc.cvtColor(edges, edges, Imgproc.COLOR_GRAY2RGBA)
    Utils.matToBitmap(edges, out)

    src.release(); gray.release(); edges.release()
    return out
}
```

`imgproc` (used here) is part of the official core AAR. For contour analysis,
thresholding, morphology, etc. you're also covered by core.

→ Need trackers, ArUco, face recognition, or ML? Those are contrib modules —
see [OpenCV Pro](https://www.jokobee.com/opencv).
