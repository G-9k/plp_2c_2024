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

--permutaciones :: [a] -> [[a]]
