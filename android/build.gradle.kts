
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
    val newSubprojectBuildDir: Directory =
        newBuildDir.dir(project.name)

    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

// Match Kotlin target with each plugin's Java target
subprojects {
    val isTfliteFlutter = project.name == "tflite_flutter"

    tasks.withType<org.jetbrains.kotlin.gradle.tasks.KotlinCompile>()
        .configureEach {
            compilerOptions {
                jvmTarget.set(
                    if (isTfliteFlutter) {
                        org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_11
                    } else {
                        org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
                    }
                )
            }
        }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
