# Tarea de MIPS \#3

Un ejercicio sobre la diferencia entre _assembler_ de MIPS y código máquina.
Más info en el [blog](https://la35.net/orga/mips-maquina.html).

## Ejercicio

Leer el código de `hello_world.asm` de este repo. Si lo cargamos en el SPIM el ensamblador produce el siguiente código máquina (en hexadecimal) para la función `main`.

```
1     34020004
2     3c041001
3     0000000c
4     3c011001
5     34280010
6     8d0d0000
7     8d0e0004
8     01ae9020
9     22520005
10    00122021
11    34020001
12    0000000c
13    3402000a
14    0000000c
```

Que en _assembler_ corresponde al siguiente código.

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

Cabe aclarar que en la sección de _static data_ definimos dos etiquetas. La primera, `hello` apunta a `0x10010000`. La segunda, `numbers` apunta a `0x10010010`.

Completar la siguiente tabla. Aclarar todo lo necesario en la sección de comentarios como se muestra en el ejemplo.

|Hex     |Tipo|_op_  |_rs_ |_rt_ |_rd_ |_shamt_|_funct_|_imm_           |Obs|
|--------|----|------|-----|-----|-----|-------|-------|----------------|---|
|34020004|I   |001101|00000|00010|NA   |NA     |NA     |0000000000000100|\#1|


## Comentarios

1. `li` es una pseudoinstrucción, se reemplaza por `ori` (_or immediate_).
2. `la` es una pseudoinstrucción, se reemplaza por `lui` (_load upper immediate_).
3. `move` es una pseudoinstrucción, se reemplaza por `addu` (_add unsigned_).
