import entrada.Entrada
import src.noPuedeComprarEntradaException.NoPuedeComprarEntradaException
class Asistente{
    var abono
    const historialEntradas = []
    var dinero

    method comprarEntradaPara(unaBanda, unaFecha) {
      if(!self.puedePermitirseUnaEntrada()){
            throw new NoPuedeComprarEntradaException(message = "No se tiene el dinero para comprar la entrada")
      }
      const entrada = new Entrada(banda = unaBanda, fechaDeShow = unaFecha)
      self.descontar(entrada.precio())
      historialEntradas.add(entrada)
    }

    method puedePermitirseUnaEntrada() = dinero > 0 

    method puedeComprar(unaEntrada) = dinero >= unaEntrada.precio()  

    method descontar(unaCantidad) {
      const precioFinal = abono.precioConDescuento(unaCantidad)
      dinero -= precioFinal
    }

    method entradasEnElUltimoAnio() = historialEntradas.filter({unaEntrada => unaEntrada.tieneMenosDeUnAnio()})

    method nombreDeBandas() = historialEntradas.map({unaEntrada => unaEntrada.nombreDeBanda()}).asSet()

    method gastoTotal() = historialEntradas.sum({unaEntrada => unaEntrada.precio()})

    method cantidadDeEntradasCompradas() = historialEntradas.size()

    method aumentarDescuento() = abono.aumentarDescuento()
}

