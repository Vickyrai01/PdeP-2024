import productora.*
class Entrada{
    const banda 
    const fechaDeShow

    method precio() = 1000 * productora.impuesto()

    method tieneMenosDeUnAnio(){
        const hoy = new Date()
        return fechaDeShow.between(hoy.minusYears(1), hoy.year())
    }

    method nombreDeBanda() = banda.nombre()
}