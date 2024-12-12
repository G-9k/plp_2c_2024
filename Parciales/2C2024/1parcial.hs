-- 1
-- a
import Data.List

data Buffer a = Empty | Write Int a (Buffer a) | Read Int (Buffer a)
    deriving Show

foldBuffer :: (Int -> a -> b -> b) -> (Int -> b -> b) -> b -> Buffer a -> b
foldBuffer cWrite cRead cEmpty buf = case buf of
    Write n e rb -> cWrite n e (rec rb)
    Read n rb -> cRead n (rec rb)
    Empty -> cEmpty
    where rec = foldBuffer cWrite cRead cEmpty

recBuffer :: (Int -> a -> Buffer a -> b -> b) -> (Int -> Buffer a -> b -> b) -> b -> Buffer a -> b
recBuffer cWrite cRead cEmpty buf = case buf of
    Empty -> cEmpty
    Write n e rb -> cWrite n e rb (rec rb)
    Read n rb -> cRead n rb (rec rb)
    where rec = recBuffer cWrite cRead cEmpty

-- b

posicionesOcupadas :: Buffer a -> [Int]
posicionesOcupadas = foldBuffer (\n e rec -> (union [n] rec)) (\n rec -> (delete n rec)) []

b3 = (Read 1 (Write 2 True (Write 1 False Empty)))
b2 = (Write 1 True (Write 2 False Empty))
buf = (Write 1 "a" (Write 2 "b" (Write 1 "c" Empty)))

-- c

contenido :: Int -> Buffer a -> Maybe a
contenido n = foldBuffer (\p e rec -> if p == n then Just e else rec) (\p rec -> if p == n then Nothing else rec) Nothing

-- d

pCL :: Buffer a -> Bool
pCL = recBuffer (\_ _ _ rec -> rec) (\p b rec -> elem p (posicionesOcupadas b) && rec) True


-- e

deshacer :: Buffer a -> Int -> Buffer a
deshacer = recBuffer (\p e rb rec n -> if n == 0 then (Write p e rb) else rec (n-1)) (\p rb rec n -> if n == 0 then (Read p rb) else rec (n-1)) (const Empty)
