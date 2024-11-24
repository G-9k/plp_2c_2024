# Ejercicio 7

```smalltalk
SomeClass << foo : x
    | aBlock y z |
    z := 10.
    aBlock := [ x > 5 ifTrue: [z := z + x. ^0] ifFalse: [ z := z−x. 5 ] ].
    y := aBlock value.
    y := y + z.
    ^y.
```

## a) obj foo: 4.

En este caso, el x es 4. Y en el aBlock la comparación de x > 5 da false (cuando se le haga value al aBlock), como es false, ira por el ifFalse y actualizará el valor de z.  
Ahora z vale 10-4 = 6. Y luego tira el block del false tira un 5, por lo que en y se guarda 5 al hacerle value al aBlock.
Luego a y se le suma el nuevo z: y := 5 + 6 = 11. 
Finalmente, retorna 11.


## b) Message selector: #foo: argument: 5.

La verdad que no tenía idea lo que hace, lo leí de Honi:

Crea un objeto de la clase Message que codifica el mensaje para el selector foo con argumento 5.  
Podemos enviar este mensaje de la siguiente forma:
```smalltalk
(Message selector: #foo: argument: 5) sendTo: obj.
```

Ahora, con respecto a lo que hace, (aunque el enunciado no lo pide), al recibir 5 como argumento, cuando se le haga value al aBlock, entrará devuelta por el ifFalse.
- z := 10 - 5. (aBlock luego devuelve 5)
- y := 5.
- y := 5 + 5.
- ^10.

Osea debe retornar 10.

## c) obj foo: 10. (Ayuda: el resultado no es 20).

Retorna 0. Esto ocurre por el `^0` al final del bloque del ifTrue cuando se le hace value al aBlock, es cierto que actualiza z a 20, pero termina antes de retornar y, porque retorna 0.

