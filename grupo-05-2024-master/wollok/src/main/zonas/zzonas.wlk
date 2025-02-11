import zonas.noPuedenCruzarException.*
class Zona {
    const requerimiento
    const efecto
    const zonasLimitrofes // #{}
    const regionALaQuePertenece

    method regionALaQuePertenece() = regionALaQuePertenece 


    method puedenPasar(unGrupoDeGuerreros) { 
        const guerrerosEnCombate = unGrupoDeGuerreros.filter({unGuerrero => !unGuerrero.estaFueraDeCombate()})
        return requerimiento.cumpleRequerimiento(unGrupoDeGuerreros) 
        }
    
    method atravesarZona(unGrupoDeGuerreros) {
        const guerrerosEnCombate = unGrupoDeGuerreros.filter({unGuerrero => !unGuerrero.estaFueraDeCombate()})
        if(self.puedenPasar(guerrerosEnCombate))
        efecto.causarEfecto(guerrerosEnCombate)
        else
        throw new NoPuedenCruzarException()
        }

    method sonLimitrofes(otraZona) = self.limitaCon(otraZona) || otraZona.limitaCon(self)

    method limitaCon(unaZona) = zonasLimitrofes.contains(unaZona)
        
}


//la zona A es limítrofe con B si A comparte límite con B, o B comparte límite con A.

