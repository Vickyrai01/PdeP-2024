class Grupo {
    const amigues = #{}

    method puedeSalirDe(unaSala) = amigues.any({unaPersona => unaPersona.puedeSalirDe(unaSala)})

    method escaparDe(unaSala){
        self.pagar(unaSala)
        amigues.forEach({unaPersona => unaPersona.completar(unaSala)})
    }

    method pagar(unaSala) {
        if(!self.puedenPagar(unaSala)){
            throw new NoPuedenPagarLaSalaException(message ="El grupo no tiene el dinero suficiente para pagar la sala")
        }
        //TODO descontar los morlacos a cada uno
        amigues.forEach({unaPersona => unaPersona.descontar(self.montoPorPersonaDe(unaSala))})
    }

    method puedenPagar(unaSala) =  self.todosPuedenPagar(unaSala) || self.quienesTienenPlataPuedenPagar(unaSala)

    method todosPuedenPagar(unaSala) = amigues.all({unaPersona => unaPersona.puedePagar(self.montoPorPersonaDe(unaSala))})

    method montoPorPersonaDe(unaSala) = unaSala.precioEntre(amigues.size())

    method quienesTienenPlataPuedenPagar(unaSala) = self.dineroTotalDe(self.quienesPuedenPagar(unaSala)) >= unaSala.precio()

    method quienesPuedenPagar(unaSala) =  amigues.filter({unaPersona => unaPersona.puedePagar(self.montoPorPersonaDe(unaSala))})

    method dineroTotalDe(unasPersonas) = unasPersonas.map({unaPersona => unaPersona.saldo()}).sum()
}

class NoPuedenPagarLaSalaException inherits Exception{

}
