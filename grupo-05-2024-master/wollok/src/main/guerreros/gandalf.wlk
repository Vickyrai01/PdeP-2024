/* esto tambien es del tp 1
import arsenal.baculo.*
import arsenal.glamdring.*
object gandalf{
  var property vida = 100
  var property armas = [baculo]

  method poder() {
    if (vida < 10) 
    return self.calcularPoder(300)
    else 
    return self.calcularPoder(15)
  }
  method calcularPoder(unNumero) {
      return vida * unNumero + self.poderDeLasArmas() * 2
  }

  method poderDeLasArmas() = armas.sum({unArma => unArma.poderDeArma()})
  method recorrer(unaCiudad) { unaCiudad.serRecorrida(self)}
  method puedeRecorrer(unaCiudad) = unaCiudad.sePuedeRecorrer(self)
  method tieneArmas(){
    return !armas.isEmpty()
  }
  method perderVida (cantidadVida) {
     vida = 0.max(vida - cantidadVida)
  }
  method sanarVida (cantidadVida) {
    vida = 100.min(vida + cantidadVida)
  }
}
*/

