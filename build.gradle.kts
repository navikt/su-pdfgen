repositories {
    gradlePluginPortal()
    mavenCentral()
}
plugins {
    kotlin("jvm") version "2.0.0"
}

val junitJupiterVersion = "5.10.3"
val kotestVersion = "5.9.0"
val handlebarsVersion = "4.4.0"

dependencies {
    testRuntimeOnly("org.junit.jupiter:junit-jupiter-engine:$junitJupiterVersion")

    testImplementation("org.junit.jupiter:junit-jupiter-api:$junitJupiterVersion")
    testImplementation("io.kotest:kotest-assertions-core:$kotestVersion")

    implementation("com.github.jknack:handlebars:$handlebarsVersion")
}

tasks.withType<Wrapper> {
    gradleVersion = "8.1.1"
}

tasks.withType<Test> {
    useJUnitPlatform()
}
