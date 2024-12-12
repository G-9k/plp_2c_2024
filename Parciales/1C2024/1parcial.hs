data AT a = NilT | Tri a (AT a) (AT a) (AT a) deriving Show 

--at1 = (Tri 1 (Tri 2 NilT NilT NilT) (Tri 3 (Tri 4 NilT NilT NilT) NilT NilT) (Tri 5 NilT NilT NilT))

foldAT :: (a -> b -> b -> b -> b) -> b -> AT a -> b
foldAT cTri cNil tri = case tri of
    NilT -> cNil
    (Tri r i c d) -> cTri r (rec i) (rec c) (rec d)
        where rec = foldAT cTri cNil


preorder :: AT a -> [a]
preorder = foldAT (\r ri rc rd -> r : (ri ++ rc ++ rd)) []

mapAT :: (a -> b) -> AT a -> AT b
mapAT f = foldAT (\r ri rc rd -> Tri (f r) ri rc rd) NilT

nivel :: AT a -> Int -> [a]
nivel = foldAT (\r ri rc rd n -> if n == 0 then [r] else (ri (n-1)) ++ (rc (n-1)) ++ (rd (n-1))) (const [])