allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// Fixed namespace injection for AGP 8.0+ compatibility
subprojects {
    plugins.configureEach {
        if (this is com.android.build.gradle.api.AndroidBasePlugin || 
            this.javaClass.name.startsWith("com.android.build.gradle")) {
            val android = project.extensions.findByName("android") as? com.android.build.gradle.BaseExtension
            android?.let {
                if (it.namespace == null) {
                    // Match specific libraries that have non-standard package names
                    if (project.name == "isar_flutter_libs") {
                        it.namespace = "dev.isar.isar_flutter_libs"
                    } else {
                        it.namespace = "com.${project.name.replace("-", ".")}"
                    }
                }
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
