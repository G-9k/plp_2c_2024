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

mejorSegun :: (a -> a -> Bool) -> AB a -> a
mejorSegun f (Bin i r d) = foldAB (\ri r rd -> cmp (cmp r rd) ri) r (Bin i r d)
    where cmp x y = if f x y then x else y

-- cmp :: (a -> a -> Bool) -> AB a -> a -> a
-- cmp f arb e = case arb of
--                 Nil -> e
--                 Bin i r d -> if f r e then r else e

-- No comprendo por qué dice que el resultado de la recursión de un arbol puede ser o no Nil.

-- IV

esABB :: Ord a => AB a -> Bool
esABB = recAB (\i r d ri rd -> 
    (if esNil i then True else raiz i < r && (mejorSegun (>) i) <= r) && 
    (if esNil d then True else raiz d > r && (mejorSegun (<) d) > r) && 
    ri && rd) True

raiz :: AB a -> a
raiz (Bin i r d) = r

-- V

{-
En el caso donde se usa foldAB es porque la función no requiere procesar el valor
de la subestructuras, justo en el caso de ABB si es necesario porque necesitamos los
valores de las raices de los subarboles izquierdo y derecho.
-}

-- Ejercicio 15
--I

data RoseTree a = Rose a [RoseTree a]

-- II

foldRose :: (a -> [b] -> b) -> RoseTree a -> b
foldRose cRose (Rose r rs) = cRose r (map rec rs)
    where rec = foldRose cRose

-- III
--a)

hojas :: RoseTree a -> [a]
hojas = foldRose (\r rec -> if null rec then [r] else concat rec)


-- distancias :: RoseTree a -> [(a, Int)]
-- distancias rose = foldRose (\r rec n -> if null rec then [(r,n)] else (r,n):concat (rec (n+1))) rose 0

--b)

distancias :: RoseTree a -> [Integer]
distancias = foldRose (\r rec -> if null rec then [0] else map (+1) (concat rec))


--c)

alturaRose :: RoseTree a -> Integer
alturaRose = foldRose (\r rec -> if null rec then 1 else 1 + maximum rec)




