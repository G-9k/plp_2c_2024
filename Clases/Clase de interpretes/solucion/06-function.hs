import Environment

data Expr
  = EConstNum Int       -- 1, 2, ...
  | EConstBool Bool     -- True, False
  | EAdd Expr Expr      -- e1 + e2
  | EVar Id             -- x
  | ELet Id Expr Expr   -- let x = e1 in e2
  | EIf Expr Expr Expr  -- if c then e1 else e3
  | ELam Id Expr        -- \x -> e
  | EApp Expr Expr      -- e1 e2

instance Show Expr where
  show :: Expr -> String
  show (EConstNum n)  = show n
  show (EConstBool b) = show b
  show (EAdd e1 e2)   = "(" ++ show e1 ++ " + " ++ show e2 ++ ")"
  show (EVar x)       = x
  show (ELet x e1 e2) = "let " ++ x ++ " = " ++ show e1  ++ " in " ++ show e2
  show (EIf c e1 e2)  = "(if " ++ show c ++ " then " ++ show e1  ++ " else " ++ show e2  ++ ")"
  show (ELam x e)     = "(\\" ++ x ++ " -> " ++ show e ++ ")"
  show (EApp e1 e2)   = show e1 ++ " " ++ show e2

data Val
  = VN Int
  | VB Bool
  | VFunction Id Expr

instance Show Val where
  show (VN n)          =  show n
  show (VB b)          =  show b
  show (VFunction _ _) = "<function>"

addVal :: Val -> Val -> Val
addVal (VN n1) (VN n2) = VN $ n1 + n2
addVal _       _       = error "Operandos de tipo incorrecto"

eval :: Expr -> Env Val -> Val
eval (EConstNum c)  _   = VN c
eval (EConstBool b) _   = VB b
eval (EAdd e1 e2)   env = eval e1 env `addVal` eval e2 env
eval (EVar x)       env = lookupEnv env x
eval (ELet x e1 e2) env = eval e2 (extendEnv env x (eval e1 env))
eval (EIf c t e)    env = if isTrue (eval c env) then eval t env else eval e env
  where isTrue (VB x) = x
        isTrue _      = False
eval (ELam x e)     env = VFunction x e
eval (EApp e1 e2)   env =
  let v1 = eval e1 env
      v2 = eval e2 env
   in case v1 of
        VFunction x e1' -> eval e1' (extendEnv env x v2)
        -- scope dinámico de variable: e1' se evalúa en env (no en el ambiente
        -- en el que fué definido)
        _ -> error "La expresión a izquierda no es una función."


eval' :: Expr -> Val
eval' t = eval t emptyEnv

ejemplo1:: Expr
ejemplo1 =
  EAdd
    (EConstNum 1)
    (EAdd (EConstNum 2) (EConstNum 3))

ejemplo2 :: Expr
ejemplo2 = EConstBool True

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

-- Notar que se usa la segunda definición de x y no la primera
ejemploScope :: Expr
ejemploScope =
  ELet "x" (EConstNum 1)
    (ELet "f" (ELam "y" (EAdd (EVar "x") (EVar "y")))
     (ELet "x" (EConstNum 2) (EApp (EVar "f") (EConstNum 3))))

-- Notar que f toma como primer argumento para suma x = 0, no x = 5
ejemplof :: Expr
ejemplof =
  ELet "suma" (ELam "x"
                (ELam "y"
                  (EAdd (EVar "x") (EVar "y"))))
    (ELet "f" (EApp (EVar "suma") (EConstNum 5))
      (ELet "x" (EConstNum 0)
        (EApp (EVar "f") (EConstNum 3))))
