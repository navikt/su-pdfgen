import com.github.jknack.handlebars.Handlebars
import com.github.jknack.handlebars.io.FileTemplateLoader
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.Test
import java.nio.file.Paths

internal class VisAvslagsparagraferTest {

    private val handlebars = Handlebars(FileTemplateLoader(Paths.get("templates/supdfgen/").toFile()))

    @Test
    fun `viser kun enkelt paragraftegn dersom kun en avslagsgrunn`() {
        handlebars.compile("partials/visAvslagsparagrafer").apply(listOf("1")).trim() shouldBe "§ 1"
    }

    @Test
    fun `viser dobbelt paragraftegn dersom flere avslagsgrunner`() {
        handlebars.compile("partials/visAvslagsparagrafer").apply(listOf("1", "2", "3")).trim() shouldBe "§§ 1, 2 og 3"
    }
}