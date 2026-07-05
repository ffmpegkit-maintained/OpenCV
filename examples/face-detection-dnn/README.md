# Example — Face detection with DNN (official AAR)

Face **detection** (finding faces) works with the official AAR via the `dnn` and
`objdetect` modules. Note: face **recognition** (identifying *who* it is) needs
the `face` contrib module — see
[face-recognition-contrib](../face-recognition-contrib).

## Dependency

```kotlin
implementation("org.opencv:opencv:5.0.0.1")
```

## Kotlin — YuNet face detector (built into 5.0 objdetect)

OpenCV 5.0 ships the DNN-based `FaceDetectorYN` in core `objdetect`. Download the
`face_detection_yunet_2023mar.onnx` model and place it in your assets.

```kotlin
import org.opencv.android.OpenCVLoader
import org.opencv.core.*
import org.opencv.objdetect.FaceDetectorYN

fun detectFaces(rgb: Mat, modelPath: String): Mat {
    check(OpenCVLoader.initLocal())

    val detector = FaceDetectorYN.create(modelPath, "", Size(rgb.width().toDouble(), rgb.height().toDouble()))
    val faces = Mat()
    detector.detect(rgb, faces)   // each row: x, y, w, h, landmarks..., score
    return faces
}
```

Iterate the `faces` rows to draw rectangles (`Imgproc.rectangle`). All of this is
in the official AAR — no contrib required for detection.

→ To recognise/verify identity (embeddings, LBPH), you need the `face` contrib
module: [OpenCV Pro](https://www.jokobee.com/opencv).
