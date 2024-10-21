.global inputFuncs

.data
promptN: .asciz 	"input n(length of array): "
promptAif: .asciz	"input "
promptAis: .asciz	" elemnt of array: "
error:  .asciz          "incorrect n \n"  

.text
inputFuncs:
#returns a valid array size in a0
in:
        la      a0, promptN       # Load the address of the prompt message for array size input into a0
        li      a7, 4             # System call to print the prompt message
        ecall                      # Call to display the message
        li      a7, 5             # System call to read an integer (array size)
        ecall                      # Call to read the number
        blez     a0, fail    # If the entered size is less than or equal to 0, jump to fail
        li      t4, 10            # Set the maximum allowed size of the array (10) in t4
        bgt     a0, t4, fail      # If the entered size is greater than 10, jump to fail
        ret                       # Return, with the valid array size stored in a0

in_test:
        mv a0, a4
        blez     a0, fail    # If the entered size is less than or equal to 0, jump to fail
        li      t4, 10            # Set the maximum allowed size of the array (16) in t4
        bgt     a0, t4, fail      # If the entered size is greater than 16, jump to fail
        ret                       # Return, with the valid array size stored in a0

# Entry point for array filling args:(a2, a3)
# a2 - array pointer, a3 - number of array elements
fill:
        li      t2, 1             # Initialize t2 to 1 (current element index)
        mv      t3, a3            # Move the array size (a3) to t3 (remaining elements to process)
loop_input:
        la      a0, promptAif      # Load the address of the prompt message for array element index into a0
        li      a7, 4             # System call to print the prompt message
        ecall                      # Call to display the message
        mv      a0, t2            # Move the current element index (t2) to a0 for display
        li      a7, 1             # System call to print the element index
        ecall                      # Call to display the index
        la      a0, promptAis      # Load the prompt message for inputting the array element into a0
        li      a7, 4             # System call to print the prompt message
        ecall                      # Call to display the message
        li      a7, 5             # System call to read the next integer (array element)
        ecall                      # Call to read the array element
        sw      a0, (a2)          # Store the entered value in memory at the current address in a2 (array address)
        addi    t2, t2, 1         # Increment the current element index (t2)
        addi    a2, a2, 4         # Move to the next array address (assuming 4-byte integers)
        addi    t3, t3, -1        # Decrease the count of remaining elements (t3)
        bnez    t3, loop_input         # If there are more elements, repeat the loop
        ret                       # Return when the array is fully populated

# Prints an error message and exits the program
fail:
        la      a0, error         # Load the address of the error message into a0
        li      a7, 4             # System call to print the error message
        ecall                      # Call to display the error message
        li      a7, 10            # System call to exit the program
        ecall                      # Exit the program
