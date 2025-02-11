
import Text.Show.Functions()

type Juguete = String

data Perrito = UnPerrito{
    raza :: Raza,
    juguetes :: [Juguete],
    estadia :: Int,
    energia :: Int
}deriving Show

type Rutina = [Actividad]
type Actividad = (Ejercicio, Int)
type Ejercicio = Perrito -> Perrito
type Raza = String

data Guarderia = UnaGuarderia {
    nombre :: String,
    rutina :: Rutina
}deriving Show

----------------------------------- Funciones Auxiliares -------------------
modificarEnergia :: (Int -> Int) -> Perrito -> Perrito
modificarEnergia unaFuncion unPerrito = unPerrito{energia = unaFuncion . energia $ unPerrito}

modificarJuguetes :: ([Juguete] -> [Juguete]) -> Perrito -> Perrito
modificarJuguetes unaFuncion unPerrito = unPerrito{juguetes = unaFuncion . juguetes $ unPerrito}

modificarEstadia  :: (Int -> Int) -> Perrito -> Perrito
modificarEstadia unaFuncion unPerrito = unPerrito{estadia = unaFuncion . estadia $ unPerrito}
----------------------------------- Funciones Auxiliares -------------------

------------------------------------ Ejercicios -------------------------
jugar :: Ejercicio
jugar = modificarEnergia (max 0 . subtract 10)

ladrar ::Int -> Ejercicio
ladrar cantidadLadridos = modificarEnergia (+ div cantidadLadridos 2)

regalar :: Juguete -> Ejercicio
regalar unJuguete = modificarJuguetes (unJuguete :)

diaDeSpa :: Ejercicio
diaDeSpa unPerrito
    |permaneceMasDe 50 unPerrito || esDeRazaExtravagante unPerrito = modificarEnergia (const 100) . modificarJuguetes ("Peine de goma" :) $ unPerrito
    |otherwise = unPerrito

permaneceMasDe :: Int -> Perrito -> Bool
permaneceMasDe unTiempo  = (>= unTiempo). estadia

esDeRazaExtravagante :: Perrito -> Bool
esDeRazaExtravagante unPerrito= elem (raza unPerrito) razasExtravagantes

razasExtravagantes :: [Raza]
razasExtravagantes = ["Dalmata", "Pomerania"]

diaDeCampo :: Ejercicio
diaDeCampo = modificarJuguetes (drop 1)
------------------------------------ Ejercicios -------------------------

----------------------------------- Perritos ---------------------------
zara :: Perrito
zara = UnPerrito "Dalmata" ["Pelota", "Mantita"] 120 80

donna :: Perrito
donna = UnPerrito "Sin raza" ["Pelota", "Mantita"] 900 5
----------------------------------- Perritos ---------------------------


------------------------------------ Parte B ------------------------------------------------

-------------------------------------  Guarderias ----------------------------------------------------------
guarderiaPdePerritos :: Guarderia
guarderiaPdePerritos = UnaGuarderia "Guarderia Pde Perritos" [(jugar, 30), (ladrar 18, 20), (regalar "Pelota", 0), (diaDeSpa , 120), (diaDeCampo, 720)]

guarderia2 :: Guarderia
guarderia2 = UnaGuarderia "Guarderia 2" [(jugar, 30)]
-------------------------------------  Guarderias ----------------------------------------------------------

puedeEstarEnUnaGuarderia :: Guarderia -> Perrito -> Bool
puedeEstarEnUnaGuarderia unaGuarderia  = esTiempoDePermanenciaMayor unaGuarderia . estadia

esTiempoDePermanenciaMayor :: Guarderia -> Int -> Bool
esTiempoDePermanenciaMayor unaGuarderia tiempoDeEstadia = tiempoDeEstadia > sumarTiempoDeLaRutina unaGuarderia

sumarTiempoDeLaRutina :: Guarderia -> Int
sumarTiempoDeLaRutina = sum . map snd . rutina

reconocerPerrosResponsables:: Perrito -> Bool
reconocerPerrosResponsables  = tieneMasDe3Juguetes . diaDeCampo

tieneMasDe3Juguetes :: Perrito -> Bool
tieneMasDe3Juguetes  = (>3) .length . juguetes

realizarRutina :: Guarderia -> Perrito -> Perrito
realizarRutina unaGuarderia unPerrito
    | puedeEstarEnUnaGuarderia unaGuarderia unPerrito = realizarTodosLosEjercicios unaGuarderia unPerrito
    | otherwise = unPerrito

realizarTodosLosEjercicios :: Guarderia -> Perrito -> Perrito
realizarTodosLosEjercicios unaGuarderia unPerrito = foldr realizarActividad unPerrito (rutina unaGuarderia)

realizarActividad :: Actividad -> Perrito -> Perrito
realizarActividad (unEjercicio, tiempo) = modificarEstadia (subtract tiempo) . unEjercicio

quienesQuedanCansados :: Guarderia -> [Perrito] -> [Perrito]
quienesQuedanCansados unaGuarderia  = filter quedaCansado . map (realizarRutina unaGuarderia)


quedaCansado :: Perrito -> Bool
quedaCansado = (<5) .energia

------------------------------------ Parte B ------------------------------------------------


------------------------------------ Parte C ------------------------------------------------
pi2 :: Perrito
pi2 = UnPerrito "Labrador"  infinitosJuguetes 314 159

infinitosJuguetes :: [Juguete]
infinitosJuguetes = map crearJuguete [1..]

crearJuguete :: Int -> Juguete
crearJuguete unNumero = "soguita " ++ show unNumero

{--
¿Sería posible saber si Pi es de una raza extravagante?

>esDeRazaExtravagante pi
si es posible saber si pi es de una raza extravagante ya que esta funcion no necesita usar la lista de juguetes. Va a devolver falso

¿Qué pasa si queremos saber si Pi tiene…

algún huesito como juguete favorito? 
>elem "huesito" . juguetes $ pi2

en caso de que pi tenga un huesito en sus juguetes si podria evaluarse y devolveria true, 
en caso contrario nunca terminaria de ejercutarse ya que no va a parar de evaluar hasta
encontrar al huesito

alguna pelota luego de pasar por la Guardería de Perritos?

>elem "Pelota" . juguetes . realizarRutina guarderiaPdePerritos $ pi2
en el caso de que su estadia sea mayor al tiempo de la rutina, y la rutina tenga regalar pelota, devuelve True.
Si su tiempo de estadia es menor al de la rutina, entonces elem nunca va a terminar de evaluar, ya que no tiene ninguna pelota.
En el caso de que cumpla con el tiempo de estadia pero la rutina no le ragale ninguna pelota entonces pasa lo mismo que arriba

a soguita 31112?
> elem "soguita 31112" . juguetes $ pi2
devuelve true, ya que una vez que encuentra la soguita deja de evaluar

¿Es posible que Pi realice una rutina?
>realizarRutina guarderiaPdePerritos pi2

si puede ya que ninguna actividad requiere evaluar la lista de juguetes completa de pi. Devuelve a pi despues de realizar la rutina

¿Qué pasa si le regalamos un hueso a Pi?
>regalar "Huesito" pi2

devuele a pi con su lista de juguetes modificada teniendo como primer elemento el huesito
--}

------------------------------------ Parte C ------------------------------------------------
