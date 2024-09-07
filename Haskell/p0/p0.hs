{-Ejercicio 1
null
La funcion null recibe algo de tipo t que debe ser "Foldable" 
(eso son los tipos de funcion que pueden ser plegados o reducidos a un solo valor con foldr o foldl)
este algo de tipo t foldable contiene elementos de tipo a, que pueden ser de cualquier tipo
y la funcion devuelve null si está vacia. Basicamente te dice si una lista está vacia.
Foldable t => t a -> Bool

head
Te da el primer elemento de la lista
GHC.Stack.Types.HasCallStack => [a] -> a

tail
Te da todos los elementos de la lista menos el primero
GHC.Stack.Types.HasCallStack => [a] -> [a]

init
Te da todos los elementos de la lista menos el ultimo.
GHC.Stack.Types.HasCallStack => [a] -> [a]

last
Te da el ultimo elemento de la lista
GHC.Stack.Types.HasCallStack => [a] -> a

take
Al pasarle un numero y una lista (el numero debe poder indexar la lista)
te devuelve todos los elementos de la lista hasta la enesima posicion.
Int -> [a] -> [a]

drop
Hace lo mismo que take, pero devuelve todos los numeros restantes que te devolveria take. 
Es decir drop 3, te devuelve todo menos los primeros tres elementos
Int -> [a] -> [a]

(++)
dado dos listas, te las une.
[a] -> [a] -> [a]

concat
concatena todas las listas que aparecen en una lista, haciendo una lista sola
haria algo similar a (++), pero le pasas un solo dato, la lista de listas.
Foldable t => t [a] -> [a]

(!!)
Es el indice de listas, uno se debe asegurar que el indice este en rango, sino tira error.
['a', 'b', 'c'] !! 2
'c'
GHC.Stack.Types.HasCallStack => [a] -> Int -> a

elem
dado una lista y un elemento del mismo tipo que los que contiene la lista, se fija si
esta. En caso de que esté, entrega true, sino false.
(Foldable t, Eq a) => a -> t a -> Bool
-}

--Ejercicio 2

--a

valorAbsoluto :: Float -> Float
valorAbsoluto n | n > 0 = n
                | otherwise = -n

--b
bisiesto :: Int -> Bool
bisiesto n = (mod n 4 == 0 && mod n 100 /= 0) || (mod n 400 == 0)

--c

factorial :: Int -> Int
factorial 1 = 1
factorial n = n * factorial (n-1)

--d

cantDivisoresPrimos :: Int -> Int
cantDivisoresPrimos n = length(filter esPrimo (listaDivisores n))

listaDivisores :: Int -> [Int]
listaDivisores n = [x | x <- [2..n], mod n x == 0]

esPrimo :: Int -> Bool
esPrimo n = length (listaDivisores n) == 1


-- Ejercicio 3
--a
inverso :: Float -> Maybe Float
inverso n = if n /= 0 then Just (1/n) else Nothing

--b
aEntero :: Either Int Bool -> Int
aEntero n = case n of
    Right True -> 1
    Right False -> 0
    Left n -> n

-- Ejericio 4
--a
limpiar :: String -> String -> String
limpiar [] s2 = s2
limpiar (x:xs) s2 = limpiar xs (eliminarApar x s2)

eliminarApar :: Char -> String -> String
eliminarApar _ [] = []
eliminarApar c (x:xs) = if c == x then eliminarApar c xs else x:eliminarApar c xs

--b
difPromedio :: [Float] -> [Float]
difPromedio xs = map (flip (-) (promedio xs)) xs

promedio :: [Float] -> Float
promedio xs = (foldr1 (+) xs) / fromIntegral (length xs)

--c
todosIguales :: [Int] -> Bool
todasIguales [] = True
todosIguales (x:xs) = foldr (\a rec -> a == x && rec) True (x:xs)

--Ejercicio 5
data AB a = Nil | Bin (AB a) a (AB a)
    deriving Show

--a
vacioAB :: AB a -> Bool
vacioAB Nil = True
vacioAB _ = False


--b
negacionAB :: AB Bool -> AB Bool
negacionAB Nil = Nil
negacionAB (Bin i c d) = Bin (negacionAB i) (not c) (negacionAB d)

--c
foldAB :: (b -> a -> b -> b) -> b -> AB a -> b
foldAB cBin cNil arb = case arb of
    Nil -> cNil
    Bin i c d -> cBin (recu i) c (recu d)
    where recu = foldAB cBin cNil

productoAB :: AB Int -> Int
productoAB = foldAB (\ri rc rd -> ri*rc*rd) 1