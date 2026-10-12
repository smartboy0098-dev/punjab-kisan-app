allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = layout.buildDirectory.dir("../../build").get().asFile

subprojects {
    project.buildDir = rootProject.buildDir.resolve(project.name)
    
    // 🚨 ULTIMATE BYPASS ENGINE: Explicitly telling compiler to override any dynamic NDK target check requirements
    afterEvaluate {
        if (project.plugins.hasPlugin("com.android.application") || project.plugins.hasPlugin("com.android.library")) {
            val android = project.extensions.findByName("android") as? com.android.build.gradle.BaseExtension
            android?.apply {
                ndkVersion = ""
                buildTypes.forEach { it.signingConfig = signingConfigs.findByName("debug") }
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}
