import com.github.jknack.handlebars.Handlebars
import com.github.jknack.handlebars.Helper
import com.github.jknack.handlebars.io.FileTemplateLoader
import io.kotest.matchers.string.shouldContain
import org.junit.jupiter.api.Test
import java.nio.file.Paths

internal class EpsFormueTest {

    private val handlebars = Handlebars(FileTemplateLoader(Paths.get("templates/supdfgen/").toFile())).apply {
        registerHelper("image", Helper<Any?> { _, _ -> "" })
        registerHelper("currency_no", Helper<Any?> { value, _ -> value.toString() })
    }

    @Test
    fun `viser formuesopplysninger for ektefelle eller samboer`() {
        val formue = mapOf(
            "eierBolig" to false,
            "depositumsBeløp" to null,
            "verdiPåEiendom" to 100000,
            "eiendomBrukesTil" to "FERIE",
            "kjøretøy" to emptyList<Any>(),
            "innskuddsBeløp" to null,
            "verdipapirBeløp" to null,
            "skylderNoenMegPengerBeløp" to null,
            "kontanterBeløp" to null,
        )

        val html = handlebars.compile("soknadPartials/epsFormue")
            .apply(formue)
            .replace(Regex("\\s+"), " ")

        html shouldContain
            "<td>Har ektefelle/samboer depositumskonto som leietaker?</td> <td> Nei </td>"
        html shouldContain
            "<td>Eier ektefelle/samboer andre eiendommer i Norge eller i andre land?</td> <td> Ja </td>"
        html shouldContain "<td>Eiendommenes samlede verdi</td> <td>100000 kr</td>"
        html shouldContain "<td>Hva brukes eiendommene til?</td> <td>FERIE</td>"
        html shouldContain
            "<td>Eier ektefelle/samboer bil, campingvogn eller andre kjøretøy?</td> <td> Nei </td>"
    }
}
