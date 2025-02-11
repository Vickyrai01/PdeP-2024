import guerrero.Guerrero
object tom inherits Guerrero (vida = 1000000000){

  method vida() = vida
  method recorrer(unaCiudad) {}
  method puedeRecorrer(unaCiudad) = true
  override method poder(){
    return 10000000
  }
}
