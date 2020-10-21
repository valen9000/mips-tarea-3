# Tarea de MIPS \#3

Un ejercicio de traducir _assembler_ de MIPS a código máquina.
Más info en el [blog](https://la35.net/orga/mips-maquina.html).

## Ejercicio

Leer el código de `hello_world.asm` de este repo y completar la siguiente tabla. Aclarar todo lo necesario en la sección de comentarios como se muestra en el ejemplo.

|Instrucción|Tipo|_op_|_rs_|_rt_|_rd_|_shamt_|_funct_|_imm_|_addr_|Comentarios|
|---|---|---|---|---|---|---|---|---|---|---|
|`li $v0, 4`| | | | | | | | | |\#1 |
|`la $a0, hello`| | | | | | | | | |
|`syscall`| | | | | | | | | |
|`la $t0, numbers`| | | | | | | | | |
|`lw $t5, 0($t0)`| | | | | | | | | |
|`lw $t6, 4($t0)` | | | | | | | | | |
|`add $s2, $t5, $t6`| | | | | | | | | |
|`addi $s2, $s2, 5`| | | | | | | | | |
|`move $a0, $s2`| | | | | | | | | |
|`li $v0, 1`| | | | | | | | | |
|`syscall`| | | | | | | | | |
|`li $v0, 10`| | | | | | | | | |
|`syscall`| | | | | | | | | |

## Comentarios

1. es una pseudoinstrucción, se reemplaza por `ori` (_or immediate_).
