import zonas.zzonas.Zona
import zonas.requerimientoDeGuerrero.*
import zonas.requerimientoDeItem.*
import zonas.sinRequerimiento.*
import zonas.efectoDeItem.*
import zonas.efectoDeVida.*
import zonas.sinEfecto.*
import main.regiones.gondor.*

object rohan{
    const zonas = #{bosqueDeFangorn, edoras, estemnet}
   
}

const bosqueDeFangorn = new Zona(regionALaQuePertenece = rohan,requerimiento = new RequerimientoGuerrero(criterio = criterioArmas), efecto = new EfectoPerderItem (cantidad =1, nombreDeItem = "CapaElfica"),zonasLimitrofes = #{edoras,estemnet})
const edoras = new Zona(regionALaQuePertenece = rohan, requerimiento = new SinRequerimiento(), efecto = new EfectoGanarItem(cantidad = 1, nombreDeItem = "botellaDeVinoCa"),zonasLimitrofes = #{})
const estemnet = new Zona(regionALaQuePertenece = rohan, requerimiento = new RequerimientoItem(cantidad = 3, nombreDeItem = "CapaElfica"), efecto = new EfectoGanarVida(cantidad = 2),zonasLimitrofes = #{edoras})




/*


*/