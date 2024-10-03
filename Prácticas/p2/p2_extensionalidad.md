# Ejercicio 3

## VIII

```haskell
∀ xs::[a] .∀ x::a .head (reverse (ponerAlFinal x xs)) = x
```

Para demostrar este veamos las definiciones de las funciones involucradas:

```haskell
reverse :: [a] -> [a]
{R0} reverse = foldl (flip (:)) []

ponerAlFinal :: a -> [a] -> [a]
{P0} ponerAlFinal x = foldr (:) (x:[])

foldl :: (b -> a -> b) -> b -> [a] -> b
foldl f ac [] = ac
foldl f ac (x : xs) = foldl f (f ac x) xs

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f z [] = z
foldr f z (x:xs) = f x (foldr f z xs)

head :: [a] -> [a]
head x:xs = x
```

Teniendo estas definiciones, empezamos a aplicar las reglas:

```haskell
head (reverse (foldr (:) (x:[]) xs)) = x
-- Ahora aplicamos def. de reverse
head (foldl (flip (:)) [] (foldr (:) (x:[]) xs)) = x
```

Ahora debemos aplicar inducción estructural.

## Caso base xs = []

```haskell
head (foldl (flip (:)) [] (foldr (:) (x:[]) [])) = x
-- Por def. de foldr, esto se reduce a (x:[]) que es igual a [x] por constructor de listas
head (foldl (flip (:)) [] [x]) = x
-- Aplico def. de foldl
head (foldl (flip (:)) ((flip (:)) [] x) []) = x
-- Aplicando def de flip tenemos (:) x [], que por constructor de listas reduce a [x]
head (foldl (flip (:)) [x] []) = x
-- Ahora como tenemos lista vacía, esto devuelve acumulador.
head [x] = x
-- Por def. esto se cumple
x = x
```

Vimos que para el caso base la propiedad se cumple, ahora para el caso recursivo.

## Caso recursivo: z:xs

Tenemos que en este caso la H.I es:

```haskell
∀ xs::[a] .∀ x::a. head (foldl (flip (:)) [] (foldr (:) (x:[]) xs)) = x
```

O de forma mas simplicada:

```haskell
∀ xs::[a] .∀ x::a. head (reverse (ponerAlFinal x xs)) = x
```

Entonces queremos demostrar que vale para un elemento mas:

```haskell
head (reverse (ponerAlFinal x z:xs)) = x
-- Esto lo vamos reduciendo por def. de poner al final
head (reverse (foldr (:) (x:[]) z:xs)) = x
-- Aplico constructor de listas
head (reverse (foldr (:) [x] z:xs)) = x
-- Aplicamos def. de foldr
head (reverse ((:) z (foldr (:) [x] xs))) = x
-- Aplico def. de reverse y utilizo el constructor de lista en notación infija
head (foldl (flip (:)) [] z:(foldr (:) [x] xs)) = x
-- Puedo aplicar def de ponerAlFinal y simplificar la expresión
head (foldl (flip (:)) [] z:(ponerAlFinal x xs)) = x
-- Aplico def. de foldl
head (foldl (flip (:)) (flip (:) [] z) (ponerAlFinal x xs)) = x
-- Aplico def. de flip y constructor de listas.
head (foldl (flip (:)) [z] (ponerAlFinal x xs)) = x
```

Recordando el ejercicio anterior, habíamos demostrado el siguiente lema:

```haskell
∀ acc :: [a] . ∀ xs :: [a] . foldl (flip (:)) acc xs = foldl (flip (:)) [] xs ++ acc
```

Puedo aplicar lo mismo para enviar al fondo el [z], entonces esto sería:

```haskell
head (foldl (flip (:)) [] (ponerAlFinal x xs) ++ [z]) = x
-- Aplico def. de reverse para simplificar.
head (reverse (ponerAlFinal x xs) ++ [z]) = x
```

Acá necesito un nuevo lema.

## Nuevo lema

```haskell
∀ ys :: [a] . ∀ xs :: [a] . not(null xs) => (head xs ++ ys = head xs)
```

Hacemos inducción sobre la lista xs

### Caso base xs = []

```hs
not(null []) => (head [] ++ ys = head [])
-- Reducimos null y not
False => (head [] ++ ys = head [])
```

False implica lo que sea es verdadero, el caso base cumple.

### Caso inductivo: x:xs

```hs
not(null x:xs) => (head x:xs ++ ys = head x:xs)
-- Reducimos null y not
True => (head x:xs ++ ys = head x:xs)
-- Ahora queda demostrar que se cumpla la igualdad para hacer verdadera la implicación. Para eso aplico def. de (++)
True => (head (foldr (:) ys x:xs) = head x:xs)
-- Aplico def. de foldr
True => (head x:(foldr (:) ys xs) = head x:xs)
-- Aplico def. de head a ambos lados de la igualdad
True => x = x
-- La igualdad se cumple
True => True
```

True implica True es verdadero, entonces el caso inductivo también vale y la propiedad queda demostrada.

## Finalizando la demostración.

Habiamos quedado en esto:

```hs
head (reverse (ponerAlFinal x xs) ++ [z]) = x
```

Aplicando el nuevo lema (porque (reverse (ponerAlFinal x xs)) es una lista no vacía) esto queda de la siguiente forma:

```hs
head (reverse (ponerAlFinal x xs)) = x
```

Y llegamos a lo mismo que sabemos que vale por la H.I, por lo que queda demostrado lo que queriamos probar.