plugins {
    id("com.android.library") version "8.7.3" apply false
    id("org.jetbrains.kotlin.android") version "2.0.21" apply false
    id("com.vanniktech.maven.publish") version "0.34.0" apply false
}

// JitPack builds `publishToMavenLocal` at the root — delegate to :library.
tasks.register("publishToMavenLocal") { dependsOn(":library:publishToMavenLocal") }
