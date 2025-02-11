
import Text.Show.Functions
data Personaje = UnPersonaje{
    nombrePersonaje :: String,
    herramientas :: [Herramienta],
    jutsu :: Mision -> Mision,
    rango :: Int
}deriving Show

data Herramienta = UnaHerramienta{
    nombreHerramienta :: String,
    cantidad :: Int
}deriving Show

--------------------------------- Herramientas ------------------------------
bombasDeHumo :: Herramienta
bombasDeHumo = UnaHerramienta "Bombas de humo" 50

kunais :: Herramienta
kunais = UnaHerramienta "Kunais" 49

shurikens :: Herramienta
shurikens = UnaHerramienta "Shurikens" 300

sellosExplosivos :: Herramienta
sellosExplosivos = UnaHerramienta "Sellos explosivos" 400
----------------------------------- Herramientas --------------------------------

-------------------------------------- Funciones auxiliares ---------------------------------
modificarHerramientas :: ( [Herramienta] -> [Herramienta]) -> Personaje -> Personaje
modificarHerramientas unaFuncion unPersonaje = unPersonaje{herramientas = unaFuncion . herramientas $ unPersonaje}
-------------------------------------- Funciones auxiliares ----------------------------------

------------------------------- Parte A --------------------------------------
------ a
obtenerHerramienta :: Herramienta -> Personaje -> Personaje
obtenerHerramienta unaHerramienta unPersonaje
    |sumaDeTodasSusHerramientasMenorA100 unaHerramienta unPersonaje = modificarHerramientas (unaHerramienta :) unPersonaje
    |otherwise = obtenerTodasLasQuePueda unaHerramienta unPersonaje

sumaDeTodasSusHerramientasMenorA100 :: Herramienta -> Personaje -> Bool
sumaDeTodasSusHerramientasMenorA100 unaHerramienta unPersonaje = (obtenerCantidadDeHerramientas unPersonaje  + cantidad unaHerramienta) < 100

obtenerCantidadDeHerramientas :: Personaje -> Int
obtenerCantidadDeHerramientas  = sum . map cantidad . herramientas

obtenerTodasLasQuePueda :: Herramienta -> Personaje -> Personaje
obtenerTodasLasQuePueda unaHerramienta unPersonaje = agregarCantidadDeUnaHerramienta (cantidadDeHerramientasASumar unPersonaje) unaHerramienta unPersonaje

cantidadDeHerramientasASumar :: Personaje -> Int
cantidadDeHerramientasASumar unPersonaje = 100 - obtenerCantidadDeHerramientas unPersonaje

modificarCantidadDeUnaHerramienta :: (Int -> Int) -> Herramienta -> Herramienta
modificarCantidadDeUnaHerramienta unaFuncion unaHerramienta = unaHerramienta{cantidad = unaFuncion . cantidad $ unaHerramienta}

agregarCantidadDeUnaHerramienta :: Int -> Herramienta -> Personaje -> Personaje
agregarCantidadDeUnaHerramienta unaCantidad unaHerramienta  = modificarHerramientas (modificarCantidadDeUnaHerramienta (const unaCantidad) unaHerramienta :)

-------------- b 
usarHerramienta :: Herramienta -> Personaje -> Personaje
usarHerramienta unaHerramienta  = modificarHerramientas (quitarHerramienta unaHerramienta )

quitarHerramienta :: Herramienta -> [Herramienta] -> [Herramienta]
quitarHerramienta unaHerramienta  = filter (noEsHerramienta unaHerramienta)

noEsHerramienta :: Herramienta -> Herramienta -> Bool
noEsHerramienta unaHerramienta otraHerramienta = nombreHerramienta unaHerramienta /= nombreHerramienta otraHerramienta

------------------------------------------- Parte B --------------------------------------------------------
data Mision = UnaMision{
    cantPersonajesNecesarios :: Int,
    rangoNecesario :: Int,
    enemigos :: [Personaje],
    herramientaNecesaria :: Herramienta,
    recompensa :: [Herramienta]
}deriving Show


------------------------------------------ casos de prueba -------------------------------------------
matarALosDeLaAldeaDeLaArena :: Mision
matarALosDeLaAldeaDeLaArena = UnaMision 3 10 [suna, gaara] bombasDeHumo [bombasDeHumo, shurikens]

noHaceNada :: Mision -> Mision
noHaceNada =undefined

naruto :: Personaje
naruto = UnPersonaje "Naruto" [bombasDeHumo, kunais] noHaceNada 5

suna :: Personaje
suna =  UnPersonaje "Suna" [bombasDeHumo, kunais] noHaceNada 5

gaara :: Personaje
gaara =  UnPersonaje "Gaara" [bombasDeHumo, kunais] noHaceNada 10
------------------------------------------- casos de prueba -------------------------------------------
esDesafiante :: [Personaje] -> Mision -> Bool
esDesafiante unosPersonajes unaMision = algunoConRangoMenorRangoQueElRecomendado unosPersonajes unaMision && hayQueDerrotarAlMenos 2 unaMision

algunoConRangoMenorRangoQueElRecomendado :: [Personaje] -> Mision -> Bool
algunoConRangoMenorRangoQueElRecomendado unosPersonajes unaMision = any (< rangoNecesario unaMision) . map rango $unosPersonajes

