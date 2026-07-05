plugins {
    id("com.android.library")
    id("com.vanniktech.maven.publish")
}

// Free tier: repackages the OpenCV 5.0 + SELECTED contrib build output (core +
// face, tracking, aruco, text) into `opencv-contrib-android`, published to Maven
// Central + JitPack. The build script writes:
//   - Java wrappers → library/src/main/java/   (org.opencv.*)
//   - native libs   → library/src/main/jniLibs/arm64-v8a/*.so

android {
    namespace = "org.opencv"
    compileSdk = 35
    ndkVersion = "27.2.12479018" // NDK r27c

    defaultConfig {
        minSdk = 24
        consumerProguardFiles("proguard-rules.pro")
        ndk { abiFilters += "arm64-v8a" }   // Free = arm64-v8a only
    }

    buildTypes {
        release { isMinifyEnabled = false }
    }

    packaging {
        jniLibs { useLegacyPackaging = false }  // keep .so 16 KB aligned
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
}

mavenPublishing {
    coordinates("dev.ffmpegkit-maintained", "opencv-contrib-android", providers.gradleProperty("VERSION").get())

    // Sign only when a GPG key is present (Maven Central); JitPack/local skip it.
    if (providers.gradleProperty("signingInMemoryKey").isPresent) {
        signAllPublications()
    }
    publishToMavenCentral(automaticRelease = true)

    pom {
        name = "opencv-contrib-android"
        description = "OpenCV 5.0 + selected contrib modules (face, tracking, aruco, text) prebuilt for Android — the contrib the official AAR doesn't ship. arm64-v8a. Full contrib in the Pro build."
        inceptionYear = "2026"
        url = "https://github.com/ffmpegkit-maintained/OpenCV"
        licenses {
            license {
                name = "Apache License 2.0"
                url = "https://github.com/ffmpegkit-maintained/OpenCV/blob/main/LICENSE"
                distribution = "repo"
            }
        }
        developers {
            developer {
                id = "lucquebec"; name = "Luc Côté"; url = "https://www.jokobee.com"
                email = "contact@jokobee.com"; organization = "Jokobee"; organizationUrl = "https://www.jokobee.com"
            }
        }
        scm {
            url = "https://github.com/ffmpegkit-maintained/OpenCV"
            connection = "scm:git:git://github.com/ffmpegkit-maintained/OpenCV.git"
            developerConnection = "scm:git:ssh://git@github.com/ffmpegkit-maintained/OpenCV.git"
        }
    }
}
