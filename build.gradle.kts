repositories {
    gradlePluginPortal()
    mavenCentral()
}
plugins {
    kotlin("jvm") version "1.6.10"
}

val junitJupiterVersion = "5.9.2"
val kotestVersion = "5.5.5"
val handlebarsVersion = "4.3.1"

dependencies {
    testRuntimeOnly("org.junit.jupiter:junit-jupiter-engine:$junitJupiterVersion")

    testImplementation("org.junit.jupiter:junit-jupiter-api:$junitJupiterVersion")
    testImplementation("io.kotest:kotest-assertions-core:$kotestVersion")

    implementation("com.github.jknack:handlebars:$handlebarsVersion")
}

tasks.withType<Wrapper> {
    gradleVersion = "7.4"
}

tasks.withType<Test> {
    useJUnitPlatform()
}
