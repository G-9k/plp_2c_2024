# Ejercicio 5

## a)

```smalltalk
factorialsList: 10.
```

Al evaluar tira un error que dice 'variable or expression expected'. Esto es porque hemos definido el metodo como un mensaje unario, no espera ningun argumento. En este caso no hay recpetor.

## b) 

```smalltalk
Integer factorialsList: 10.
```

Esto tira otro error, ya que el mensaje unario factorialsList se lo estamos mandando en este caso a la clase Integer y no a una instancia de esta. La clase no sabe responder a este mensaje, entonces tira un error.  
Receptor del mensaje: La clase 'Integer'  
Respuesta: Instance of Integer class did not understand #factorialsList.

## c)

```smalltalk
3 factorialsList.
```

Este funciona, el receptor es la instancia de Integer 3, sabe responder al mensaje.  
Respuesta: `an OrderedCollection(1 2 6)`

## d)

```smalltalk
5 factorialsList at: 4.
```

El receptor del mensaje es 5, responde con `an OrderedCollection(1 2 6 24 120)` y luego eso recibe el mensaje keyword 'at:' con el colaborador 4. Entonces devuelve el cuarto elemento de la lista, es decir: 24.

## e)
```smalltalk
5 factorialsList at: 6.
```

Acá falla porque el mensaje at falla, la lista creada por factorialsList no es lo suficientemente larga, no tiene sexto elemento.  
Respuesta: Error 'Out of bounds'.