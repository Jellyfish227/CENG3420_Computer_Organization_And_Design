.globl _start

.data
	array1: 	.word -1 22 8 35 5 4 11 2 1 78
	space: 		.ascii " "

.text
_start:
	la 	s0, array1	# load address of array into $a0
	li 	s1, 0    # lo
	li 	s2, 9   # hi
	
    # move 8 to the end
	li 	t0, 2
	slli 	t0, t0, 2
	add 	t0, t0, s0
	lw  	t1, 0(t0)

	li	t2, 9
	slli 	t2, t2, 2
	add 	t2, t2, s0
	lw  	t3, 0(t2)

	sw  	t1, 0(t2)
	sw  	t3, 0(t0)

	jal 	ra, PARTITION
	li	t0, 0
	li	t1, 9
	jal 	printloop

	li 	a7, 10
	ecall

PARTITION:	#partition(a(s0), lo(s1), hi(s2))
	addi	sp, sp, -4
	sw	ra, 0(sp)

	slli	t0, s2, 2
	add	t0, t0, s0
	lw	t0, 0(t0)	# pivot = A[hi]
	addi	t1, s1, -1	# i = lo - 1
	mv	t2, s1		# j = lo

LOOP1:
	bgt	t2, s2, LOOPDONE
	slli	t3, t2, 2
	add	t3, t3, s0
	lw	t4, 0(t3)	# temp = A[j]
	bge	t4, t0, ELEMENT_GTE_PIVOT

	addi	t1, t1, 1	# i++
	addi	sp, sp, -4
	sw      t1, 0(sp)
	
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

	slli	t5, s2, 2
	add	t5, t5, s0
	lw	t6, 0(t5)	# store A[hi]

	sw	t6, 0(t3)	# A[i+1] = A[hi]
	sw	t4, 0(t5)	# A[hi] = A[i+1]

	lw	ra, 0(sp)
	addi	sp, sp, 4
	jr ra

printloop:
	bgt	t0, t1, printDone
	slli	t2, t0, 2
	add	t3, t2, s0
	lw	t4, 0(t3)
	mv	a0, t4
	li	a7, 1
	ecall
	li	a7, 4
	la	a0, space
	ecall
	addi	t0, t0, 1
	j	printloop

printDone:
	ret