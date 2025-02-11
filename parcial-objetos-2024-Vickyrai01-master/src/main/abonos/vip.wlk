class Vip {

  var descuento

  method precioConDescuento(unaCantidad) = unaCantidad - (unaCantidad * descuento)
  
  method aumentarDescuento(){descuento += 0.01}  
}