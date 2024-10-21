.include "macrolib.s"          # Include external macros
.include "fact.s"              # Include external factorial calculation logic

.global resultCreate

.text
resultCreate:
#a2 - array (input array of values)
#a3 - new array (output array to store results)
#a4 - num (number of elements in the input array)

createB:
    push(ra)                   # Save return address (ra) on the stack
    li t1, 0                   # Initialize index counter t1 to 0
    lw t4, (a4)                # Load the number of elements (num) into t4
    mv a0, a3                  # Move the pointer to the output array into a0

loop:
    bge t1, t4, end            # If t1 >= num (all elements processed), jump to end
    push(t1)                   # Save the current index on the stack
    
    # Call a macro or function to calculate factorial and store it
    # a2 points to the current input value, a3 points to where the result goes
    calculate_and_store_factorial(a2, a3)  
    
    pop(t1)                    # Restore the current index from the stack
    addi t1, t1, 1             # Increment index counter t1
    addi a2, a2, 4             # Move to the next element in the input array (32-bit int, so +4 bytes)
    addi a3, a3, 4             # Move to the next element in the output array (also 32-bit int, so +4 bytes)
    j loop                     # Jump back to the start of the loop

end:
    pop(ra)                    # Restore return address (ra) from the stack
    ret                        # Return from the function