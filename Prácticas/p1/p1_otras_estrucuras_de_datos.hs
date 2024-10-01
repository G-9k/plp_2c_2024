-- Ejercicio 10
--I

foldNat :: (Integer -> b -> b) -> b -> Integer -> b
foldNat cInt cZ v = case v of
    0 -> cZ
    otherwise -> cInt v (foldNat cInt cZ (v-1))

-- Función definida para enteros mayores o iguales a 0, si es mayor, caso recursivo
-- Si es igual, caso base

factorial :: Integer -> Integer
factorial = foldNat (*) 1
--Lo hice para probar

--II

potencia :: Integer -> Integer -> Integer
potencia b exp = foldNat (\x rec -> b*rec) 1 exp


-- Ejercicio 11

