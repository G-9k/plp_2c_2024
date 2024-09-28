-- Ejercicio 1
{-
max2 :: (Float, Float) -> Float
Aunque mas general es (lo que da :t):
max2 :: Ord a => (a, a) -> a

normaVectorial :: Floating a => (a, a) -> a

subtract :: Float -> Float -> Float

-}

max2 (x, y) | x >= y = x
            | otherwise = y
-- Currificada

normaVectorial (x, y) = sqrt (x^2 + y^2)
-- Currificada

subtract2 = flip (-)
-- No currificada



-- Ejercicio 2
-- I
curry1 :: ((a, b) -> c) -> a -> b -> c
curry1 f x y = f (x,y)
-- II
uncurry1 :: (a -> b -> c) -> (a, b) -> c
uncurry1 f (x,y) = f x y
-- III
{-

curryN :: ((a,b,c,d...) -> z) -> a -> b -> c -> d -> ... -> z
curryN f a' b' c' d' ... = f (a',b',c',d'...)
La idea sería esa, pero como en haskell no se puede hacer una función
con cantidad de parámetros variables, es algo que no se puede hacer
-}

