import zonas.zzonas.*
import regiones.gondor.*
import regiones.rohan.*

class Camino{
    const zonasARecorrer

    method puedenRecorrer(unosGuerreros) = zonasARecorrer.all({unaZona => unaZona.puedenPasar(unosGuerreros)})
    
    method validarCamino(){
        //return zonasARecorrer.fold(zonasARecorrer.first(),{unaZona, otraZona => unaZona.sonLimitrofes(otraZona)})
        //return {unaZona, otraZona => unaZona.sonLimitrofes(otraZona)}.apply(zonasARecorrer)
        //TODO
    }
    method regionesAtravesadas() = zonasARecorrer.map({unaZona => unaZona.regionALaQuePertenece()}).asSet()



    /////////////////////

    /*method atravesarCamino(unosGuerreros){

        if(self.validarCamino()) unosGuerreros.forEach({unGuerrero => unGuerrero.atravesarCamino()}) else throw new Exception(message = "El camino es invalido")

    }*/
}



const caminoTP = new Camino(zonasARecorrer = [bosqueDeFangorn,edoras,lamedon,belfalas,lebennin,minasTirith])


