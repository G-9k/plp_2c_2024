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

