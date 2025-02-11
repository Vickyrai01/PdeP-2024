import Text.Show.Functions

data Ciudad = UnaCiudad {
nombre :: String,
anioDeFundacion :: Int,
atraccionesPrincipales :: [Atraccion],
costoDeVida :: Int
} deriving Show

type Atraccion = String

-------- Casos de prueba a implementar
baradero :: Ciudad
baradero = UnaCiudad "Baradero" 1615 ["Parque del Este", "Museo Alejandro Barbich"] 150

nullish :: Ciudad
nullish = UnaCiudad "Nullish" 1832 [] 140

caletaOlivia :: Ciudad
caletaOlivia = UnaCiudad "Caleta Olivia" 1901 ["El Gorosito","Faro Costanera"] 120

azul :: Ciudad
azul = UnaCiudad "Azul" 1832 ["Teatro Espanol", "Parque Municipal Sarmiento", "Costanera Cacique Catriel"] 190

--------- Punto 1: Valor de una ciudad

valorCiudad :: Ciudad ->Int
valorCiudad unaCiudad
    | esMenorA1800 unaCiudad = calcularValorDeUnaCiudadMuyVieja unaCiudad
    | esCiudadSinAtracciones unaCiudad = multiplicarCostoDeVida 2 unaCiudad
    | otherwise = multiplicarCostoDeVida 3 unaCiudad

esMenorA1800 :: Ciudad -> Bool
esMenorA1800 unaCiudad = anioDeFundacion unaCiudad < 1800

esCiudadSinAtracciones :: Ciudad -> Bool
esCiudadSinAtracciones = null . atraccionesPrincipales

calcularValorDeUnaCiudadMuyVieja :: Ciudad -> Int
calcularValorDeUnaCiudadMuyVieja =(5*) . (1800 -) . anioDeFundacion

multiplicarCostoDeVida :: Int -> Ciudad ->Int
multiplicarCostoDeVida unNumero = (*unNumero) . costoDeVida

----------Punto 2: Características de las ciudades

-------- Alguna atracción copada
isVowel :: Char -> Bool
isVowel character = character `elem` "aeiouAEIOU"

algunaAtraccionCopada :: Ciudad -> Bool
algunaAtraccionCopada = any (isVowel.head) .atraccionesPrincipales

-------- Ciudad Sobria 
esCiudadSobria :: Int -> Ciudad -> Bool
esCiudadSobria numeroDeLetras = all  ((>numeroDeLetras) . length).atraccionesPrincipales

----------Ciudad con Nombre raro 
ciudadConNombreRaro :: Ciudad -> Bool
ciudadConNombreRaro = (<5) . length . nombre

----------Punto 3: Eventos

type Evento = Ciudad -> Ciudad

--Agregar atraccion 
agregarAtraccion :: Atraccion -> Evento
agregarAtraccion unaAtraccion =  sumarAtraccion unaAtraccion . modificarCostoDeVida (operarPorcentaje (+) 20)

sumarAtraccion :: Atraccion -> Ciudad -> Ciudad
sumarAtraccion unaAtraccion unaCiudad = unaCiudad{atraccionesPrincipales = atraccionesPrincipales unaCiudad ++ [unaAtraccion]}


-------- Crisis
crisis :: Evento
crisis = quitarUltimaAtraccion . modificarCostoDeVida (operarPorcentaje subtract 10)

quitarUltimaAtraccion :: Ciudad -> Ciudad
quitarUltimaAtraccion unaCiudad
    |esCiudadSinAtracciones unaCiudad = unaCiudad
    |otherwise = unaCiudad {atraccionesPrincipales = filter (not.esLaUltimaAtraccion unaCiudad) . atraccionesPrincipales $ unaCiudad}

esLaUltimaAtraccion :: Ciudad -> Atraccion -> Bool
esLaUltimaAtraccion unaCiudad unaAtraccion = unaAtraccion == (last . atraccionesPrincipales) unaCiudad

modificarCostoDeVida :: (Int -> Int) -> Ciudad -> Ciudad
modificarCostoDeVida unaFuncion unaCiudad = unaCiudad{costoDeVida = unaFuncion . costoDeVida $ unaCiudad}

