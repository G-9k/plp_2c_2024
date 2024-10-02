#set text(
  size: 11pt,
  font: "DejaVu Serif",
  lang: "es",
  region: "AR",
  hyphenate: false
)

#set page(
  paper: "a4",
  margin: (x: 1.5cm, y: 2cm)
)

#set par(
  justify: true,
  leading: 0.8em,
  linebreaks: "optimized"
)

#show raw.where(block:true): it => block(
  fill: luma(240),
  inset: 8pt,
  radius: 5pt,
  text(size: 9.5pt, it)
)


= Ejercicio 1

== I

```
∀ p :: (a,b) .intercambiar (intercambiar p) = p
```

Para demostrar esto, veo la definición de intercambiar:

```haskell
intercambiar (x,y) = (y,x)
```

Veo que intercambiar está definido solo para pares, y como sé que p es un par (de tipo (a,b)) puedo aplicar extensionalidad para pares.

Si p :: (a, b), entonces ∃x :: a. ∃y :: b. p = (x, y). Entonces reemplazo ese p por (x,y):

```haskell
intercambiar (intercambiar (x,y)) = (x,y)
-- Aplico definición de intercambiar.
intercambiar (y,x) = (x,y)
-- Vuelvo a aplicar def.
(x,y) = (x,y)
```

Que es justamente lo que queriamos demostrar.

== II

```
∀ p :: (a,(b,c)) .asociarD (asociarI p) = p
```

Veo las definiciones de asociarD y asociarI

```haskell
asociarD ((x,y),z)) = (x,(y,z))

asociarI (x,(y,z)) = ((x,y),z)
```

Con estas definiciones, veo que asociarI y asociarD están definidos solo para pares. Así que aplico extensionalidad sobre pares. Si p :: (a, (b, c)), entonces ∃x :: a. ∃y :: b. ∃z :: c. p = (x, (y, z)). Entonces reemplazo ese p por (x, (y, z)).

```haskell
asociarD (asociarI (x, (y, z))) = (x, (y, z))
-- Aplicando def. de asociarI
asociarD ((x,y),z) = (x,(y,z))
-- Aplicando def. de asociarD
(x,(y,z)) = (x,(y,z))
```

Que es justamente lo que queriamos demostrar.

== III

```
∀ p::Either a b .espejar (espejar p) = p
```

Veamos las definiciones de las funciones involucradas.

```haskell
espejar (Left x) = Right x
espejar (Right x) = Left x
```

Ahora hagamos extensionalidad sobre sumas si e ::Either a b, entonces:  
- o bien ∃x :: a. e = Left x
- o bien ∃y :: b. e = Right y

Entonces vayamos por casos:

=== Caso p = Left x

```haskell
espejar (espejar Left x) = Left x
-- Por definición de espejar
espejar Right x = Left x
-- De vuelta
Left x = Left x
```

=== Caso p = Right x

```haskell
espejar (espejar Right x) = Right x
-- Por definición de espejar
espejar Left x = Right x
-- De vuelta
Right x = Right x
```

Para ambos casos llegamos a una igualdad, por lo tanto la igualdad se cumple.

== IV

```
∀ f::a->b->c . ∀ x::a . ∀ y::b . flip (flip f) x y = f x y
```

La definicion de flip es:

```haskell
flip f x y = f y x
```

Entonces por definición:

```haskell
(flip f) y x = f x y
-- De vuelta aplico def. de flip
f x y = f x y
```

Llegamos a lo que queriamos demostrar.

== V


```
∀ f::a->b->c .∀ x::a .∀ y::b .curry (uncurry f) x y = f x y
```

Veamos por definicion de curry y uncurry:

```haskell
curry f x y = f (x,y)
uncurry f (x,y) = f x y
```

Por definición de curry, podemos ir reduciendo a la siguiente expresión.

```
uncurry f (x, y) = f x y
-- Aplicando def. de uncurry
f x y = f x y
```

Llegando a lo que queriamos demostrar.

= Ejercicio 2



= Ejercicio 3

== VII

```haskell
reverse = foldr (\x rec -> rec ++ (x:[])) []
```

Para demostrar esta propiedad, veo las definiciones de las funciones involucradas:

```haskell
reverse :: [a] -> [a]
{R0} reverse = foldl (flip (:)) []

(++) :: [a] -> [a] -> [a]
{++} xs ++ ys = foldr (:) ys xs

foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f z [] = z
foldr f z (x : xs) = f x (foldr f z xs)

foldl :: (b -> a -> b) -> b -> [a] -> b
foldl f ac [] = ac
foldl f ac (x : xs) = foldl f (f ac x) xs

flip f x y = f y x
```

Aplicando R0, reemplazamos reverse por su definición.

```haskell
foldl (flip (:)) [] = foldr (\x rec -> rec ++ (x:[])) []
```

Por extensionalidad funcional, sabemos que dados f y g :: [a] -> [a] entonces f = g si y solo (∀xs :: [a] . f xs = g xs). Sabiendo esto, agregamos el parámetro que falta. Sabiendo entonces que la propiedad que queremos demostrar:


#sym.forall xs :: [a] .  foldl (flip (:)) [] xs = foldr (\x rec -> rec ++ (x:[])) [] xs


Ahora hago inducción estructural sobre la lista xs. Siendo el predicado unario P(xs)

=== Caso base xs = []

```haskell
foldl (flip (:)) [] [] = foldr (\x rec -> rec ++ (x:[])) [] []
-- Por definición de foldr y foldl, al recibir una lista vacía, devuelve una lista vacía.
[] = []
```

Son iguales el caso base se cumple.

=== Caso inductivo x:xs

