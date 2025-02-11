class RequerimientoGuerrero{
    //const cantidad
    const criterio

    method cumpleRequerimiento(unGrupoDeGuerreros){
        return unGrupoDeGuerreros.any(criterio.criterioDeGuerrero())
    }
    
}
class CriterioGuerrero{
    const criterioDeGuerrero
    method criterioDeGuerrero() = criterioDeGuerrero
}


const criterioPoder = new CriterioGuerrero(criterioDeGuerrero = {unGuerrero => unGuerrero.esPoderoso() })
const criterioArmas = new CriterioGuerrero(criterioDeGuerrero = {unGuerrero => unGuerrero.tieneArmas()})