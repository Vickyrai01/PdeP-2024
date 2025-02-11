class RequerimientoItem {
    const cantidad
    const nombreDeItem

    method cumpleRequerimiento(unGrupoDeGuerreros){
        return cantidad <= unGrupoDeGuerreros.sum({unGuerrero => unGuerrero.cantidadDe(nombreDeItem)})
    }
}
