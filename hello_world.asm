.data

hello: .asciiz "Hello world!\n"
numbers: .word 2, 3

.text
.globl main

main:

li $v0, 4          # print str syscall code
la $a0, hello      # direccion de "Hello world!\n" en $a0
syscall            # print str

la $t0, numbers    # direccion de numbers en $t0

lw $t5, 0($t0)     # 2 a $t5
lw $t6, 4($t0)     # 3 a $t6

add $s2, $t5, $t6  # $s2 = $t5 + $t6

addi $s2, $s2, 5   # $s2 += 5

move $a0, $s2      # copiar $s2 a $a0

li $v0, 1          # print int syscall code
syscall            # print int

li $v0, 10         # exit syscall code
syscall            # exit
