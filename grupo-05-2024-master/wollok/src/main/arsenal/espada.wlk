class Espada{
    var multiplicador
    const origen
    
    method multiplicador(unMultiplicador){
        multiplicador = 0.max(unMultiplicador.min(20))
    }
    method poderDeArma() = multiplicador * origen.valorOrigen()
}

class OrigenEspada {
  const valorOrigen
  method valorOrigen() = valorOrigen
}

const origenElfico = new OrigenEspada(valorOrigen = 30)
const origenEnano = new OrigenEspada(valorOrigen = 20)
const origenHumano = new OrigenEspada(valorOrigen = 15)

