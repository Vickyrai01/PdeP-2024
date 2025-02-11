import guerrero.Guerrero

class Elfo inherits Guerrero{
    var destrezaPropia
    var destrezaBase = 2

    method destrezaBase(unaDestreza) {
      destrezaBase = unaDestreza
    }
    
    override method poder() {
        return vida + self.poderTotalDeArmas() * (destrezaBase + destrezaPropia)
    }

}