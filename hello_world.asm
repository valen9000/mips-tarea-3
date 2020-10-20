.data

hello: .asciiz "Hello world!\n"
numbers: .word 2, 3

.text
.globl main

main:

li $v0, 4
la $a0, hello
syscall

la $t0, numbers

lw $t5, 0($t0)
lw $t6, 4($t0)

add $s2, $t5, $t6

move $a0, $s2

li $v0, 1
syscall

li $v0, 10
syscall
