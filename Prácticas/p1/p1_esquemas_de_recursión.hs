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
-- sumaAltInv :: [Int] -> Int
-- sumaAltInv = foldl (-) 0

-- Ejercicio 4
