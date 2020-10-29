# Tarea de MIPS \#3

Un ejercicio sobre la diferencia entre _assembler_ de MIPS y código máquina.
Más info en el [blog](https://la35.net/orga/mips-maquina.html). Forkear este repo para realizar la tarea.

## Antes del ejercicio

Leer el código de `hello_world.asm` de este repo. Si lo cargamos en el SPIM el ensamblador produce código máquina (en hexadecimal) para la función `main` en `0x00400024`. También carga los datos de la sección `.data` a partir de la dirección `0x10010000`.

### Datos

Cabe aclarar que en la sección de _static data_ definimos dos etiquetas. La primera, `hello` apunta a `0x10010000`. La segunda, `numbers` apunta a `0x10010010` o `numbers` + 16.

El _string_ `Hello world!\n` ocupa 14 bytes, un byte por caracter. El `\n` es el caracter de nueva línea y como usamos la directiva `.asciiz` el _string_ termina en el _null byte_ (`0x00`).  Por cuestiones de alineación los números 2 y 3 de `numbers` tienen que empezar a partir de la dirección `0x10010010` ya que cada número ocupa 4 bytes, cada entero es un _word_ de 32 bits.

Si vemos la sección `.data` en el SPIM vemos que el orden de los caracteres es extraño.

|Dirección   | Contenidos (en Hex) | ASCII         |
|------------|---------------------|---------------|
|`0x10010000`|`6c6c6548 6f77206f`  |`lleH oW o`    |
|`0x10010008`|`21646c72 0000000a`  |`!dlr \0\0\0\n`|

Esto se debe a algo llamado _endianness_ y tiene que ver con el orden de los bytes dentro de una palabra de memoria. En este caso SPIM invierte el orden de los bytes porque está simulando la CPU en modo _little endian_ e interpreta los 4 bytes de una _word_ como si fueran un número entero de 32 bits. Pero en realidad en memoria los caracteres se guardan en el orden natural, SPIM lo invierte por nosotros pensando que se trata de un entero.

### Pseudoinstrucciones

A partir de `0x00400024` aparecen las instrucciones de la función `main`. Varias de ellas en realidad son pseudoinstrucciones que el ensamblador reemplaza por una o más instrucciones reales.

No hay una sola manera de reemplazar las pseudoinstrucciones, pero vamos a seguir lo que hace el ensamblador de MIPS acá.

1. `li` es una pseudoinstrucción, se reemplaza por `ori` (_or immediate_).
2. `la` es una pseudoinstrucción, se reemplaza por `lui` (_load upper immediate_) más un `ori` de ser necesario.
3. `move` es una pseudoinstrucción, se reemplaza por `addu` (_add unsigned_).

La pseudoinstrucción _load address_ merece una explicación aparte. Si miramos con atención la pantalla del SPIM vemos que en el primer `la` se usa un `lui` y en el segundo, el de `la $t0, numbers` se usan el `lui` seguido de un `ori`.

La instrucción `lui` (_load upper immediate_) como su nombre lo indica carga una constante de 16 bits en los 16 bits de mayor valor de un registro. Cada registro tiene 32 bits, la primer mitad del bit 0 al 15 y la segunda mitad del 16 al 31. La instrucción `lui` carga la constante en los bits 16 al 31. Por eso en el SPIM vemos `lui $4, 4097 [hello]`, donde el número 4097 es el valor de la etiqueta `hello` en decimal. En hexadecimal es `0x1001`. Los 16 bits de menor valor simplemente valen cero, dando así la dirección correcta donde empieza el _string_ `"Hello world!\n"` que como dijimos era `0x10010000`.

En cambio para el segundo `la`, el de la etiqueta `numbers` el ensamblador sabe que la etiqueta apunta a `hello + 16`. Por eso ejecuta `lui $1, 4097` seguido de un `ori $8, $1, 16` o `ori $t0, $at, 16`. En este caso el ensamblador hace uso del registro `$at` o _assembler temporary_ para guardar el valor parcial de `numbers`.   

Un último detalle, la instrucción `syscall` es atípica pero no es una pseudoinstrucción. Oficialmente es una instrucción de formato R, pero no hay registros involucrados en la codificación de la instrucción. Simplemente la ensamblan a `0x0000000c` y tiene dos campos de 6 bits, el _opcode_ y el código de función (_funct_). En el medio de la instrucción hay 20 bits que siempre valen cero.

La función `main` después de reemplazar todas las pseudoinstrucciones por instrucciones reales y usando los números de los registros en vez de sus nombres queda como sigue.

```
1      ori $2, $0, 4
2      lui $4, 4097 [hello]
3      syscall
4      lui $1, 4097 [numbers]
5      ori $8, $1, 16 [numbers]   
6      lw $13, 0($8)
7      lw $14, 4($8)
8      add $18, $13, $14
9      addi $18, $18, 5  
10     addu $4, $0, $18
11     ori $2, $0, 1
12     syscall     
13     ori $2, $0, 10    
14     syscall
```

## Ejercicio

Completar la siguiente tabla. Aclarar todo lo necesario en la sección de comentarios como se muestra en el ejemplo.

Los _opcodes_ y códigos de función de las instrucciones pueden encontrarse por Internet, por ejemplo [acá](https://en.wikibooks.org/wiki/MIPS_Assembly/Instruction_Formats). Recuerden que en las instrucciones tipo R el campo _op_ es siempre cero y la operación se determina por el valor de _funct_.

|Hex     |Tipo|_op_  |_rs_ |_rt_ |_rd_ |_shamt_|_funct_|_imm_           |Comentarios|
|--------|----|------|-----|-----|-----|-------|-------|----------------|---|
|34020004|I   |001101|00000|00010|NA   |NA     |NA     |0000000000000100|\#1|
|        |    |      |     |     |     |       |       |                |   |
|        |    |      |     |     |     |       |       |                |   |
|        |    |      |     |     |     |       |       |                |   |
|        |    |      |     |     |     |       |       |                |   |
|        |    |      |     |     |     |       |       |                |   |
|        |    |      |     |     |     |       |       |                |   |
|        |    |      |     |     |     |       |       |                |   |
|        |    |      |     |     |     |       |       |                |   |
|        |    |      |     |     |     |       |       |                |   |
|        |    |      |     |     |     |       |       |                |   |
|        |    |      |     |     |     |       |       |                |   |
|        |    |      |     |     |     |       |       |                |   |
|        |    |      |     |     |     |       |       |                |   |

### Comentarios

1. `ori $v0, $zero, 4` reemplaza a `li $v0, 4` que es una pseudoinstrucción. En las instrucciones de tipo I el registro de destino es `rt` en vez de `rd`. Los campos que no se usan dicen "NA" por "no aplica".
