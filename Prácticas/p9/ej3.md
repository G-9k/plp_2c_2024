# Ejercicio 3

- Objeto y mensaje unario.  
```smalltalk
5 factorial.
```
Responde con 120.

Se adapta a la categoría porque todo es un objeto, y porque factorial es un mensaje que se le manda a 5.

- Colaborador y mensaje binario.  
```smalltalk
5 + 10.
```
Respode con 15.

Es un mensaje binario porque el + tiene un receptor y un colaborador, el 5 y el 10 respectivamente.

- Mensaje keyword y bloque.  
```smalltalk
1 = 2 ifFalse: [ 'es falso' ].  
```
Responde 'es falso'.  
ifFalse es un mensaje que recibe 1 = 2 y su colaborador es un bloque, es un keyword por los :

- Variable local y asignación.
```smalltalk
| x y |

x := 1.
y := 5.

x+y.
```
Respuesta: 6

X e Y son las variables locales, los := son las asignaciones.

- Símbolo, carácter y array.
```smalltalk
| cosas |

cosas := Array new: 5.
cosas at: 1 put: $a.
cosas at: 2 put: #a.

cosas do: [ :cosa | Transcript show: cosa; cr ].
```
Respuesta: #($a #a nil nil nil) (si le das al print)

Esto si le das al do it y lo ves en el Transcript:  
a  
a  
nil  
nil  
nil  

"cosas" es el array, el primer elemento es un caracter, el segundo es un simbolo que le definí el mismo nombre, pero su longitud es arbitraria y son unicos.
