# Ejercicio 6

## a) #collect:

El mensaje collect recibe un bloque y prácticamente funciona como un map.
Ej:

```smalltalk
(1 to: 6) collect: [ :n | n+1 ].
```

Responde con : `#(2 3 4 5 6 7)`

## b) #select:

El mensaje collect recibe un bloque y prácticamente funciona como un filer, el bloque dado un value: (cuyo argumento serán los elementos de la colección), deberá responder un true o false.
Ej:

```smalltalk
(1 to: 10) select: [ :m | m \\ 2 = 0 ].
```

Responde con : `#(2 4 6 8 10)`

## c) #inject: into:

El mensaje inject: into: recibe dos valores, el primero que se le pasa por inject: es un valor inicial y el segundo es un bloque de codigo. Esto es muy similar a un acumulador iniciado en inject, y el codigo que se le dice que hacer con cada elemento de la collection. Un tanto parecido a un foldr.
Ej:

```smalltalk
(1 to: 10) inject: 10 into: [ :sum :each | sum + each ].
```

Responde con : `65`

## d) #reduce:

El mensaje reduce: recibe solo un bloque que a su vez debe recibir dos argumentos. Funciona prácticamente igual a inject: into:, solo que reduce no te deja cambiar el valor inicial, entonces el acumulador empieza con el primer elemento, y el each es a partir del segundo. Esto puede ser limitante debido a que no funciona con listas vacías, parecido al foldl1 de haskell.
Ej:

```smalltalk
(1 to: 10) reduce: [ :sum :each | sum + each ].
```
Responde con : `55`

```smalltalk
|n|
n := OrderedCollection new.
n reduce: [ :sum :each | sum + each ].
```
Responde con : `an OrderedCollection() is empty`


## e) #reduceRight:

El mensaje reduceRight: es lo mismo que foldr1 en haskell.
Ej:

```smalltalk
(1 to: 4) reduceRight: [ :sum :each | sum - each ].
```
Responde con : `-2`
Esta es la suma alternada, si se hubiera usado reduce:, hubiera dado -8. (El primero siempre es 1 positivo.)

## e) #do:

El do: puede funcionar como una clase de for el cual ya recorre todos los elementos.
Ej:

```smalltalk
|n|
n := OrderedCollection new.
(1 to: 4) do: [ :each | each \\ 2 = 0 ifTrue: [n add: 5]].
n.
```
Responde con : `an OrderedCollection(5 5)`






