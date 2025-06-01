# KEEP rules for TensorFlow Lite
-keep class org.tensorflow.** { *; }
-dontwarn org.tensorflow.**

# Optional: keep rules for ML Kit if needed
-keep class com.google.mlkit.** { *; }
-dontwarn com.google.mlkit.**

# Optional: avoid stripping native methods (safety)
-keep class * extends java.lang.Exception
