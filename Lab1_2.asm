.global _start

.data
    endl: .byte '\n'

.text
_start:
    #read int
    li a7, 5 #hard code a7 as 5 into readInt mode
    ecall
    mv t0, a0
    ecall
    mv t1, a0
    ecall
    mv t2, a0
    
    #out int
    li a7, 1
    mv a0, t0
    ecall
    
    #newline
    li a0, 1 # 1 = STDOUT
    la a1, endl
    li a2, 1
    li a7, 64
    ecall
    
    mv a0, t1
    ecall
    mv a0, t2
    ecall
    
    #exit
    li a7, 10
    ecall