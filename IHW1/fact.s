.global fact

.data

.text
fact:
Fact:
        # Base case: if t5 (current argument) > a5, return the result
        bgtu t5, a5, FactReturn  # If t5 > a5, jump to return

        divu t3, t2, t5          # t3 = max_value / current_argument
        bgeu  t3, t6, Safe       # If no overflow, go to Safe

        li t6, 0                 # If overflow, return 0
        mv a0, t5                # Move result to a0
        j FactReturn             # Jump to return

Safe:
        mul t6, t6, t5           # Calculate factorial
        addi t5, t5, 1           # Increment argument
        j Fact        #  Loop

FactReturn:
        mv   a0, t6              # Move result (factorial) to a0
        ret

# Entry point for factorial calculation args:(a2)
# a5 - argument to calculate FactCalcualte(a5) = a5!
FactCalculate:
        li t6, 1                 # Initialize factorial result to 1 (t6)
        li t5, 2                 # Initialize current argument to 1 (t5)
        addi t2, zero,  -1         # Set max value for overflow detection in t2
	
	addi	sp, sp, -4
   	sw	ra, (sp)
	
        jal Fact        # Start recursion
	
	lw	ra, (sp)
   	addi	sp, sp, 4
	
        ret                      # Return the result in a0
