repositories {
    gradlePluginPortal()
    mavenCentral()
}
plugins {
    kotlin("jvm") version "1.8.21"
}

val junitJupiterVersion = "5.9.3"
val kotestVersion = "5.6.2"
val handlebarsVersion = "4.3.1"

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
