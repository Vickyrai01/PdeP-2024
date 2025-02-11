import banda.Banda
class Rock inherits Banda {
    
    const cantidadDeSolos

    override method gastoExtra() = 10000

    override method popularidad() = 100 * cantidadDeSolos
}