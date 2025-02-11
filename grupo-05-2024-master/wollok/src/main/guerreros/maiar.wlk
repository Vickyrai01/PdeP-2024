import guerrero.Guerrero
class Maiar inherits Guerrero{
    var factorPoderBasico
    var factorPoderAmenaza

    method factorPoderBasico(unPoder) {
      factorPoderBasico = unPoder
    }

    method factorPoderAmenaza(unPoder) {
      factorPoderAmenaza = unPoder
    }

    method estaBajoAmenaza() = vida <= 10

    method factorActual() {
        if (self.estaBajoAmenaza()) { //💋
            return factorPoderAmenaza
        } else return factorPoderBasico
    }
    
    override method poder(){ 
        return vida * self.factorActual() + self.poderTotalDeArmas()*2
    }
}