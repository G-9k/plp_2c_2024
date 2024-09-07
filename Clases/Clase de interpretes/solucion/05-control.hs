import Memory
import Environment

data Expr
  = EConstNum Int       -- 1, 2, 3, ...
  | EConstBool Bool     -- True, False
  | EAdd Expr Expr      -- e1 + e2
  | EVar Id             -- x
  | ELet Id Expr Expr   -- let x = e1 in e2
  | ESeq Expr Expr      -- e1; e2
  | EAssign Id Expr     -- x := e
  | ELtNum Expr Expr    -- e1 < e2
  | EIf Expr Expr Expr  -- if e1 then e2 else e3
  | EWhile Expr Expr    -- while e1 do e2

instance Show Expr where
  show :: Expr -> String
  show (EConstNum n)  = show n
  show (EConstBool b) = show b
  show (EAdd e1 e2)   = "(" ++ show e1 ++ " + " ++ show e2 ++ ")"
  show (EVar x)       = x
  show (ELet x e1 e2) = "let " ++ x ++ " = " ++ show e1  ++ " in " ++ show e2
  show (ESeq e1 e2)   = show e1 ++ "; " ++ show e2
  show (EAssign x e)  = x ++ " := " ++ show e
  show (ELtNum e1 e2) = "(" ++ show e1 ++ " < " ++ show e2 ++ ")"
  show (EIf c t e)    = "(if " ++ show c ++ " then " ++ show t ++ " else " ++ show e ++ ")"
  show (EWhile c b)    = "while " ++ show c ++ " { " ++ show b ++ " }"

data Val
  = VN Int
  | VB Bool

instance Show Val where
  show :: Val -> String
  show (VN n) = show n
  show (VB b) = show b

addVal :: Val -> Val -> Val
addVal (VN n1) (VN n2) = VN $ n1 + n2
addVal _       _       = error "Operandos de tipo incorrecto"

ltVal :: Val -> Val -> Val
ltVal (VN n1) (VN n2) = VB $ n1 < n2
ltVal _       _       = error "Operandos de tipo incorrecto"

eval :: Expr -> Env Addr -> Mem Val -> (Val, Mem Val)
eval (EConstNum c)  _   mem = (VN c, mem)
eval (EConstBool b) _   mem = (VB b, mem)
eval (EAdd e1 e2)   env mem =
  let (v1, mem'') = eval e1 env mem
      (v2, mem')  = eval e2 env mem''
  in  (addVal v1 v2, mem')
eval (EVar x)       env mem = (load mem (lookupEnv env x),  mem)
eval (ELet x e1 e2) env mem =
  let (v1, mem'') = eval e1 env mem
      addr        = freeAddress mem
      env'        = extendEnv env x addr
      mem'        = store mem'' addr v1
  in  eval e2 env' mem'
eval (ESeq e1 e2)   env mem =
  let (_, mem'') = eval e1 env mem
  in  eval e2 env mem''
eval (EAssign x e)  env mem =
  let (v, mem') = eval e env mem
  in  (v, store mem' (lookupEnv env x) v)
eval (ELtNum e1 e2)   env mem =
  let (v1, mem'') = eval e1 env mem
      (v2, mem')  = eval e2 env mem''
  in  (ltVal v1 v2, mem')
eval (EIf c t e)      env mem =
  case eval c env mem of
    (VB b, mem') -> eval (if b then t else e) env mem'
    _            -> error "condicion de tipo incorrecto"
eval (EWhile c b)     env mem =
  case eval c env mem of
    (VB True, mem')  ->
      let (_, mem'') = eval b env mem'
      in eval (EWhile c b) env mem''
    (VB False, mem') -> (VN 0, mem')  -- por convención asumimos 0
    _                -> error "Condición no booleana"

-- Definición alternativa donde el comportamiento de while esta dado en
-- términos de la secuencia y el condicional
-- eval (EWhile c b)     env mem =
--   eval (EIf c (ESeq b (EWhile c b)) (EConstNum 0)) env mem

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

ejemplo6 :: Expr
ejemplo6 =
  ELet "x"
    (EConstNum 5)
    (ELet "y" (EConstNum 1)
      (ESeq
        (EAssign "x" (EAdd (EVar "x") (EVar "y")))
        (ESeq
          (EAssign "x" (EAdd (EVar "x") (EVar "y")))
          (ESeq
            (EAssign "x" (EAdd (EVar "x") (EVar "y")))
            (EVar "x")))))


ejemploIf :: Expr
ejemploIf =
  ELet "x" (EConstNum 21)
    (ELet "cond" (EConstBool True)
      (EIf (EVar "cond")
              (EAdd (EVar "x") (EVar "x"))
              (EConstNum 0)))

ejemploWhile :: Expr
ejemploWhile =
  ELet "x" (EConstNum 0)
    (ELet "y" (EConstNum 1)
      (ESeq
        (EWhile (ELtNum (EVar "x") (EConstNum 7))
           (ESeq
             (EAssign "x" (EAdd (EVar "x") (EConstNum 1)))
             (EAssign "y" (EAdd (EVar "y") (EVar "y")))))
        (EVar "y")))
