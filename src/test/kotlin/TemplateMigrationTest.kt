import kotlin.io.path.extension
import kotlin.io.path.isRegularFile
import kotlin.io.path.name
import kotlin.io.path.walk
import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test
import java.nio.file.Path

internal class TemplateMigrationTest {
    private val templates = Path.of("templates/supdfgen")

    @Test
    fun `all API templates are Typst files with injected request data`() {
        val namesWithData = Path.of("data/supdfgen").walk()
            .filter { it.isRegularFile() && it.extension == "json" }
            .map { it.name.removeSuffix(".json") }
            .toSet()
        val typstNames = templates.walk()
            .filter { it.isRegularFile() && it.extension == "typ" }
            .map { it.name.removeSuffix(".typ") }
            .toSet()
        assertTrue(namesWithData.all { it in typstNames })
        typstNames.forEach { name ->
            assertTrue(templates.resolve("$name.typ").toFile().readText().contains("/data/supdfgen/$name.json"))
        }
    }

    @Test
    fun `Handlebars templates are absent`() {
        assertFalse(templates.walk().any { it.isRegularFile() && it.extension == "hbs" })
    }

    @Test
    fun `Typst helpers preserve currency and date formatting`() {
        val helpers = templates.resolve("lib.typinc").toFile().readText()
        assertTrue(helpers.contains("#let currency"))
        assertTrue(helpers.contains("#let date_no"))
        assertTrue(helpers.contains("#let capitalize"))
    }
}
