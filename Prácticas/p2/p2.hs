-- Ejercicio 2
-- VIII

-- reverse :: [a] -> [a]
-- reverse = foldl (flip (:)) []

ponerAlFinal :: a -> [a] -> [a]
ponerAlFinal x = foldr (:) (x:[])