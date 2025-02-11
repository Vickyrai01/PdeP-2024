import zonas.zzonas.Zona
import zonas.requerimientoDeGuerrero.*
import zonas.requerimientoDeItem.*
import zonas.sinRequerimiento.*
import zonas.efectoDeItem.*
import zonas.efectoDeVida.*
import zonas.sinEfecto.*
import main.regiones.rohan.edoras

object gondor{
    
    const zonas = #{belfalas, lebennin, minasTirith}
    /*const camino = #{lebennin,minasTirith}

    method sePuedeRecorrer(unGuerrero) {
        return camino.all({unCamino => unCamino.sePuedeRecorrer(unGuerrero)})
    }
    method serRecorrida(unGuerrero){
        camino.forEach({unCamino => unCamino.serRecorrida(unGuerrero)})
    }*/
}

const belfalas = new Zona(regionALaQuePertenece = gondor, requerimiento = new SinRequerimiento(),efecto = new EfectoGanarItem(cantidad = 1, nombreDeItem = "panDeLembas" ), zonasLimitrofes = #{lebennin})
const lebennin = new Zona(regionALaQuePertenece = gondor, requerimiento = new RequerimientoGuerrero(criterio = criterioPoder), efecto = new SinEfecto(), zonasLimitrofes = #{minasTirith})
const minasTirith = new Zona(regionALaQuePertenece = gondor, requerimiento = new RequerimientoItem(cantidad = 10, nombreDeItem="Lemba"), efecto = new EfectoPerderVida (cantidad= 15), zonasLimitrofes = #{})

const lamedon = new Zona(regionALaQuePertenece = gondor, requerimiento = new SinRequerimiento(), efecto = new EfectoGanarVida(cantidad = 1.3),zonasLimitrofes = #{edoras,belfalas})



/*
Fagorn : edoras-estemnet
Estemnet: edoras-fangorn
Edoras: fangorn-estemnet,lamedon

lamedon: edoras,belfalas

belfalas: lebennin, lamedon
lebennin: belfalas, minas tirith
minasTirith: lebennin


*/
