.globl _start

.data
	space: .ascii "\n"

.text
_start:
	# read int
	li a7, 5	# hard code $a7 as 5 into readInt mode
	ecall
	mv t0, a0
	ecall
	mv t1, a0
	ecall
	mv t2, a0

	# modify integer
	addi t0, t0, 3
	li t3, 2
	mul t1, t1, t3
	add t2, t2, t0
	add t2, t2, t1
	
	# out int
	li a7, 1
	mv a0, t0
	ecall
	
	jal prtNL	# call func. printNewLine
	
	li a7, 1	# mode prtInt
	mv a0, t1
	ecall

	jal prtNL	# call func. prtNL

	li a7, 1	# mode prtInt
	mv a0, t2
	ecall
	
	jal exit
exit:
	li a7, 10
	ecall

# print linefeed function
prtNL:
	li a7, 4
	la a0, space
	ecall
	ret