hayQueDerrotarAlMenos :: Int -> Mision -> Bool
hayQueDerrotarAlMenos unaCantidad unaMision = unaCantidad >= (length . enemigos $ unaMision)

esCopada :: Mision -> Bool
esCopada unaMision = tiene 3 "Bombas de humo" unaMision || tiene 5 "Shurikens" unaMision || tiene 14 "Kunais" unaMision

tiene :: Int -> String -> Mision -> Bool
tiene unaCantidad nombreDeUnaHerramienta unaMision = tieneLaHerramienta nombreDeUnaHerramienta unaMision && tieneCantidadNecesaria unaCantidad nombreDeUnaHerramienta unaMision

tieneLaHerramienta :: String -> Mision -> Bool
tieneLaHerramienta nombreDeUnaHerramienta = elem nombreDeUnaHerramienta .  map nombreHerramienta . recompensa

tieneCantidadNecesaria :: Int -> String -> Mision -> Bool
tieneCantidadNecesaria unaCantidad nombreDeUnaHerramienta  = (>= unaCantidad).cantidad . head . filter (esHerramienta nombreDeUnaHerramienta) . recompensa

esHerramienta :: String -> Herramienta -> Bool
esHerramienta nombreDeUnaHerramienta unaHerramienta = nombreDeUnaHerramienta == nombreHerramienta unaHerramienta

--es factible
esFactible :: Mision -> [Personaje] -> Bool
esFactible unaMision unosPersonajes = noEsDesafienteYSonSuficientes unaMision unosPersonajes || totalDeHerramientasDelEquipo unosPersonajes > 500

noEsDesafienteYSonSuficientes :: Mision -> [Personaje] -> Bool
noEsDesafienteYSonSuficientes unaMision unosPersonajes = (not. esDesafiante unosPersonajes $ unaMision) && sonSuficientes unosPersonajes unaMision

sonSuficientes :: [Personaje] -> Mision -> Bool
sonSuficientes unosPersonajes unaMision = length unosPersonajes > cantPersonajesNecesarios unaMision

totalDeHerramientasDelEquipo :: [Personaje] -> Int
totalDeHerramientasDelEquipo = sum . map obtenerCantidadDeHerramientas

--Fallar mision
fallarMision :: Mision -> [Personaje] -> [Personaje]
fallarMision unaMision  = map( modificarRango (subtract 2)) . quienTieneRangoRecomendado unaMision 

quienTieneRangoRecomendado :: Mision -> [Personaje] -> [Personaje]
quienTieneRangoRecomendado unaMision  = filter (tieneRangoNecesario unaMision) 

tieneRangoNecesario :: Mision -> Personaje -> Bool
tieneRangoNecesario unaMision unPersonaje = rango unPersonaje >= rangoNecesario unaMision
 
modificarRango :: (Int -> Int ) -> Personaje -> Personaje
modificarRango unaFuncion unPersonaje = unPersonaje{rango =  unaFuncion . rango $ unPersonaje}

--Cumplir mision
cumplirMision :: Mision -> [Personaje] -> [Personaje]
cumplirMision unaMision  = map (modificarRango (+2)) . obtenerRecompensas unaMision 

obtenerRecompensas :: Mision -> [Personaje] -> [Personaje]
obtenerRecompensas unaMision  = map (recibirCadaRecompensa unaMision) 

recibirCadaRecompensa :: Mision -> Personaje -> Personaje
recibirCadaRecompensa unaMision unPersonaje = foldr obtenerHerramienta unPersonaje (recompensa unaMision)

--Clones de Sombra
clonesDeSombra ::Int -> Mision -> Mision
clonesDeSombra cantDeClones  = modificarCantPersonajesNecesarios (max 1 (subtract cantDeClones))

modificarCantPersonajesNecesarios :: (Int -> Int) -> Mision -> Mision
modificarCantPersonajesNecesarios unaFuncion unaMision = unaMision{cantPersonajesNecesarios = unaFuncion . cantPersonajesNecesarios $ unaMision}

fuerzaDeUnCentenar :: Mision -> Mision
fuerzaDeUnCentenar  = modificarEnemigos eliminarEnemigosConRangoMenorA500

modificarEnemigos :: ([Personaje]->[Personaje]) -> Mision -> Mision
modificarEnemigos unaFuncion unaMision = unaMision{enemigos = unaFuncion . enemigos $ unaMision}

eliminarEnemigosConRangoMenorA500 :: [Personaje] -> [Personaje]
eliminarEnemigosConRangoMenorA500  = filter tieneRangoMenorA500

tieneRangoMenorA500 :: Personaje -> Bool
tieneRangoMenorA500 unPersonaje = rango unPersonaje <500

------------------------------------------- Parte C --------------------------------
{--
granGuerraNinja :: Mision
granGuerraNinja = UnaMision  100000  1000 zetsu shurikens [shurikens]

agregarNumero :: Int -> [Personaje]
agregarNumero unNumero  =  map agregarNumero [1..]

zetsu :: Int ->Personaje
zetsu unNumero = UnPersonaje{nombrePersonaje = "Zetsu " ++ agregarNumero, herramientas = [], jutsu = undefined, rango = 600} 
--}