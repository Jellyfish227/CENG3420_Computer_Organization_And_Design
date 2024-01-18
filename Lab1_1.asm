.global _start

.data 
    var1: .byte 15
    var2: .byte 19
    endl: .byte '\n'

.text
_start:
    lb t1, var1 #load byte to t1
    lb t2, var2 #load byte to t2
    la t3, endl

    #print var1
    mv a0, t1 #move t1 to a0 as arg to print
    li a7, 1 #hard code a7 to printInt mode
    ecall #syscall
    
    #print \n
    li a0, 1 #1=STDOUT
    mv a1, t3 #a1: argument to pass into buffer
    li a2, 1
    li a7, 64 #hard code a7 to write mode
    ecall

    #print var2
    mv a0, t2
    li a7, 1 
    ecall

    #print \n
    li a0, 1 #1=STDOUT
    mv a1, t3 #a1: argument to pass into buffer
    li a2, 1
    li a7, 64 #hard code a7 to write mode
    ecall

    #var1 + 1 -> print
    addi t1, t1, 1
    mv a0, t1
    li a7, 1
    ecall
    
    #print \n
    li a0, 1 #1=STDOUT
    mv a1, t3 #a1: argument to pass into buffer
    li a2, 1
    li a7, 64 #hard code a7 to write mode
    ecall

    #var2 * 4 -> print
    li t0, 4
    mul t2, t2, t0
    mv a0, t2
    li a7, 1
    ecall
    
    #print \n
    li a0, 1 #1=STDOUT
    mv a1, t3 #a1: argument to pass into buffer
    li a2, 1
    li a7, 64 #hard code a7 to write mode
    ecall

    mv t0, t2 #var2' to t0
    mv t2, t1 #var1' to t2
    mv t1, t0 #var2' to t1

     #print var1
    mv a0, t1 #move t1 to a0 as arg to print
    li a7, 1 #hard code a7 to printInt mode
    ecall #syscall
    
    #print \n
    li a0, 1 #1=STDOUT
    mv a1, t3 #a1: argument to pass into buffer
    li a2, 1
    li a7, 64 #hard code a7 to write mode
    ecall

    #print var2
    mv a0, t2
    li a7, 1 
    ecall
    
    #exit
    li a7, 10
    ecall
    