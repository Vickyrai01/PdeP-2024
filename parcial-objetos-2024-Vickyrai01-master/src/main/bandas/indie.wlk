import banda.Banda
class Indie inherits Banda{

    const cantInstrumentos

    method tamanioDeNombre() = nombre.lenght()

    override method gastoExtra() = 500 * cantInstrumentos

    override method popularidad() = 3.14 * self.tamanioDeNombre()

}