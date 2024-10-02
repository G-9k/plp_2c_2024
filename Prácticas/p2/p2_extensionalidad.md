# Ejercicio 1

I.  

∀ p::(a,b) .intercambiar (intercambiar p) = p  

Para demostrar esto, veo la definición de intercambiar:

```haskell
intercambiar (x,y) = (y,x)
```

Veo que intercambiar está definido solo para pares, y como sé que p es un par (de tipo (a,b)) puedo aplicar ==extensionalidad para pares==.

Si p :: (a, b), entonces ∃x :: a. ∃y :: b. p = (x, y).

Entonces 