.include "macrolib.asm"

.data
# Test case 1:
T1x_1: .double 28
T1x_2: .double 32
T1x_3: .double 36
T1x_4: .double 32
T1y_1: .double -12
T1y_2: .double -8
T1y_3: .double -12
T1y_4: .double -16
T1res: .word 0
T1expected: .asciz "expected: 4 points belong to the same circle!"

# Test case 2:
T2x_1: .double 1
T2x_2: .double 0
T2x_3: .double 1
T2x_4: .double -1
T2y_1: .double 2
T2y_2: .double 1
T2y_3: .double 0
T2y_4: .double 0
T2res: .word 1
T2expected: .asciz "expected: 4 points don't belong to the same circle!"

# Test case 3:
T3x_1: .double 0
T3x_2: .double 6.19615
T3x_3: .double 1
T3x_4: .double -4.19615
T3y_1: .double 3.47723
T3y_2: .double 0
T3y_3: .double -7.56776
T3y_4: .double 0
T3res: .word 0
T3expected: .asciz "expected: 4 points belong to the same circle!"

# Test case 4:
T4x_1: .double 0
T4x_2: .double 6.19615
T4x_3: .double 1
T4x_4: .double -4.19615
T4y_1: .double 3.47723
T4y_2: .double 0
T4y_3: .double -7.6
T4y_4: .double 0
T4res: .word 1
T4expected: .asciz "expected: 4 points don't belong to the same circle!"

# Test case 5:
T5x_1: .double 0
T5x_2: .double 0
T5x_3: .double 0
T5x_4: .double 0
T5y_1: .double 0
T5y_2: .double 0
T5y_3: .double 0
T5y_4: .double 0
T5res: .word 0
T5expected: .asciz "expected: 4 points belong to the same circle!"

#.global main 

main:
	# Test case 1
	print_str("Test1:\n")
	fld  fs1, T1x_1, a5
	fld  fs2, T1y_1, a5
	fld  fs3, T1x_2, a5
	fld  fs4, T1y_2, a5
	fld  fs5, T1x_3, a5
	fld  fs6, T1y_3, a5
	fld  fs7, T1x_4, a5
	fld  fs8, T1y_4, a5
	print_str("actual result: ")
	checkPoints
	output
	newline
	push_word(a0)
	li a7, 4
	la a0, T1expected
	ecall
	pop_word(a0)
	la t1, T1res
	lw t0, (t1)
	jal checkTest
	
	# Test case 2
	print_str("Test2:\n")
	fld  fs1, T2x_1, a5
	fld  fs2, T2y_1, a5
	fld  fs3, T2x_2, a5
	fld  fs4, T2y_2, a5
	fld  fs5, T2x_3, a5
	fld  fs6, T2y_3, a5
	fld  fs7, T2x_4, a5
	fld  fs8, T2y_4, a5
	print_str("actual result: ")
	checkPoints
	output
	newline
	push_word(a0)
	li a7, 4
	la a0, T2expected
	ecall
	pop_word(a0)
	lw t0, T2res
	jal checkTest
	
	# Test case 3
	print_str("Test3:\n")
	fld  fs1, T3x_1, a5
	fld  fs2, T3y_1, a5
	fld  fs3, T3x_2, a5
	fld  fs4, T3y_2, a5
	fld  fs5, T3x_3, a5
	fld  fs6, T3y_3, a5
	fld  fs7, T3x_4, a5
	fld  fs8, T3y_4, a5
	print_str("actual result: ")
	checkPoints
	output
	newline
	push_word(a0)
	li a7, 4
	la a0, T3expected
	ecall
	pop_word(a0)
	lw t0, T3res
	jal checkTest
	
	# Test case 4
	print_str("Test4:\n")
	fld  fs1, T4x_1, a5
	fld  fs2, T4y_1, a5
	fld  fs3, T4x_2, a5
	fld  fs4, T4y_2, a5
	fld  fs5, T4x_3, a5
	fld  fs6, T4y_3, a5
	fld  fs7, T4x_4, a5
	fld  fs8, T4y_4, a5
	print_str("actual result: ")
	checkPoints
	output
	newline
	push_word(a0)
	li a7, 4
	la a0, T4expected
	ecall
	pop_word(a0)
	lw t0, T4res
	jal checkTest
	
	# Test case 5
	print_str("Test5:\n")
	fld  fs1, T5x_1, a5
	fld  fs2, T5y_1, a5
	fld  fs3, T5x_2, a5
	fld  fs4, T5y_2, a5
	fld  fs5, T5x_3, a5
	fld  fs6, T5y_3, a5
	fld  fs7, T5x_4, a5
	fld  fs8, T5y_4, a5
	print_str("actual result: ")
	checkPoints
	output
	newline
	push_word(a0)
	li a7, 4
	la a0, T5expected
	ecall
	pop_word(a0)
	lw t0, T5res
	jal checkTest
	
	exit

checkTest:
	newline
	bne a0, t0, fail
	print_str("test PASSED!\n")
	print_str("----------------------------------------------------")
	newline
	ret
	fail:
	print_str("test FAILED!\n")
	exit