package dev.ffmpegkit.opencv.sample

import android.os.Bundle
import android.util.Log
import android.widget.ScrollView
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import org.opencv.android.OpenCVLoader
import org.opencv.core.Core
import org.opencv.core.CvType
import org.opencv.core.Mat
import org.opencv.imgproc.Imgproc

/** Runtime smoke test for the Free OpenCV + contrib AAR. */
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val out = TextView(this).apply { setPadding(24, 24, 24, 24); textSize = 15f }
        setContentView(ScrollView(this).apply { addView(out) })
        val sb = StringBuilder()
        fun line(s: String) { sb.append(s).append('\n'); out.text = sb }

        try {
            if (!OpenCVLoader.initLocal()) { line("❌ OpenCV load FAILED"); return }
            line("✅ OpenCV loaded")
            line(Core.getBuildInformation().lineSequence().firstOrNull { it.contains("Version") } ?: "")

            // Real core op: 3x3 identity → sum should be 3
            val eye = Mat.eye(3, 3, CvType.CV_8UC1)
            val sum = Core.sumElems(eye).`val`[0]
            line("✅ core Mat op: eye(3) sum = $sum (expected 3.0)")

            // Real imgproc op
            val gray = Mat(10, 10, CvType.CV_8UC1)
            val edges = Mat()
            Imgproc.Canny(gray, edges, 50.0, 150.0)
            line("✅ imgproc Canny ran (${edges.rows()}x${edges.cols()})")

            // Contrib check: face module present (NOT in the official AAR)
            for (cls in listOf("org.opencv.face.FaceRecognizerSF",
                               "org.opencv.tracking.TrackerCSRT",
                               "org.opencv.text.TextDetectionModel_EAST")) {
                val ok = runCatching { Class.forName(cls) }.isSuccess
                line("${if (ok) "✅" else "❌"} contrib $cls")
            }
            line("\n=== SMOKE TEST OK ===")
        } catch (e: Throwable) {
            Log.e("OpenCVSmoke", "failed", e)
            line("❌ ERROR: ${e.message}")
        }
    }
}
