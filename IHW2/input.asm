.include "macrolib.asm"

.global inputPoints

.data
error:  .asciz          "fail"  

.text
inputPoints:
	push_word(ra)                               		# Save return address on the stack
	li a5, 1							# Set the index of the first point in a5
	jal inputPoint                              		# Call inputPoint to read the first point
    	save_double_in(fs1, fs2)                    	# Store the x,y-coordinates of the first point in fs1, fs2
	li a5, 2							# Set the index of the second point in a5
	jal inputPoint                              		# Call inputPoint to read the second point
    	save_double_in(fs3, fs4)                    	# Store the x,y-coordinates of the second point in fs3, fs4
	li a5, 3							# Set the index of the third point in a5
	jal inputPoint                              		# Call inputPoint to read the third point
	save_double_in(fs5, fs6)                    	# Store the x,y-coordinates of the third point in fs5, fs6
	li a5, 4							# Set the index of the first fourth in a5
	jal inputPoint                              		# Call inputPoint to read the fourth point
	save_double_in(fs7, fs8)                    	# Store the x,y-coordinates of the fourth point in fs7, fs8
	pop_word(ra)                                		# Restore return address from the stack
	ret                                         			# Return to the caller
	
inputPoint:
        print_str("input X")                    		# Display the "input X" prompt
        print_int(a5)                           			# Display the current index
        print_str(": ")                				# Display the ": " separator
        read_double                             		# Read the x-coordinate input
        fmv.d fa1, fa0                             		# Store the x-coordinate in fa1 temporarily
        print_str("input Y")                    		# Display the "input Y" prompt
        print_int(a5)                           			# Display the current index
        print_str(": ")                				# Call to display the index
        read_double                             		# Read the y-coordinate input
        ret                       			    		# Return, with x-coordinate in fa1 and y-coordinate in fa0