operarPorcentaje :: (Int -> Int -> Int) -> Int -> Int -> Int
operarPorcentaje unaFuncion porcentaje unNumero = unaFuncion (div (porcentaje * unNumero) 100) unNumero

-------- Remodelación

remodelarCiudad :: Int -> Evento
remodelarCiudad unPorcentaje = modificarNombre "New ".modificarCostoDeVida (operarPorcentaje (+) unPorcentaje)

modificarNombre :: String -> Ciudad -> Ciudad
modificarNombre unString unaCiudad = unaCiudad { nombre = unString ++ nombre unaCiudad }

--------- Reevaluación 

reevaluacion :: Int -> Evento
reevaluacion cantidadDeLetras unaCiudad
    | esCiudadSobria cantidadDeLetras unaCiudad = modificarCostoDeVida (operarPorcentaje (+) 10) unaCiudad
    | otherwise = modificarCostoDeVida (subtract 3) unaCiudad

----------Punto 4: La transformación no para

-- reevaluacion 10 . crisis . remodelarCiudad 10 . agregarAtraccion "una Atraccion" $ azul
-- Utilizamos 10 y azul como valores de ejemplo :)

--------------------------------------- Entrega 2

data Anio = UnAnio {
    anio           :: Int,
    serieDeEventos :: [Evento]
} deriving Show

-------- Casos de prueba a implementar
anio2021 :: Anio
anio2021 = UnAnio 2021 [crisis, agregarAtraccion "Playa"]

anio2022 :: Anio
anio2022 = UnAnio 2022  [crisis, remodelarCiudad 5, reevaluacion 7]

anio2015 :: Anio
anio2015 = UnAnio 2015  []

anio2023 :: Anio
anio2023 = UnAnio 2023 [crisis, agregarAtraccion "Parque", remodelarCiudad 10, remodelarCiudad 20]

-----------Punto 1  Un año para recordar

------------1.1 Los años pasan

aplicarAnioALaCiudad :: Ciudad -> Anio -> Ciudad
aplicarAnioALaCiudad unaCiudad unAnio = foldr ($) unaCiudad (serieDeEventos unAnio)

----------------1.2  Algo mejor

algoMejor :: Ciudad -> Evento -> (Ciudad -> Int) -> Bool
algoMejor unaCiudad unEvento unCriterio = (unCriterio.unEvento $ unaCiudad) > unCriterio unaCiudad

cantidadDeAtracciones :: Ciudad -> Int
cantidadDeAtracciones = length.atraccionesPrincipales

----------------1.3 Costo de vida que suba
costoDeVidaQueSuba :: Anio -> Ciudad -> Ciudad
costoDeVidaQueSuba unAnio  unaCiudad = aplicarAnioALaCiudad unaCiudad (filtrarEventos unAnio unaCiudad)

filtrarEventos :: Anio -> Ciudad -> Anio
filtrarEventos unAnio unaCiudad = modificarEventos (flip (algoMejor unaCiudad) costoDeVida) unAnio

modificarEventos :: (Evento -> Bool) -> Anio -> Anio
modificarEventos unaFuncion unAnio = unAnio {serieDeEventos = filter unaFuncion . serieDeEventos $ unAnio}
----------------1.4 Costo de vida que baje

costoDeVidaQueBaje :: Anio->Ciudad->Ciudad
costoDeVidaQueBaje unAnio unaCiudad = aplicarAnioALaCiudad unaCiudad (costoDeVidaBaja unAnio unaCiudad)

costoDeVidaBaja :: Anio->Ciudad->Anio
costoDeVidaBaja unAnio unaCiudad = modificarEventos (esCostoDeVidaBaja unaCiudad) unAnio

esCostoDeVidaBaja :: Ciudad->Evento->Bool
esCostoDeVidaBaja unaCiudad unEvento= not (algoMejor unaCiudad unEvento costoDeVida)

----------------1.5 Valor que suba 

valorQueSuba :: Anio -> Evento
valorQueSuba unAnio unaCiudad = aplicarAnioALaCiudad unaCiudad (eventosQueSuben unAnio unaCiudad)

eventosQueSuben :: Anio -> Ciudad -> Anio
eventosQueSuben unAnio unaCiudad = modificarEventos (algunaCosaMejor unaCiudad) unAnio

