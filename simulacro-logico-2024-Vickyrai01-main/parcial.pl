% esPersonaje/1 nos permite saber qué personajes tendrá el juego

esPersonaje(aang).
esPersonaje(katara).
esPersonaje(zoka).
esPersonaje(appa).
esPersonaje(momo).
esPersonaje(toph).
esPersonaje(tayLee).
esPersonaje(zuko).
esPersonaje(azula).
esPersonaje(iroh).

% esElementoBasico/1 nos permite conocer los elementos básicos que pueden controlar algunos personajes

esElementoBasico(fuego).
esElementoBasico(agua).
esElementoBasico(tierra).
esElementoBasico(aire).

% elementoAvanzadoDe/2 relaciona un elemento básico con otro avanzado asociado

elementoAvanzadoDe(fuego, rayo).
elementoAvanzadoDe(agua, sangre).
elementoAvanzadoDe(tierra, metal).

% controla/2 relaciona un personaje con un elemento que controla

controla(zuko, rayo).
controla(toph, metal).
controla(katara, sangre).
controla(aang, aire).
controla(aang, agua).
controla(aang, tierra).
controla(aang, fuego).
controla(azula, rayo).
controla(iroh, rayo).

% visito/2 relaciona un personaje con un lugar que visitó. Los lugares son functores que tienen la siguiente forma:
% reinoTierra(nombreDelLugar, estructura)
% nacionDelFuego(nombreDelLugar, soldadosQueLoDefienden)
% tribuAgua(puntoCardinalDondeSeUbica)
% temploAire(puntoCardinalDondeSeUbica)

visito(aang, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(iroh, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(zuko, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(toph, reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios, enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(katara, tribuAgua(norte)).
visito(katara, tribuAgua(sur)).
visito(aang, temploAire(norte)).
visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).

lugar(Lugar):- visito(_, Lugar).

esElementoAvanzado(Elemento):- elementoAvanzadoDe(_, Elemento).

esElAvatar(Personaje):-
    esPersonaje(Personaje),
    forall(esElementoBasico(Elemento), controla(Personaje, Elemento)).

noEsMaestro(Personaje):- 
    esPersonaje(Personaje),
    not(controla(Personaje,_)).

esMaestroPrincipiante(Personaje):-
    esPersonaje(Personaje),
    forall(controla(Personaje, ElementoBasico), esElementoBasico(ElementoBasico)).

esMestroAvanzado(Personaje):- esElAvatar(Personaje).
esMaestroAvanzado(Personaje):-
    esPersonaje(Personaje),
    controla(Personaje,Elemento),
    esElementoAvanzado(Elemento).

sigueA(zuko, aang).
sigueA(Personaje, OtroPersonaje):-
    visito(Personaje,_),
    visito(OtroPersonaje,_),
    Personaje \= OtroPersonaje,
    forall(visito(Personaje, Lugar), visito(OtroPersonaje, Lugar)).

esDignoDeConocer(temploAire(_)).
esDignoDeConocer(tribuAgua(norte)).
esDignoDeConocer(Lugar):-
    lugar(Lugar),
    noTieneMuralla(Lugar).

noTieneMuralla(reinoTierra(_,Estructuras)):- not(member(muro, Estructuras)).

esPopular(Lugar):-
    lugar(Lugar),
    findall(Personaje, visito(Personaje, Lugar), Personajes),
    length(Personajes, Cantidad),
    Cantidad > 4.

esPersonaje(bumi).
controla(bumi, tierra).
visito(bumi, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
esPersonaje(suki).
visito(suki, nacionDelFuego(prision, 200)).
