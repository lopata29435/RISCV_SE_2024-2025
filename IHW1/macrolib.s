.macro read_n_test(%x)
   # Read a value %x and store it in %y
   lw a4, (%x)
   jal in_test                   # Call 'in' to read value into a0
.end_macro

.macro output_test_array(%x, %y)
   # Output elements of array %x, with the number of elements in %y
   lw a3, (%y)               # Load the number of elements (size of the array) into a3
   mv a2, %x                 # Move the array's starting address into a2
   jal out_test             # Call the 'output_test_array function to print the test array
.end_macro

.macro output_expected_array(%x, %y)
   # Output elements of array %x, with the number of elements in %y
   lw a3, (%y)               # Load the number of elements (size of the array) into a3
   mv a2, %x                 # Move the array's starting address into a2
   jal out_exptected_test                   # Call the 'out_test_expected' function to print the expected array
.end_macro

.macro output_array(%x, %y)
   # Output elements of array %x, with the number of elements in %y
   lw a3, (%y)               # Load the number of elements (size of the array) into a3
   mv a2, %x                 # Move the array's starting address into a2
   jal out                   # Call the 'out' function to print the array
.end_macro

.macro input_array(%x, %y)
   # Input elements into array %x and store the size of the array in %y
   jal in                    # Call the 'in' function to input array size into a0
   sw a0, (%y)               # Store the input size into the memory at address %y
   mv a2, %x                 # Move the array's starting address into a2
   lw a3, (%y)               # Load the size of the array into a3
   jal fill                  # Call the 'fill' function to populate the array
.end_macro

.macro calculate_answer(%x, %y, %z)
   # Calculate the factorial for each element in array %x, storing results in %y (new array)
   # The number of elements is in %z
   mv a2, %x                 # Move the address of the input array into a2
   mv a3, %y                 # Move the address of the result array into a3
   mv a4, %z                 # Move the size of the array into a4
   jal createB               # Call the 'createB' function to compute factorials
.end_macro

.macro calculate_and_store_factorial(%x, %y)
   # Calculate the factorial of the value at %x and store the result in %y
   lw a5, (%x)               # Load the element from the array at address %x into a5
   jal FactCalculate         # Call the factorial calculation function
   sw a0, (%y)               # Store the result in the output array at address %y
.end_macro

.macro print_int(%x)
   # Print an integer stored in %x
   li a7, 1                  # Load system call code for printing an integer
   mv a0, %x                 # Move the integer to be printed into a0
   ecall                     # Perform system call to print integer
.end_macro

.macro read_int_a0
   # Read an integer from input and store in a0
   li a7, 5                  # Load system call code for reading an integer
   ecall                     # Perform system call to read integer
.end_macro

.macro read_int(%x)
   # Read an integer into %x
   push(a0)                  # Save the current value of a0 on the stack
   li a7, 5                  # Load system call code for reading an integer
   ecall                     # Perform system call to read integer
   mv %x, a0                 # Move the read value into %x
   pop(a0)                   # Restore a0 from the stack
.end_macro

.macro read_n(%x)
   # Read a value and store it in %x
   jal in                    # Call 'in' to read value into a0
   mv %x, a0                 # Move the read value into %x
.end_macro

.macro read_array(%x, %y)
   # Read an array starting at address %x with size in %y
   mv a2, %x                 # Move the array's starting address into a2
   mv a3, %y                 # Move the size of the array into a3
   jal fill                  # Call the 'fill' function to read elements into the array
.end_macro

.macro print_array(%x, %y)
   # Print the elements of array %x, with the number of elements in %y
   mv a2, %x                 # Move the array's starting address into a2
   mv a3, %y                 # Move the size of the array into a3
   jal out                   # Call the 'out' function to print the array
.end_macro

.macro print_str(%x)
   # Print a string %x
   .data
str:
   .asciz %x                 # Store the string as a null-terminated ASCII string
   .text
   push(a0)                  # Save the current value of a0 on the stack
   li a7, 4                  # Load system call code for printing a string
   la a0, str                # Load the address of the string into a0
   ecall                     # Perform system call to print string
   pop(a0)                   # Restore a0 from the stack
.end_macro

.macro print_char(%x)
   # Print a single character %x
   li a7, 11                 # Load system call code for printing a character
   li a0, %x                 # Load the character into a0
   ecall                     # Perform system call to print character
.end_macro

.macro newline
   # Print a newline character
   print_char('\n')          # Call macro to print newline character
.end_macro

.macro exit
   # Exit the program
   li a7, 10                 # Load system call code for program exit
   ecall                     # Perform system call to exit the program
.end_macro

.macro push(%x)
   # Push the value of register %x onto the stack
   addi sp, sp, -4           # Decrement the stack pointer to allocate space
   sw %x, (sp)               # Store the value of %x onto the stack
.end_macro

.macro pop(%x)
   # Pop the value from the stack into register %x
   lw %x, (sp)               # Load the value from the stack into %x
   addi sp, sp, 4            # Increment the stack pointer to deallocate space
.end_macro
