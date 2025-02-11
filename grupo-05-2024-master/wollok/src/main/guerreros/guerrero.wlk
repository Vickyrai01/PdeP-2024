class Guerrero {
    const armas = []
    const items = []
    var vida

    method items() = items 

    method poder()
    method poderTotalDeArmas(){
     
        return armas.sum({unArma => unArma.poderDeArma()})
    }
    method cantidadDeItems(){
        return items.size()
    }
    method cantidadDe(unItem){
        return items.count({itemDelGuerrero => itemDelGuerrero == unItem})
    }
    method cantidadDeArmas() = armas.size()
    method esPoderoso() = self.poder() >= 1500
    method tieneArmas() = !(armas.isEmpty())    

    
    method ganarItem(nombreDeItem,cantidad){
        cantidad.times({iteracion => items.add(nombreDeItem)})
    }

    method perderItem(nombreDeItem,cantidad){
        cantidad.times({iteracion => items.remove(nombreDeItem)})        

    }


    method ganarVida(cantidad){
        vida *= cantidad
    }


    method perderVida(cantidad){
       vida = 0.max(vida - cantidad)
        
    }

    method estaFueraDeCombate() = vida == 0

}
