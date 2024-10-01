-- Ejercicio 3
--I

sumF :: Num a => [a] -> a
sumF xs = foldr (+) 0 xs

elemF :: Eq a => a -> [a] -> Bool
elemF e xs = foldr (\x rec -> (x == e) || rec) False xs

concatF :: [a] -> [a] -> [a]
concatF xs ys = foldr (\x rec -> x : rec) ys xs
-- Caso base es ys

filterF :: (a -> Bool) -> [a] -> [a]
filterF c xs = foldr (\x rec -> if (c x) then x : rec else rec) [] xs

mapF :: (a -> b) -> [a] -> [b]
mapF f xs = foldr (\x rec -> f x : rec) [] xs

--II
mejorSegún :: (a -> a -> Bool) -> [a] -> a
mejorSegún f = foldr1 (\x rec -> if f x rec then x else rec)

--III
sumasParciales :: Num a => [a] -> [a]
sumasParciales xs = reverse (foldr (\x rec -> if null rec then x:rec else (x + head rec):rec) [] (reverse xs))

--IV
sumaAlt :: [Int] -> Int
sumaAlt = foldr (-) 0

--V
sumaAltInv :: [Int] -> Int
sumaAltInv xs = foldr (-) 0 (reverse xs)

-- Es cierto que funciona, porque empezamos con la lista invertida. Pero quiza
-- Esto es lo que se quería ver:

sumaAltInv2 :: [Int] -> Int
sumaAltInv2 = foldl (flip (-)) 0

{-
sumaAltInv2 [2,5,1] = flip (-) (flip (-) (flip (-) 0 2) 5) 1
sumaAltInv2 [2,5,1] = flip (-) (flip (-) (2 - 0) 5) 1
sumaAltInv2 [2,5,1] = flip (-) (flip (-) 2 5) 1
sumaAltInv2 [2,5,1] = flip (-) (5 - 2) 1
sumaAltInv2 [2,5,1] = 1 - 5 + 2

-- El último, menos el anteúltimo...

foldl une el caso base con el primer elemento, foldr lo une con el ultimo.
-}


-- Ejercicio 4
--I

-- permutaciones :: [a] -> [[a]]
-- permutaciones [] = [[]]
-- permutaciones xs = concatMap (\ls -> map () )

permutaciones :: [a] -> [[a]]
permutaciones = foldr (\x rs -> concatMap (\r -> map (insert x r) [0.. length r]) rs) [[]]
    where insert x r i = take i r ++ [x] ++ drop i r


-- Ejercicio 5

{-
elementosEnPosicionesPares no es recursión estructural porque estamos accediendo
a la cola de la lista, algo que no se puede hacer

entrelazar si es recursión estructural porque accedemos a otra lista, lo cual si está permitido.
-}

entrelazar :: [a] -> [a] -> [a]
entrelazar xs ys = foldr (\x rec ys -> if null ys then x : (rec []) else x : head ys : (rec (tail ys))) (const []) xs ys
--La clave acá es comprender que rec puede ser una función, en este caso lo es, y el parametro que recibe es una lista

-- Ejercicio 6

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x : xs) = f x xs (recr f z xs)

--I

sacarUna :: Eq a => a -> [a] -> [a]
sacarUna e = recr (\x xs rec -> if e == x then xs else x:rec) []

--II

{-
No es adecuado el esquema de recursión estructural porque acá necesitamos detener la recursión
antes de llegar al caso base, eso ocurre cuando encontramos el elemento que queremos borrar
y para no tenerlo en cuenta, devolvemos el resto de la lista sin retornar por "rec" el cual
es la parte que continua la recursión
-}

-- III

insertarOrdenado :: Ord a => a -> [a] -> [a]
insertarOrdenado a = recr (\x xs rec -> if a <= x then a:x:xs else if a >= x && cheqHead xs then x:a:xs else x:rec) []
    where cheqHead xs = null xs || a <= head xs

-- Ejercicio 8
--I
-- mapPares :: ((a,b) -> c) -> [(a,b)] -> [c]
-- mapPares f = map f
-- Ahí lo entendí, no es que la función está currificada, es que
-- los dos argumentos que recibe estan currificados, la función debería
-- poder ser una función normal, pero de alguna forma debe resolver recibir
-- un par como argumento. Ahí entra uncurry.
mapPares :: (a -> b -> c) -> [(a,b)] -> [c]
mapPares f = map (uncurry f)

--II
armarPares :: [a] -> [b] -> [(a,b)]
armarPares = foldr (\x rec ys -> if null ys then [] else (x, head ys):rec (tail ys)) (const [])

--III
mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f = foldr (\x rec ys -> (f x (head ys)):rec (tail ys)) (const [])
-- Si la primera lista es mas grande que la segunda, se rompe, pero como dice que
-- las dos listas son de igual longitud, para el caso especificado funciona.


