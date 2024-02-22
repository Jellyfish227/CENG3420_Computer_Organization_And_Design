.globl main

.data
	array1:	.word	-1 22 8 35 5 4 11 2 1 78
	
.text
main:

# main function body
	addi sp, sp, -4
	sw ra, 0(sp)
	la a0, array1
	li a1, 10

	jal partition	# partition(Array1, n)
	
	lw ra, 0(sp)
	addi sp, sp, 4

# print elements loop
	addi sp, sp, -4
	sw ra, 0(sp)
	
	jal printloop

	lw ra, 0(sp)
	addi sp, sp, 4
	ret

partition:
	addi sp, sp, -8
	sw a0, 4(sp)
	sw a1, 0(sp)

	li s0, 8	# pivot
	li s1, 0	# start
	li s2, 10	# end / loopbound

	# put 8 to the end of the array
	li a1, 3	# pos of 8
	mv a2, t2	# pos of end
	addi sp, sp, -4
	sw ra, 0(sp)
	jal swap	# a0 remain address of array
	lw ra, 0(sp)
	addi sp, sp, 4	# release stack used for return address

	subi t0, s1, 1	# i = t0
	mv t1, s1	# j = t1

	j loop_body	# rtn a0->array, t0 

	mv a1, s2
	mv a2, 

	jr ra

loop_body:	# a0 pass in array, a0 return i
# if i < n continue, otherwise break
# if i > n do to done	# t2 -> count indicator
	slt t2, t1, s2	# if j < hi i.e. when t1 > s2 -> t2 = 0, else 1
	beq t2, x0, loop_done 

# loop instructions
	li t3, 4	# t3 -> sizeof(word)
	mul t4, t1, t3	# get offset of array1[j] -> t4
	add t5, t4, a9	# get address of array1[j] -> t5
	lw t5, 0(t5)	# load value from array1[j] -> t5
	slt t6, t5, s0
	beqz t6, is_smaller	# branch equal to zero

#i++
	addi t1, t1, 1
	j loop_body

loop_done:
	mv a0, t0
	ret

is_smaller: 
	addi t0, t0, 1
	mv a1, t0	# parameter i
	mv a2, t1	# parameter j
	addi sp, sp, -16
	sw t0, 12(sp)
	sw t1, 8(sp)
	sw t3, 4(sp)
	sw ra, 0(sp)
	j swap
	lw ra, 0(sp)
	lw t3, 4(sp)
	lw t1, 8(sp)
	lw t0, 12(sp)

	ret
printloop:
	li t0, 0
	li t1, 4
	mul t3, t0, t1
	add t4, a0, t3
	lw a0, 0(t4)

swap:	#swap(pos1, pos2)	# ra return type
	li t0, 4
	mul t1, a1, t0	# a1 * sizeof(word) -> t1
	add t1, t1, a0	# t1 + address -> t1
	mul t2, a2, t0	# a2 * sizeof(word) -> t2
	add t2, t2, a0	# t2 + address -> t2
	lw t3, 0(t1)
	lw t4, 0(t2)
	sw t4, 0(t1)
	sw t3, 0(t2)
	jr ra
