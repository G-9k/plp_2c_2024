
data Expr
  = EConstNum Int       -- 1, 2, 3, ...
  | EConstBool Bool     -- True, False
  | EAdd Expr Expr      -- e1 + e2

instance Show Expr where
  show :: Expr -> String
  show (EConstNum n)  = show n
  show (EConstBool b) = show b
  show (EAdd e1 e2)   = "(" ++ show e1 ++ " + " ++ show e2 ++ ")"

data Val
  = VN Int
  | VB Bool

instance Show Val where
  show :: Val -> String
  show (VN n) = show n
  show (VB b) = show b


eval :: Expr -> Val
eval (EConstNum c)  =
eval (EConstBool b) =
eval (EAdd e1 e2)   =


ejemplo1:: Expr
ejemplo1 =
  EAdd
    (EConstNum 1)
    (EAdd (EConstNum 2) (EConstNum 3))

ejemplo2 :: Expr
ejemplo2 = EConstBool True

ejemplo3 :: Expr
ejemplo3 = EAdd ejemplo2 ejemplo1
