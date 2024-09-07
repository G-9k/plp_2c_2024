import Environment

data Expr
  = EConstNum Int       -- 1, 2, 3, ...
  | EAdd Expr Expr      -- e1 + e2
  | EVar Id             -- x
  | ELet Id Expr Expr   -- let x = e1 in e2
  | EAmb Expr Expr      -- amb
instance Show Expr where
  show :: Expr -> String
  show (EConstNum n)  = show n
  show (EAdd e1 e2)   = "(" ++ show e1 ++ " + " ++ show e2 ++ ")"
  show (EVar x)       = x
  show (ELet x e1 e2) = "let " ++ x ++ " = " ++ show e1  ++ " in " ++ show e2
  show (EAmb e1 e2)   = "(" ++ show e1 ++ " (+) " ++ show e2 ++ ")"

eval :: Expr -> Env Int -> [Int]
eval (EConstNum c)  _    = [c]
eval (EAdd e1 e2)   env  = [v1 + v2 | v1 <- eval e1 env, v2 <- eval e2 env]
eval (EVar x)       env  = [lookupEnv env x]
eval (ELet x e1 e2) env =
  [v2 | v1 <- eval e1 env,
        v2 <- eval e2 (extendEnv env x v1)]
eval (EAmb e1 e2)  env = eval e1 env ++ eval e2 env

eval' :: Expr -> [Int]
eval' t = eval t emptyEnv

ejemplo1:: Expr
ejemplo1 =
  EAdd
    (EConstNum 1)
    (EAdd (EConstNum 2) (EConstNum 3))

ejemplo2 :: Expr
ejemplo2 = EConstNum 1

ejemplo3 :: Expr
ejemplo3 = EAdd ejemplo2 ejemplo1

ejemplo4 :: Expr
ejemplo4 =
  ELet "x"
    (EConstNum 5)
    (EVar "x")

ejemplo5 :: Expr
ejemplo5 =
  ELet "x"
    (EConstNum 5)
    (ELet "y" (EAdd (EVar "x") (EVar "x"))
      (ELet "y" (EAdd (EVar "x") (EVar "y"))
        (EVar "y")))

ejemploAmb :: Expr
ejemploAmb =
  ELet "x" (EAmb (EConstNum 10) (EConstNum 20))
    (ELet "y" (EAmb (EConstNum 1) (EConstNum 2))
      (EAdd (EVar "x") (EVar "y")))
