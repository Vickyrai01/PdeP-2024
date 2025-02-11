class SalaDeEscape{
    const nombre 
    const dificultad

    method precio() = 10000 + self.precioExtra()
    method precioExtra() 

    method esSalaDificil() = dificultad > 7

    method nombre() = nombre

    method precioEntre(unaCantidad) = self.precio().div(unaCantidad)
}

class SalaAnime inherits SalaDeEscape{
    
    override method precioExtra() = 7000
}

class SalaHistoria inherits SalaDeEscape{

    const estaBasadaEnHechosReales

    override method precioExtra() = (31.4 * dificultad) / 100

    override method esSalaDificil() = super() && !estaBasadaEnHechosReales 
}

class SalasDeTerror inherits SalaDeEscape{

    const sustos

    override method precioExtra() {
        var precioExtra = 0 
        if(self.sonMuchosSustos()){
            precioExtra = (20 * precioExtra) / 100
        }
        return sustos
    }

    method sonMuchosSustos() = sustos > 5

    override method esSalaDificil() = super() || self.sonMuchosSustos()
}