algunaCosaMejor :: Ciudad -> Evento -> Bool
algunaCosaMejor unaCiudad unEvento = algoMejor unaCiudad unEvento costoDeVida || algoMejor unaCiudad unEvento cantidadDeAtracciones

-----------------------Punto 2: Funciones a la orden

---------------2.1 Eventos ordenados 

eventosOrdenados :: Anio -> Ciudad -> Bool
eventosOrdenados (UnAnio anio [evento]) unaCiudad = True
eventosOrdenados (UnAnio anio (evento1:evento2:cola)) unaCiudad
    | (costoDeVida.evento1 $ unaCiudad) < (costoDeVida.evento2 $ unaCiudad) = eventosOrdenados (UnAnio anio (evento2:cola)) unaCiudad
    | otherwise = False

--------------2.2 Ciudades ordenadas 

ciudadesOrdenadas :: Evento -> [Ciudad] -> Bool
ciudadesOrdenadas _ [unaCiudad] = True
ciudadesOrdenadas unEvento (ciudad1:ciudad2:cola)
    | (costoDeVida.unEvento $ ciudad1) < (costoDeVida.unEvento $ ciudad2) = ciudadesOrdenadas unEvento (ciudad2:cola)
    | otherwise                                                           = False

------------------------- 2.3 Años ordenados 

aniosOrdenados :: [Anio]->Ciudad->Bool
aniosOrdenados [unAnio] _ =True
aniosOrdenados (anio1:anio2:cola) unaCiudad
    | (costoDeVida.aplicarAnioALaCiudad unaCiudad$anio1) < (costoDeVida.aplicarAnioALaCiudad unaCiudad$anio2) = aniosOrdenados (anio2:cola) unaCiudad
    | otherwise =False

-------------------------------------------------------- PUNTO 3 --------------------------------------------------------

{--
Eventos ordenados 

Por lazy evaluation, va a evaluar evento por evento sin la necesidad de corroborar la totalidad de la lista,
por lo tanto, si la iteración recursiva corta a la hora de ejecutar remodelarCiudad 1 (inicio de los eventos infinitos y ascendentes), sale de la iteración y retorna falso, por lo que se puede ejecutar.
PERO si la iteración recursiva no se corta, entonces se va a quedar evaluando infinitamente un evento con el siguiente, y al ser infinitos y ascendentes este proceso no termina nunca.
PUEDE haber un resultado posible, en este caso falso, y tambien puede quedarse iterando infinitamente.
POR OTRO LADO, en el caso de que las remodelaciones esten incluidas al principio de la serie de eventos (y no despues), esta SIEMPRE se va a quedar iterando infinitamente,
ya que son valores ascendentes, por lo que en ningun momento se va a romper la iteración recursiva.
EN ESTE CASO, NO hay resultado posible.
--}

anio2024 :: Anio
anio2024 = UnAnio {
    anio = 2024,
    serieDeEventos = [crisis, reevaluacion 7 ] ++ remodelacionesInfinitas 
    }

remodelacionesInfinitas :: [Evento]
remodelacionesInfinitas = map remodelarCiudad [1..]

{--
Ciudades ordenadas 

Como dijimos anteriormente por lazy evaluation la función puede iniciar, en este caso la función recursiva contiene una comparacion de menor estricto,
esto hace que al momento de evaluar las funciones intercaladas Caleta Olivia y Baradero, siempre retorna falso ya que son valores constantes repetidos infinitamente,
por lo que la función SIEMPRE va a dar falso para discoRayado.
PUEDE haber un caso posible y es el único, falso.
--}

discoRayado :: [Ciudad]
discoRayado = [azul, nullish] ++ ciudadesIntercaladas

ciudadesIntercaladas :: [Ciudad]
ciudadesIntercaladas = cycle [caletaOlivia, baradero]

{--
Años ordenados 

Esta situacion es muy similar a la anterior, la función recursiva contiene una comparacion de menor estricto,
esto hace que al momento de evaluar los años 2023 repetidos, siempre retorna falso ya que es un valor constante repetido infinitamente, y el menor estricto no se cumple.
PUEDE haber un caso posible y es el único, falso.
--}

laHistoriaSinFin :: [Anio]
laHistoriaSinFin = [anio2021, anio2022] ++ repeat anio2023