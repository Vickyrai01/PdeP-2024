
class EfectoItem{
    const cantidad
    const nombreDeItem

    method causarEfecto(unGrupoDeGuerreros)
}
class EfectoGanarItem inherits EfectoItem {
        override method causarEfecto(unGrupoDeGuerreros){
            unGrupoDeGuerreros.forEach({unGuerrero => unGuerrero.ganarItem(nombreDeItem,cantidad)})
        }
}
class EfectoPerderItem inherits EfectoItem {
        override method causarEfecto(unGrupoDeGuerreros){
            unGrupoDeGuerreros.forEach({unGuerrero => unGuerrero.perderItem(nombreDeItem,cantidad)})
        }
}