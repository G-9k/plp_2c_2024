import Environment

data Expr
  = EConstNum Int       -- 1, 2, 3, ...
  | EAdd Expr Expr      -- e1 + e2
  | EVar Id             -- x
  | ELet Id Expr Expr   -- let x = e1 in e2
  | EDiv Expr Expr      -- e1 / e2
  | ETry Expr Expr      -- try e1 else e2
instance Show Expr where
  show :: Expr -> String
  show (EConstNum n)  = show n
  show (EAdd e1 e2)   = "(" ++ show e1 ++ " + " ++ show e2 ++ ")"
  show (EVar x)       = x
  show (ELet x e1 e2) = "let " ++ x ++ " = " ++ show e1  ++ " in " ++ show e2
  show (EDiv e1 e2)   = "(" ++ show e1 ++ " / " ++ show e2 ++ ")"
  show (ETry e1 e2)   = "{try " ++ show e1 ++ " else " ++  show e2  ++ " }"


eval :: Expr -> Env Int -> Maybe Int
eval (EConstNum c)  _    = Just c
eval (EAdd e1 e2)   env  =
  case eval e1 env of
    Just v1 ->
      case eval e2 env of
        Just v2 -> Just (v1 + v2)
        _ -> Nothing
    _ -> Nothing
eval (EVar x)       env  = Just $ lookupEnv env x
eval (ELet x e1 e2) env =
  case eval e1 env of
    Nothing -> Nothing
    Just v -> eval e2 (extendEnv env x v)
eval (EDiv e1 e2)  env =
  case eval e1 env of
    Nothing -> Nothing
    Just v1 ->
      case eval e2 env of
        Nothing -> Nothing
        Just v2 -> if v2 == 0 then Nothing else Just (v1 `div` v2)
eval (ETry e1 e2)  env =
  case eval e1 env of
    Nothing -> eval e2 env
    Just v  -> Just v

eval' :: Expr -> Maybe Int
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

ejemploTry :: Expr
ejemploTry = ETry (EDiv (EConstNum 5) (EConstNum 0))
               (EConstNum 2)

ejemploTry2 :: Expr
ejemploTry2 = ETry (EDiv (EConstNum 5) (EConstNum 1))
               (EConstNum 2)
