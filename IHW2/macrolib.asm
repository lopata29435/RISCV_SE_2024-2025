.macro input
    # Calls the inputPoints procedure to input points.
    # Simplifies the main code by abstracting the call details.
    jal inputPoints
.end_macro

.macro output
    # Calls the outputResult procedure to output the result.
    # Used to display whether the points belong to the same circle.
    jal outputResult
.end_macro

.macro push_double(%x)
    # Saves the value of register %x onto the stack.
    # Used to temporarily store double values during calculations.
    addi sp, sp, -8           # Decreases the stack pointer, allocating space.
    fsd %x, (sp)              # Stores the value of %x onto the stack.
.end_macro

.macro pop_double(%x)
    # Restores the value from the stack into register %x.
    # Used to retrieve previously saved double values.
    fld %x, (sp)              # Loads the value from the stack into %x.
    addi sp, sp, 8            # Increases the stack pointer, deallocating space.
.end_macro

.macro checkPoints
    # Saves registers containing point coordinates onto the stack
    # and calls the checkAffiliation procedure to verify if points belong to the same circle.
    push_double(fs1)
    push_double(fs2)
    push_double(fs3)
    push_double(fs4)
    push_double(fs5)
    push_double(fs6)
    push_double(fs7)
    push_double(fs8)
    jal checkAffiliation
.end_macro

.macro save_double_in(%x, %y)
    # Moves the values from floating-point registers to specified registers.
    # Used to store double values in %x and %y for further processing.
    fmv.d %x, fa1
    fmv.d %y, fa0
.end_macro

.macro print_int(%x)
    # Prints an integer stored in register %x.
    # Uses a system call to output the value.
    li a7, 1                  # Load system call code for printing an integer.
    mv a0, %x                 # Move the integer to be printed into a0.
    ecall                     # Perform the system call.
.end_macro

.macro print_double(%x)
    # Prints a double value stored in register %x.
    # Uses a system call to output the value.
    li a7, 3                  # Load system call code for printing a double.
    mv fa0, %x                # Move the double value to be printed into fa0.
    ecall                     # Perform the system call.
.end_macro

.macro read_double
    # Reads a double value from the input.
    # Uses a system call to retrieve the value.
    li a7, 7                  # Load system call code for reading a double.
    ecall                     # Perform the system call.
.end_macro

.macro print_str(%x)
    # Prints a string specified by %x.
    # Converts the string to a null-terminated ASCII string and outputs it.
    .data
str:
    .asciz %x                 # Define the string as a null-terminated ASCII string.
    .text
    push_word(a0)             # Save the current value of a0 onto the stack.
    li a7, 4                  # Load system call code for printing a string.
    la a0, str                # Load the address of the string into a0.
    ecall                     # Perform the system call to print the string.
    pop_word(a0)              # Restore the previous value of a0 from the stack.
.end_macro

.macro print_char(%x)
    # Prints a single character specified by %x.
    # Uses a system call to output the character.
    li a7, 11                 # Load system call code for printing a character.
    li a0, %x                 # Load the character into a0.
    ecall                     # Perform the system call.
.end_macro

.macro newline
    # Outputs a newline character.
    # Calls the print_char macro to output '\n'.
    push_word(a0)
    print_char('\n')          # Print the newline character.
    pop_word(a0)
.end_macro

.macro exit
    # Terminates the program execution.
    # Uses a system call to exit.
    li a7, 10                 # Load system call code for program exit.
    ecall                     # Perform the system call to terminate the program.
.end_macro

.macro save_in_memory_on_pointer(%x, %y, %z)
    # Saves a double value into memory at a specific pointer address.
    # Useful for storing values during calculations.
    fsd fa5, %y(sp)
.end_macro

.macro push_word(%x)
    # Saves the value of register %x onto the stack.
    # Used for temporary storage of 32-bit values.
    addi sp, sp, -4           # Decrease the stack pointer, allocating space.
    sw %x, (sp)               # Store the value of %x onto the stack.
.end_macro

.macro pop_word(%x)
    # Restores the value from the stack into register %x.
    # Used to retrieve previously saved 32-bit values.
    lw %x, (sp)               # Load the value from the stack into %x.
    addi sp, sp, 4            # Increase the stack pointer, deallocating space.
.end_macro
