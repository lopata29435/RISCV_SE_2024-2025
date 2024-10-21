.global outputFuncs
.data
prompt: .asciz	" element of result array: "  # Message prompt for output
prompt_test: .asciz	" element of array: "  # Message prompt for test_output
prompt_expected_test: .asciz	" expected element of array: "  # Message prompt for test_output

.text
outputFuncs:
#a2 - array to output, a3 - number of elements in array
out:
	li 	a0, '\n'               # Load newline character into a0
        li 	a7, 11                # System call code for printing a character
        ecall                    # Make the system call to print newline
        
	li t2, 1                 # Initialize t2 with 1 (index counter for the loop)
	mv	t3, a3              # Move the number of elements (a3) to t3 (loop counter)
	
        beqz t3, end_out        #if num of elements equals zero - exit

	loop_output:
        mv 	a0, t2               # Move current index (t2) to a0
        li 	a7, 1                # System call code for printing an integer
        ecall                    # Make the system call to print the current index
        
        la 	a0, prompt            # Load the address of the prompt message into a0
        li 	a7, 4                # System call code for printing a string
        ecall                    # Make the system call to print the prompt message
        
        lw 	a0, (a2)              # Load the value from the result array (pointed by a2) into a0
        li 	a7, 1                # System call code for printing an integer
        ecall                    # Make the system call to print the element value
        
	addi    a2, a2, 4          # Move to the next element in the array (assuming 32-bit integer, hence +4 bytes)
	addi    t2, t2, 1          # Increment the index counter (t2)
        addi    t3, t3, -1        # Decrease the loop counter (t3)
        
        li 	a0, '\n'             # Load newline character into a0
        li 	a7, 11               # System call code for printing a character
        ecall                    # Make the system call to print newline
        
        bnez    t3, loop_output   # If t3 (remaining elements) is not zero, repeat the loop
        
        end_out:
        ret                      # Return from the function
        
#a2 - array to output, a3 - number of elements in array
out_test:
	li 	a0, '\n'               # Load newline character into a0
        li 	a7, 11                # System call code for printing a character
        ecall                    # Make the system call to print newline
        
	li t2, 1                 # Initialize t2 with 1 (index counter for the loop)
	mv	t3, a3              # Move the number of elements (a3) to t3 (loop counter)
	
        beqz t3, end_out        #if num of elements equals zero - exit

	loop_output_test:
        mv 	a0, t2               # Move current index (t2) to a0
        li 	a7, 1                # System call code for printing an integer
        ecall                    # Make the system call to print the current index
        
        la 	a0, prompt_test           # Load the address of the prompt message into a0
        li 	a7, 4                # System call code for printing a string
        ecall                    # Make the system call to print the prompt message
        
        lw 	a0, (a2)              # Load the value from the result array (pointed by a2) into a0
        li 	a7, 1                # System call code for printing an integer
        ecall                    # Make the system call to print the element value
        
	addi    a2, a2, 4          # Move to the next element in the array (assuming 32-bit integer, hence +4 bytes)
	addi    t2, t2, 1          # Increment the index counter (t2)
        addi    t3, t3, -1        # Decrease the loop counter (t3)
        
        li 	a0, '\n'             # Load newline character into a0
        li 	a7, 11               # System call code for printing a character
        ecall                    # Make the system call to print newline
        
        bnez    t3, loop_output_test   # If t3 (remaining elements) is not zero, repeat the loop
        
        end_out_test:
        ret                      # Return from the function 

#a2 - array to output, a3 - number of elements in array
out_exptected_test:
	li 	a0, '\n'               # Load newline character into a0
        li 	a7, 11                # System call code for printing a character
        ecall                    # Make the system call to print newline
        
	li t2, 1                 # Initialize t2 with 1 (index counter for the loop)
	mv	t3, a3              # Move the number of elements (a3) to t3 (loop counter)
	
        beqz t3, end_out_exptected_test        #if num of elements equals zero - exit

	loop_output_exptected_test:
        mv 	a0, t2               # Move current index (t2) to a0
        li 	a7, 1                # System call code for printing an integer
        ecall                    # Make the system call to print the current index
        
        la 	a0, prompt_expected_test            # Load the address of the prompt message into a0
        li 	a7, 4                # System call code for printing a string
        ecall                    # Make the system call to print the prompt message
        
        lw 	a0, (a2)              # Load the value from the result array (pointed by a2) into a0
        li 	a7, 1                # System call code for printing an integer
        ecall                    # Make the system call to print the element value
        
	addi    a2, a2, 4          # Move to the next element in the array (assuming 32-bit integer, hence +4 bytes)
	addi    t2, t2, 1          # Increment the index counter (t2)
        addi    t3, t3, -1        # Decrease the loop counter (t3)
        
        li 	a0, '\n'             # Load newline character into a0
        li 	a7, 11               # System call code for printing a character
        ecall                    # Make the system call to print newline
        
        bnez    t3, loop_output_exptected_test   # If t3 (remaining elements) is not zero, repeat the loop
        
        end_out_exptected_test:
        ret                      # Return from the function           