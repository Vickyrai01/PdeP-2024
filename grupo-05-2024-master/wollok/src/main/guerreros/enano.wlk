import guerrero.Guerrero
class Enano inherits Guerrero{
    const factorDePoder
    
    override method poder(){
        return vida + factorDePoder * self.poderTotalDeArmas()
    }
}