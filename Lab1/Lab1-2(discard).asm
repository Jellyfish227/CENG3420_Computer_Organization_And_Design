.globl _start

.data
	array1: .word -1 22 8 35 5 4 11 2 1 78
	temp: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	n: .word 10
	pivot: .word 8
	space: .ascii "\n"

.text
_start:
	la s0 array1	# load address of array into $a0
	la s1, temp
	lw s2, pivot
	li s3, 0	# init pos of temp cell

	li t0, 0	# t0, int i
	li t1, 10	# t1, loopbound
	jal ra, preLoop
	jal loop_print

	li a7, 10
	ecall

preLoop:
	addi sp, sp, -4
	sw ra, 0(sp)
	j loop1_body
loop1_body:
	bge t0, t1, loop1done
	slli t2, t0, 2	# t2(offset)
	add t3, t2, s0	# update address to read to t3
	lw t3, 0(t3)	# load word from offset location
	bge t3, s2, iterate1
	jal ra, append
	
iterate1:
	addi t0, t0, 1
	j loop1_body

loop1done:
	mv t3, s2
	jal ra, append
	li t0, 0
	j loop2_body

loop2_body:
	bge t0, t1, loop2done
	slli t2, t0, 2	# t2(offset)
	add t3, t2, s0	# update address to read to t3
	lw t3, 0(t3)	# load word from offset location
	ble t3, s2, iterate2
	jal ra, append

iterate2:
	addi t0, t0, 1
	j loop2_body

loop2done:
	li t0, 0
	lw ra, 0(sp)
	addi sp, sp, 4
	ret

append:
	slli t4, s3, 2	# offset of temp array
	add t4, s1, t4	# new pos with offset
	sw t3, 0(t4)	# store value at new position in array
	addi s3, s3, 1	# idx of temp array update
	jr ra

loop_print:
	bge t0, t1, printDone
	slli t2, t0, 2
	add t3, t2, s0
	add t4, t2, s1
	lw t5, 0(t4)
	sw t5, 0(t3)
	mv a0, t5
	li a7, 1
	ecall
	li a7, 4
	la a0, space
	ecall
	addi t0, t0, 1
	j loop_print

printDone:
	ret

