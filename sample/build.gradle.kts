plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "dev.ffmpegkit.opencv.sample"
    compileSdk = 35

    defaultConfig {
        applicationId = "dev.ffmpegkit.opencv.sample"
        minSdk = 24
        targetSdk = 35
        versionCode = 1
        versionName = "5.0.0"
        ndk { abiFilters += "arm64-v8a" }
    }

    buildTypes {
        release { isMinifyEnabled = false }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions { jvmTarget = "11" }
}

dependencies {
    // The Free OpenCV+contrib AAR is dropped into libs/ by the CI workflow
    // (downloaded from the GitHub release).
    implementation(files("libs/opencv-contrib-android-5.0.0.aar"))
    implementation("androidx.appcompat:appcompat:1.7.0")
    implementation("androidx.core:core-ktx:1.13.1")
}
