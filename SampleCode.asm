.globl _start
.data 
	welcome_msg:.asciz "Welcome to CENG3420!\n"

.text 
_start:
	la a1,welcome_msg
	addi a0,x0,1
	addi a2,x0,21
	addi a7,x0,64
	ecall

## PC: program counter like pointer to instruction
## next location of instruction is usually PC+4
## system in 32-bit system jump a whole word(32-bit)-> 4byte
##