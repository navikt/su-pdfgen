import com.github.jknack.handlebars.Handlebars
import com.github.jknack.handlebars.Helper
import com.github.jknack.handlebars.io.FileTemplateLoader
import io.kotest.matchers.string.shouldContain
import org.junit.jupiter.api.Test
import java.nio.file.Paths

internal class SøkerTeksterTest {

    private val templateRoot = Paths.get("templates/supdfgen")
    private val handlebars = Handlebars(FileTemplateLoader(templateRoot.toFile())).apply {
        registerHelper("image", Helper<Any?> { _, _ -> "" })
        registerHelper("currency_no", Helper<Any?> { value, _ -> value.toString() })
    }

    @Test
    fun `viser nei når søker ikke har depositumskonto`() {
        val html = handlebars.compile("soknadPartials/formue")
            .apply(
                mapOf(
                    "eierBolig" to false,
                    "depositumsBeløp" to null,
                    "kjøretøy" to emptyList<Any>(),
                ),
            )
            .replace(Regex("\\s+"), " ")

        html shouldContain "<td>Har du en depositumskonto som leietaker?</td> <td> Nei </td>"
    }

    @Test
    fun `bruker samme tekster for søker som digital søknad`() {
        template("inntektOgPensjon") shouldContainAll listOf(
            "Hvor mye regner du med å tjene i måneden?",
            "Har du andre ytelser i NAV?",
            "Hvor mye penger får du utbetalt i måneden?",
            "Har du søkt om trygdeytelser som du ikke har fått svar på?",
            "Har du trygdeytelser fra andre land?",
            "Får du tjenestepensjon eller pensjon som ikke er fra NAV?",
        )
        template("utenlandsopphold") shouldContainAll listOf(
            "Har du reist til utlandet de siste 90 dagene?",
            "Har du planer om å reise til utlandet i de neste 12 månedene?",
        )
        template("formue") shouldContainAll listOf(
            "Boligens formueverdi",
            "Eier du andre eiendommer i Norge eller i andre land?",
            "Eiendommenes samlede verdi",
            "Hvor mye penger er det på konto?",
            "Hvor mye penger er dette verdt?",
            "Hvor mye skylder de deg?",
            "Hvor mye penger har du?",
        )
        template("oppholdstillatelseAlder") shouldContainAll listOf(
            "Er du norsk statsborger eller statsborger i et annet nordisk land?",
            "Har du statsborgerskap i andre land?",
        )
    }

    private fun template(name: String) =
        templateRoot.resolve("soknadPartials/$name.hbs").toFile().readText()

    private infix fun String.shouldContainAll(expected: List<String>) {
        expected.forEach { this shouldContain it }
    }
}
