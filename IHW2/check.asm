.include "macrolib.asm"

.global checkAffiliation

.data
eps: .double 0.01 					# Small epsilon value for floating-point comparison

.text
checkAffiliation:
	# Pop coordinates of the points off the stack (x1, y1, x2, y2, x3, y3, x4, y4)
	pop_double(ft8)				# y4
	pop_double(ft7)				# x4
	pop_double(ft6)				# y3
	pop_double(ft5)				# x3
	pop_double(ft4)				# y2
	pop_double(ft3)				# x2
	pop_double(ft2)				# y1
	pop_double(ft1)				# x1
	
	# Start computation for area calculation using determinant method
    	# First term of the determinant: (x2 * y3) * (y1 - y4)
	fmv.d  ft9,ft3					# Load x2 into ft9
	fmul.d  ft10,ft9,ft9				# ft10 = x2^2
	fmv.d  ft11,ft6					# Load y3 into ft11
    	fmv.d  ft9,ft2					# Load y1 into ft9
	fsub.d  ft11,ft11,ft9				# ft11 = y3 - y1
	fmv.d  ft9,ft7					# Load x4 into ft9
	fmul.d  ft11,ft11,ft9				# ft11 = (y3 - y1) * x4
	fmv.d  fs11,ft2					# Store y1 into fs11 for reuse
	fmv.d  ft9,ft8					# Load y4 into ft9
	fsub.d  fs11,fs11,ft9				# fs11 = y1 - y4
	fmv.d  ft9,ft5					# Load x3 into ft9
	fmul.d  ft9,fs11,ft9				# ft9 = (y1 - y4) * x3
	fadd.d  ft11,ft11,ft9				# ft11 += (y1 - y4) * x3
	# Add the remaining terms of the determinant following similar steps
	# Whole formula you can find in report
	fmv.d  fs11,ft8
	fmv.d  ft9,ft6
	fsub.d  fs11,fs11,ft9
	fmv.d  ft9,ft1
	fmul.d  ft9,fs11,ft9
	fadd.d  ft9,ft11,ft9
	fmul.d  ft10,ft10,ft9
	fmv.d  ft9,ft5
	fmul.d  ft11,ft9,ft9
	fmv.d  fs11,ft8
	fmv.d  ft9,ft2
	fsub.d  ft9,fs11,ft9
	fmul.d  ft11,ft11,ft9
	fmv.d  ft9,ft7
	fmul.d  fs11,ft9,ft9
	fmv.d  fs10,ft2
	fmv.d  ft9,ft6
	fsub.d  ft9,fs10,ft9
	fmul.d  ft9,fs11,ft9
	fadd.d  ft11,ft11,ft9
	fmv.d  fs11,ft6
	fmv.d  ft9,ft8
	fsub.d  fs11,fs11,ft9
	fmv.d  ft9,ft1
	fmul.d  fs10,ft9,ft9
	fmv.d  fs9,ft2
	fmv.d  ft9,ft6
	fsub.d  fs9,fs9,ft9
	fmv.d  ft0,ft2
	fmv.d  ft9,ft8
	fsub.d  ft9,ft0,ft9
	fmul.d  ft9,fs9,ft9
	fadd.d  ft9,fs10,ft9
	fmul.d  ft9,fs11,ft9
	fadd.d  ft11,ft11,ft9
	fmv.d  ft9,ft3
	fmul.d  ft9,ft11,ft9
	fadd.d  ft10,ft10,ft9
	fmv.d  ft11,ft4
	fmv.d  ft9,ft6
	fsub.d  ft11,ft11,ft9
	fmv.d  ft9,ft1
	fneg.d  fs11,ft9
	fmv.d  ft9,ft7
	fmul.d  fs10,ft9,ft9
	fmv.d  fs9,ft4
	fmv.d  ft9,ft8
	fsub.d  fs9,fs9,ft9
	fmv.d  ft0,ft6
	fmv.d  ft9,ft8
	fsub.d  ft9,ft0,ft9
	fmul.d  ft9,fs9,ft9
	fadd.d  ft9,fs10,ft9
	fmul.d  fs11,fs11,ft9
	fmv.d  fs10,ft2
	fmv.d  ft9,ft4
	fsub.d  fs10,fs10,ft9
	fmv.d  ft9,ft7
	fmul.d  fs10,fs10,ft9
	fmv.d  fs9,ft2
	fmv.d  ft9,ft6
	fsub.d  ft9,fs9,ft9
	fmul.d  ft9,fs10,ft9
	fadd.d  fs11,fs11,ft9
	fmv.d  fs10,ft7
	fmv.d  ft9,ft1
	fmul.d  fs10,fs10,ft9
	fmv.d  ft9,ft1
	fmul.d  ft9,fs10,ft9
	fadd.d  ft9,fs11,ft9
	fmul.d  ft9,ft11,ft9
	fadd.d  ft10,ft10,ft9
	fmv.d  ft9,ft5
	fmul.d  ft11,ft9,ft9
	fmv.d  fs11,ft2
	fmv.d  ft9,ft4
	fsub.d  fs11,fs11,ft9
	fmv.d  ft9,ft7
	fmul.d  fs11,fs11,ft9
	fmv.d  fs10,ft4
	fmv.d  ft9,ft8
	fsub.d  fs10,fs10,ft9
	fmv.d  ft9,ft1
	fmul.d  ft9,fs10,ft9
	fadd.d  ft9,fs11,ft9
	fmul.d  ft9,ft11,ft9
	fadd.d  ft10,ft10,ft9
	fmv.d  ft9,ft7
	fmul.d  ft11,ft9,ft9
	fmv.d  fs11,ft4
	fmv.d  ft9,ft2
	fsub.d  ft9,fs11,ft9
	fmul.d  ft11,ft11,ft9
	fmv.d  fs11,ft4
	fmv.d  ft9,ft8
	fsub.d  fs11,fs11,ft9
	fmv.d  ft9,ft1
	fmul.d  fs10,ft9,ft9
	fmv.d  fs9,ft2
	fmv.d  ft9,ft4
	fsub.d  fs9,fs9,ft9
	fmv.d  ft0,ft2
	fmv.d  ft9,ft8
	fsub.d  ft9,ft0,ft9
	fmul.d  ft9,fs9,ft9
	fadd.d  ft9,fs10,ft9
	fmul.d  ft9,fs11,ft9
	fsub.d  ft11,ft11,ft9
	fmv.d  ft9,ft5
	fmul.d  ft9,ft11,ft9
	fadd.d  ft9,ft10,ft9
	
	fabs.d ft9, ft9						# Take the absolute value of the computed determinant
	fld  ft1, eps, a5						# Load epsilon value from memory
	fge.d a0, ft9, ft1					# Compare |determinant| >= epsilon
	ret								# Return result in a0
