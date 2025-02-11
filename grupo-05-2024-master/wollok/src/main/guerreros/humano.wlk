import guerrero.Guerrero

class Humano inherits Guerrero{
    var limitadorDePoder

    override method poder(){
        return vida * self.poderTotalDeArmas() / limitadorDePoder
    }
}