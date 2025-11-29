pluginManagement {
    val flutterSdkPath =
        run {
            val properties = java.util.Properties()
            file("local.properties").inputStream().use { properties.load(it) }
            val flutterSdkPath = properties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.11.1" apply false
    id("org.jetbrains.kotlin.android") version "2.2.20" apply false
}

include(":app")

// Fix for old plugins that don't define the namespace attribute (AGP 8+ requirement)
// This sets a fallback namespace for any library module that doesn't have one
gradle.beforeProject {
    if (this !== rootProject) {
        project.afterEvaluate {
            if (project.hasProperty("android")) {
                val androidExtension = project.extensions.findByName("android")
                if (androidExtension != null && androidExtension is com.android.build.gradle.LibraryExtension) {
                    @Suppress("UnstableApiUsage")
                    if (androidExtension.namespace.isNullOrEmpty()) {
                        // Extract package from AndroidManifest.xml
                        val manifestFile = project.file("src/main/AndroidManifest.xml")
                        if (manifestFile.exists()) {
                            val manifest = groovy.xml.XmlSlurper().parse(manifestFile)
                            val packageName = manifest.getProperty("@package")?.toString()
                            if (!packageName.isNullOrEmpty()) {
                                androidExtension.namespace = packageName
                            }
                        }
                    }
                }
            }
        }
    }
}
