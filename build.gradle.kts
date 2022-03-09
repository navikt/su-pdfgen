repositories {
    gradlePluginPortal()
    mavenCentral()
}
plugins {
    kotlin("jvm") version "1.6.10"
}

val junitJupiterVersion = "5.8.2"
val kotestVersion = "5.1.0"

dependencies {
    testRuntimeOnly("org.junit.jupiter:junit-jupiter-engine:$junitJupiterVersion")

    testImplementation("org.junit.jupiter:junit-jupiter-api:$junitJupiterVersion")
    testImplementation("org.junit.jupiter:junit-jupiter-params:$junitJupiterVersion")
    testImplementation("io.kotest:kotest-assertions-core:$kotestVersion")
    testImplementation("io.kotest:kotest-assertions-json:$kotestVersion")
    testImplementation("io.kotest.extensions:kotest-assertions-arrow:1.2.3")
    testImplementation("io.kotest:kotest-extensions:$kotestVersion")
}

tasks.withType<Wrapper> {
    gradleVersion = "7.4"
}

tasks.withType<Test> {
    useJUnitPlatform()
}
