import Environment
import Memory

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

data Thunk = TT Expr (Env Thunk)

data Val
  = VN Int
  | VB Bool
  | VClosure Id Expr (Env Addr) -- !HERE
  | VThunk Expr (Env Addr)

instance Show Val where
  show (VN n)           =  show n
  show (VB b)           =  show b
  show (VClosure _ _ _) = "<closure>"
  show (VThunk _ _)     = "<thunk>"

addVal :: Val -> Val -> Val
addVal (VN n1) (VN n2) = VN $ n1 + n2
addVal _       _       = error "Operandos de tipo incorrecto"

eval :: Expr -> Env Addr -> Mem Val -> (Val, Mem Val)
eval (EConstNum c)  _   mem = (VN c, mem)
eval (EConstBool b) _   mem = (VB b, mem)
eval (EAdd e1 e2)   env mem =
  let (v1, mem1) = eval e1 env mem
      (v2, mem2) = eval e2 env mem1
  in (addVal v1 v2, mem2)
eval (EVar x)       env mem =
  let addr = lookupEnv env x
  in case load mem addr of
    VThunk exp env' ->
      let (v, mem') = eval exp env' mem
      in (v, store mem' addr v)
    x -> (x, mem)
-- Let eager
-- eval (ELet x e1 e2) env mem =
--   let (v1, mem')  = eval e1 env mem
--       addr        = freeAddress mem'
--       env'        = extendEnv env x addr
--       mem''       = store mem' addr v1
--   in  eval e2 env' mem''

-- Let lazy
eval (ELet x e1 e2) env mem =
  let addr        = freeAddress mem
      env'        = extendEnv env x addr
      mem'        = store mem addr (VThunk e1 env)
  in  eval e2 env' mem'

eval (EIf c t e)    env mem =
  let (vc, mem') = eval c env mem
  in eval (if isTrue vc then t else e) env mem'
  where isTrue (VB x) = x
        isTrue _      = False
eval (ELam x e)     env mem = (VClosure x e env, mem)
eval (EApp e1 e2)   env mem =
  let (v1, mem') = eval e1 env mem
  in case v1 of
       VClosure x e1' env' ->
         let addr  = freeAddress mem'
             env''  = extendEnv env' x addr
             mem'' = store mem' addr (VThunk e2 env)
         in  eval e1' env'' mem''
       _ -> error "La expresión a izquierda no es una función."

eval' :: Expr -> (Val, Mem Val)
eval' t = eval t emptyEnv emptyMem

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

ejemploScope :: Expr
ejemploScope =
  ELet "x" (EConstNum 1)
    (ELet "f" (ELam "y" (EAdd (EVar "x") (EVar "y")))
     (ELet "x" (EConstNum 2) (EApp (EVar "f") (EConstNum 3))))

ejemplof :: Expr
ejemplof =
  ELet "suma" (ELam "x"
                (ELam "y"
                  (EAdd (EVar "x") (EVar "y"))))
    (ELet "f" (EApp (EVar "suma") (EConstNum 5))
      (ELet "x" (EConstNum 0)
        (EApp (EVar "f") (EConstNum 3))))
