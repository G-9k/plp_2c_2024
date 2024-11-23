# Ejercicio 9

La verdad que no sé, esto no funciona bien.

```smalltalk
generarBloqueInfinito
	| array x manyBlocks|
	array := Array new: 2.
	x := 0.
	manyBlocks := [ :f | x := x+1 . array at: 1 put: x. array at: 2 put: [f value: f]. array].
	^ manyBlocks value: manyBlocks.
```