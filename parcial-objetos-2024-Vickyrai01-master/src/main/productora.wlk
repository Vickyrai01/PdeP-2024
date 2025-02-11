object productora {
    const asistentes = #{}
    const bandas = #{}
    var impuesto = 1.1

    method impuesto() = impuesto

    method gananciaTotal() = self.precioEntradas() - self.presupuestoDeBandas()

    method precioEntradas() =  asistentes.sum({unAsistente => unAsistente.gastoTotal()})

    method presupuestoDeBandas() = bandas.sum({unaBanda => unaBanda.presupuesto()})

    method entradasVendidas() = asistentes.sum({unAsistente => unAsistente.cantidadDeEntradasCompradas()})

    method bandaMasPopular() = bandas.max({unaBanda => unaBanda.popularidad()}) 

    method bonificarAsistentesVip() {
      asistentes.forEach({unAsistente => unAsistente.aumentarDescuento()})
    }

}