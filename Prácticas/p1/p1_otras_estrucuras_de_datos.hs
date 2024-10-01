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

data Poli a = X
            | Cte a
            | Suma (Poli a) (Poli a)
            | Prod (Poli a) (Poli a)

foldPoli :: (b -> b -> b) -> (b -> b -> b) -> b -> (a -> b) -> Poli a -> b
foldPoli cSuma cProd cX cCte poli = case poli of
                                        X -> cX
                                        Cte c -> cCte c
                                        Suma p q -> cSuma (recu p) (recu q)
                                        Prod p q -> cProd (recu p) (recu q)
                                        where recu = foldPoli cSuma cProd cX cCte


evaluar :: Num a => a -> Poli a -> a
evaluar n = foldPoli (+) (*) n id
--n es el numero en el que evaluo

-- Ejercicio 12

data AB a = Nil | Bin (AB a) a (AB a)

