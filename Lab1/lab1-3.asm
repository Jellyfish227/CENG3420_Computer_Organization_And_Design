.globl _start

.data 
	space: 	.ascii " "
	array: 	.word 0

.text
_start:
	# read int
	li 	a7, 5	# hard code $a7 as 5 into readInt mode
	ecall
	la	s0, array
	li	s1, 0		# lo
	addi	a0, a0, -1
	mv	s2, a0		# hi
	li	a0, -1		# a0 loop fuction argument
	jal	ra, preLoop	# loop for input
	mv	a1, s1		# $a1 = lo
	mv	a2, s2		# $a2 = high
	jal	ra, QUICKSORT	# quick sort function
	li	a0, 0
	jal	ra, preLoop	# loop for output
	
	li	a7, 10
	ecall

preLoop:
	addi	sp, sp, -8
	sw	a0, 4(sp)
	sw	ra, 0(sp)
	li 	t0, 0	# t0 = looping iterator i = 0
	j 	loop_begin
loop_begin:
	bgt 	t0, s2, loop_end
	lw 	a0, 4(sp)
	blt 	a0, x0, input_action
	beqz 	a0, output_action 

input_action:
	li 	a7, 5
	ecall
	slli 	t2, t0, 2
	add 	t2, t2, s0
	sw 	a0, 0(t2)
	j 	loop_iterate

output_action:
	slli 	t2, t0, 2
	add 	t2, t2, s0
	lw 	a0, 0(t2)
	li 	a7, 1
	ecall
	li 	a7, 4
	la 	a0, space
	ecall
	j 	loop_iterate

loop_iterate:
	addi 	t0, t0, 1
	j 	loop_begin

loop_end:
	li 	t0, 0
	lw 	ra, 0(sp)
	addi 	sp, sp, 4
	jr 	ra

QUICKSORT:		# QUICKSORT(A(s0), lo(a1), hi(a2))
	addi	sp, sp, -4
	sw	ra, 0(sp)

	bgt	a1, a2, ENDSORT
	jal	ra, PARTITION	# return pivot(a0)

	addi	sp, sp, -12
	sw	a2, 8(sp)
	sw	a1, 4(sp)
	sw	a0, 0(sp)
	addi	a2, a0, -1
	jal	ra, QUICKSORT
	lw	a0, 0(sp)
	lw	a1, 4(sp)
	lw	a2, 8(sp)
	addi	sp, sp, 12

	addi	sp, sp, -12
	sw	a2, 8(sp)
	sw	a1, 4(sp)
	sw	a0, 0(sp)
	addi	a1, a0, 1
	jal	ra, QUICKSORT
	lw	a0, 0(sp)
	lw	a1, 4(sp)
	lw	a2, 8(sp)
	addi	sp, sp, 12

ENDSORT:
	lw	ra, 0(sp)
	addi	sp, sp, 4
	jr	ra

PARTITION:	#partition(a(s0), lo(a1), hi(a2))
	addi	sp, sp, -4
	sw	ra, 0(sp)
	slli	t0, a2, 2
	add	t0, t0, s0
	lw	t0, 0(t0)	# pivot = A[hi]
	addi	t1, a1, -1	# i = lo - 1
	mv	t2, a1		# j = lo

LOOP1:
	bgt	t2, a2, LOOPDONE
	slli	t3, t2, 2
	add	t3, t3, s0
	lw	t4, 0(t3)	# temp = A[j]
	bge	t4, t0, ELEMENT_GTE_PIVOT

	addi	t1, t1, 1	# i++
	addi	sp, sp, -4
	sw	t1, 0(sp)
	
	slli	t1, t1, 2
	add 	t1, t1, s0
	lw	t5, 0(t1)
	sw	t5, 0(t3)	# A[i] = A[j]
	sw	t4, 0(t1)	# A[j] = temp

	lw	t1, 0(sp)
	addi	sp, sp, 4
ELEMENT_GTE_PIVOT:
	addi	t2, t2, 1	# j++
	j	LOOP1
LOOPDONE:
	addi	t3, t1, 1	# i++
	mv	a0, t3		# save i + 1 for return
	slli	t3, t3, 2
	add	t3, t3, s0
	lw	t4, 0(t3)	# temp = A[i + 1]

	slli	t5, a2, 2
	add	t5, t5, s0
	lw	t6, 0(t5)	# store A[hi]

	sw	t6, 0(t3)	# A[i+1] = A[hi]
	sw	t4, 0(t5)	# A[hi] = A[i+1]

	lw	ra, 0(sp)
	addi	sp, sp, 4
	jr ra