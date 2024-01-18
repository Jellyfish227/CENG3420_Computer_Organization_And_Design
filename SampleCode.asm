.global _start
.data 
	welcome_msg:.asciz "Welcome to CENG3420!\n"

.text 
_start:
	la a1,welcome_msg
	addi a0,x0,1
	addi a2,x0,21
	addi a7,x0,64
	ecall
