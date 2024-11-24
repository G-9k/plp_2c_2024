# Ejercicio 8

## a)

Dentro de la clase FullBlockClosure (ya que el receptor es un closure):
```smalltalk
curry
	^[ :x | [ :y | self value: x value: y ] ].
```

## b)

Dentro de la clase FullBlockClosure (ya que el receptor es un closure):
```smalltalk
flip
	^ [ :x :y | self value: y value: x ].
```

Ejemplo del flip:
```smalltalk
[:x :y | x - y] flip value: 10 value: 5.    "Esto retorna -5"

[:x :y | x - y] value: 10 value: 5.         "Esto retorna 5"
```

## c)

Dentro de la clase Integer

```smalltalk
timesRepeatMio: aBlock
    1 to: self do: [ :algo | aBlock value ]
```