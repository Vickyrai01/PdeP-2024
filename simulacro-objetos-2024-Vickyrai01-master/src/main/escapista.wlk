class Escapista{
    var maestria
    const salasCompletadas = []
    var saldo 

    method maestria(unaMaestria) {
      maestria = unaMaestria
    }

    method puedeSalirDe(unaSala) = maestria.puedeSalirDe(unaSala, self)

    method completoMuchasSalas() = salasCompletadas.size() >= 6

    method subirDeNivel(){        
        if(self.completoMuchasSalas()){
            maestria.subirDeNivel(self)
        }
    }

    method salasReFaciles() = salasCompletadas.map({unaSala => unaSala.nombre()}).asSet()

    method puedePagar(unaCantidad) = saldo >= unaCantidad 
    method saldo() = saldo 

    method descontar(unaCantidad) {
      saldo -= unaCantidad
    }

    method completar(unaSala) {
        salasCompletadas.add(unaSala)
    }
}

object amateur{

    method puedeSalirDe(unaSala, unaPersona) = !unaSala.esSalaDificil() && unaPersona.hizoMuchasSalas()

    method subirDeNivel(unaPersona) {
        unaPersona.maestria(profesional)
    }
}
object profesional{

    method puedeSalirDe(unaSala, unaPersona) = true

    method subirDeNivel(unaPersona) {}

}

