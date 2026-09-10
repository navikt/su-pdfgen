repositories {
    gradlePluginPortal()
    mavenCentral()
}
plugins {
    kotlin("jvm") version "2.1.10"
}

val junitJupiterVersion = "5.11.4"
val kotestVersion = "6.2.4"

dependencies {
    testRuntimeOnly("org.junit.jupiter:junit-jupiter-engine:$junitJupiterVersion")

    testImplementation("org.junit.jupiter:junit-jupiter-api:$junitJupiterVersion")
    testImplementation("io.kotest:kotest-assertions-core:$kotestVersion")

}

tasks.withType<Wrapper> {
    gradleVersion = "8.13"
}

tasks.withType<Test> {
    useJUnitPlatform()
}
