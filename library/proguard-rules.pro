# OpenCV uses JNI extensively — native methods are resolved by name. Keep the
# whole org.opencv API surface and all native methods.
-keep class org.opencv.** { *; }
-keepclasseswithmembernames class * {
    native <methods>;
}
