
data Expr
  = EConstNum Int       -- 1, 2, 3, ...
  | EAdd Expr Expr      -- e1 + e2

instance Show Expr where
  show :: Expr -> String
  show (EConstNum n)  = show n
  show (EAdd e1 e2)   = "(" ++ show e1 ++ " + " ++ show e2 ++ ")"

eval :: Expr -> Int
eval exp = case exp of
  EConstNum n -> n
  EAdd e1 e2 -> eval e1 + eval e2

ejemplo1:: Expr
ejemplo1 =
  EAdd
    (EConstNum 1)
    (EAdd (EConstNum 2) (EConstNum 3))

ejemplo2 :: Expr
ejemplo2 =  EConstNum 3

ejemplo3 :: Expr
ejemplo3 = EAdd ejemplo2 ejemplo1
