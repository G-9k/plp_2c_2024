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

--I

foldAB :: (b -> a -> b -> b) -> b -> AB a -> b
foldAB cBin cNil arb = case arb of
                            Nil -> cNil
                            Bin i r d -> cBin (rec i) r (rec d)
                                where rec = foldAB cBin cNil

{-
Cómo funciona el foldAB
    En el caso de foldAB, la función que maneja los bin no maneja la estructura interna
del arbol, solo ve el valor del nodo en el que está parado (representado con un tipo a)
y tiene permitido seguir la recusión por el árbol de la izquierda y de la derecha (fijate
que esto tiene tipo b porque la función foldAB devuelve algo de tipo b, entonces el resultado
de la recurión en los subárboles también devolverá algo de tipo b)

foldAB :: (b -> a -> b -> b)     -- cBin
          -> b                   -- cNil
          -> AB a                -- El árbol que le pasas
          -> b                   -- El resultado de foldAB
-}

recAB :: (AB a -> a -> AB a -> b -> b -> b) -> b -> AB a -> b
recAB cBin cNil arb = case arb of
                            Nil -> cNil
                            Bin i r d -> cBin i r d (rec i) (rec d)
                                where rec = recAB cBin cNil

{-
Cómo funciona el recAB
    En el caso recAB, la función que maneja los bin sí maneja la estructura interna del árbol,
entonces la función no estaría recibiendo los resultados de la recursión sobre esos valores
(al principio) estaría recibiendo los mismos árboles a la izquierda y derecha del valor del nodo
actual (representado con un tipo a el nodo actual y AB a los árboles de izq y der). Luego, tiene
permitido seguir la recursión por el árbol de la izquierda y el de la derecha (fijate que esto 
tiene tipo b porque recAB devuelve algo de tipo b, entonces la recursión en los subárboles también 
devolverá algo de tipo b)

recAB :: (AB a -> a -> AB a -> b -> b -> b)     cBin
        -> b                                    cNil
        -> AB a                                 árbol
        -> b                                    resultado
-}

-- II

esNil :: AB a -> Bool
esNil arb = case arb of
            Nil -> True
            otherwise -> False

altura :: AB a -> Int
altura = foldAB (\ri r rd -> 1 + max ri rd) 0

cantNodos :: AB a -> Int
cantNodos = foldAB (\ri r rd -> 1 + ri + rd) 0

-- III

mejorSegún :: (a -> a -> Bool) -> AB a -> a
mejorSegún f = foldAB (\ri r rd -> if (f (cmp (f) ri r) (cmp (f) rd r)) then (cmp f ri r) else (cmp f rd r))


cmp :: (a -> a -> Bool) -> AB a -> a -> a
cmp f arb e = case arb of
                Nil -> e
                Bin i r d -> if f r e then r else e