Por hipotesis inductiva vale que:

```haskell
∀x :: a. ∀xs :: [a]. P(xs) -> P(x:xs)
```

La hipotesis inductiva asume P(xs) como verdad. Es decir:

```haskell
reverse xs = foldr (\x rec -> rec ++ (x:[])) [] xs
```

Es verdad.

Queremos ver que con un elemento mas, la propiedad sigue cumpliendose.

```haskell
foldl (flip (:)) [] x:xs = foldr (\x rec -> rec ++ (x:[])) [] x:xs
```

Por definición de foldr y foldl:


```haskell
foldl (flip (:)) (flip (:) [] x) xs = (\x rec -> rec ++ (x:[]) x (foldr (\x rec -> rec ++ (x:[])) [] xs)
```

Podemos desarrollar el lambda del lado derecho de la igualdad aplicando regla beta dos veces.

```haskell
(\rec -> rec ++ (x:[])) (foldr (\x rec -> rec ++ (x:[]))

(foldr (\x rec -> rec ++ (x:[])) ++ (x:[]))
```

Rescribimos la igualdad con el lambda reducido.

```haskell
foldl (flip (:)) (flip (:) [] x) xs = (foldr (\x rec -> rec ++ (x:[])) [] xs) ++ (x:[])
-- Aplicamos def. de flip a izquierda de la igualdad
foldl (flip (:)) ((:) x []) xs = (foldr (\x rec -> rec ++ (x:[])) [] xs) ++ (x:[])
-- Aplicando constructor de listas.
foldl (flip (:)) [x] xs = (foldr (\x rec -> rec ++ (x:[])) [] xs) ++ [x]
```

Para avanzar desarrollo un lema para simplificar el foldl de la izquierda:


#sym.forall acc :: [a] . #sym.forall xs :: [a] . foldl (flip (:)) acc xs = foldl (flip (:)) [] xs ++ acc


Para probar esto, hagamos inducción sobre listas, veamos si vale para el caso base.

=== Caso base xs = []

```haskell
foldl (flip (:)) acc [] = foldl (flip (:)) [] [] ++ acc
-- Por def. de foldl se devuelve el acumulador:
acc = [] ++ acc
-- Ahora aplicamos def. de ++
acc = foldr (:) acc []
-- Por def. de foldr, recibimos lista vacía, se devuelve caso base.
acc = acc
```

Para el caso base vale.

=== Caso inductivo: z:xs

=== Hipotesis Inductiva

Por H.I esto sabemos que es verdad.

```haskell
∀ acc :: [a]. ∀ xs :: [a] . foldl (flip (:)) acc xs = foldl (flip (:)) [] xs ++ acc
```

Ahora queremos demostrar si sigue valiendo con un elemento mas.

```haskell
foldl (flip (:)) acc z:xs = foldl (flip (:)) [] z:xs ++ acc
-- Aplicamos def. de foldl
foldl (flip (:)) (flip (:) acc z) xs = foldl (flip (:)) ((flip (:)) [] z) xs ++ acc
-- Aplicando def. de flip
foldl (flip (:)) ((:) z acc) xs = foldl (flip (:)) ((:) z []) xs ++ acc
-- Aplicando constructor de lista
foldl (flip (:)) z:acc xs = foldl (flip (:)) [z] xs ++ acc
```

Vemos que el acumulador ahora tiene en el inicio el z, siendo una lista nueva. Sin embargo el lema que queremos demostrar dice que la igualdad vale para toda lista acc :: [a]. Entonces puedo aplicar H.I y realizar este cambio:

```haskell
foldl (flip (:)) [] xs ++ z:acc = foldl (flip (:)) [] xs ++ [z] ++ acc
```

Aplicamos def. de (++) a la derecha del igual:


```haskell
foldl (flip (:)) [] xs ++ foldr (:) acc [z]
-- Por def. de foldr
foldl (flip (:)) [] xs ++ (:) z (foldr (:) acc [])
-- Aplicamos def. de foldr, esta vez la lista es vacía, por lo que responde con el acumulador.
foldl (flip (:)) [] xs ++ (:) z acc
-- Aplico constructor de lista
foldl (flip (:)) [] xs ++ z:acc
```

Vemos que a lo que llegamos es exactamente igual a lo que teniamos a la izquierda de la igualdad. Por lo tanto, la igualdad vale y el lema queda demostrado.


Habiendo demostrado el lema, volvemos a donde nos habíamos quedado:

=== Lema demostrado:

#sym.forall acc :: [a] . #sym.forall xs :: [a] . foldl (flip (:)) acc xs = foldl (flip (:)) [] xs ++ acc

```haskell
foldl (flip (:)) [x] xs = (foldr (\x rec -> rec ++ (x:[])) [] xs) ++ [x]
```

Entonces podemos aplicar el lema, y mover la lista con x hacia afuera.

```haskell
foldl (flip (:)) [] xs ++ [x] = (foldr (\x rec -> rec ++ (x:[])) [] xs) ++ [x]
```

Y vemos que volvemos a la def. de reverse, por lo que podemos simplificar haciendo:

```haskell
reverse xs ++ [x] = (foldr (\x rec -> rec ++ (x:[])) [] xs) ++ [x]
```

Recordamos la H.I que teniamos en esta inducción:

```haskell
reverse xs = foldr (\x rec -> rec ++ (x:[])) [] xs
```

Y vemos que la expresión de la derecha aparece en nuestra demostración, por lo que aplicando H.I, reemplazamos el foldr por reverse.

```haskell
reverse xs ++ [x] = reverse xs ++ [x]
```

Tenemos lo mismo a ambos lados del igual, por lo que la propiedad queda demostrada.

