
class EfectoVida{
    const cantidad

    method causarEfecto(unGrupoDeGuerreros)
}
class EfectoGanarVida inherits EfectoVida {
        override method causarEfecto(unGrupoDeGuerreros){
            unGrupoDeGuerreros.forEach({unGuerrero => unGuerrero.ganarVida(cantidad)})
        }
}
class EfectoPerderVida inherits EfectoVida {
        override method causarEfecto(unGrupoDeGuerreros){
            unGrupoDeGuerreros.forEach({unGuerrero => unGuerrero.perderVida(cantidad)})
        }
}