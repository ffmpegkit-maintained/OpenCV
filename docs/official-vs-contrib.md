# Official AAR vs Contrib — what's included, what isn't

The official OpenCV package on Maven Central (`org.opencv:opencv:5.0.0.1`,
maintained by the OpenCV team + ARM) is great — but it ships **core modules
only**. The `opencv_contrib` modules are not included, and getting them normally
means rebuilding the whole SDK from source.

## In the official AAR (core)

| Module | Purpose |
|---|---|
| `core` | Basic structures, Mat, arithmetic |
| `imgproc` | Filtering, geometric transforms, contours, edges |
| `imgcodecs` / `videoio` | Read/write images and video |
| `video` | Motion analysis, basic tracking, optical flow (Farnebäck) |
| `calib` | Camera calibration, 3D |
| `features` | Feature detection/description (ORB, AKAZE, …) |
| `dnn` | Deep-learning inference (load ONNX/Caffe/TF models) |
| `objdetect` | Cascade/QR + **ArUco/ChArUco** detection (ArUco moved into core in 5.0) |
| `photo`, `stitching` | Computational photography, panorama |

## NOT in the official AAR (contrib — needs Pro)

| Module | Purpose | Notes |
|---|---|---|
| `face` | Face recognition (LBPH, Eigen, Fisher, `FaceRecognizerSF`) | The big one for most apps |
| `tracking` | CSRT, KCF, MOSSE, DaSiamRPN trackers | Robust object tracking |
| ~~`aruco`~~ | **Moved to core `objdetect` in 5.0** — now in the official AAR too | (no longer contrib) |
| `text` | Scene text detection & recognition (EAST, DB, CRNN) | OCR pipelines |
| `xfeatures2d` | SURF, DAISY, StarDetector, BEBLID, VGG | Extended features |
| `ml` | SVM, KNN, DTrees, Boost, ANN_MLP | **Moved out of core in 5.0** |
| `xobjdetect` | Haar cascades, HOG, Waldboost | **Moved out of core in 5.0** |
| `gapi` | Graph API (declarative pipelines) | **Moved out of core in 5.0** |
| `ximgproc` | Superpixels, edge-aware filters, thinning | |
| `xphoto` | White balance, inpainting, denoising | |
| `bgsegm` | Extra background subtraction (MOG, GMG, LSBP) | |
| `optflow` | Dense/sparse optical flow (DIS, PCAFlow, RLOF) | |
| `img_hash` | Perceptual image hashing (pHash, aHash) | Dedup, similarity |
| `wechat_qrcode` | High-accuracy QR detection/decoding | |
| `bioinspired`, `dnn_superres`, `datasets`, `fuzzy`, `hfs`, `line_descriptor`, `phase_unwrapping`, `plot`, `quality`, `reg`, `rgbd`, `saliency`, `shape`, `stereo`, `structured_light`, `surface_matching` | 16 more specialised modules | |

## The catch with OpenCV 5.0

In 5.0, **`ml`, Haar/HOG detection, and G-API were moved out of core** into
contrib. So a dev upgrading from 4.x can *lose* functionality they were using —
`org.opencv.ml.SVM`, `CascadeClassifier` with Haar, `HOGDescriptor`, `cv::gapi`
are no longer resolvable from the official AAR. The only supported way to get
them back is a build **with** `opencv_contrib`.

## The shortcut

**[OpenCV Pro](https://www.jokobee.com/opencv)** is OpenCV 5.0 built with the
full `opencv_contrib` set, as a prebuilt Android AAR (`arm64-v8a` + `x86_64`).
One Gradle line, every module above, no CMake, no NDK, no rebuild.
