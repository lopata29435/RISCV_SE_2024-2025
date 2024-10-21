.include "resultCreate.s"      # Include resultCreate function and MacrolIB(macro included in this file)
.include "outputFuncs.s"       # Include functions to output arrays
.include "inputFuncs.s"        # Include functions to input arrays

.data
.align  2                      # Ensure data alignment
n:	      .word 0               # Variable to store the number of elements (size of the array)
arrayA:  .space  40            # Allocate space for the input array (up to 10 elements, assuming 32-bit integers)
arrayB:  .space  40            # Allocate space for the output array (same size)

.global main 

.text
main:
    la s2, arrayA              # Load address of the input array (arrayA) into register s2
    la s3, arrayB              # Load address of the output array (arrayB) into register s3
    la s4, n                   # Load address of the variable n (number of elements) into register s4

    #s2 - arrayA for input, s4 - size of array for input, return filled arrayA
    input_array(s2, s4)        # Call the function to input elements into arrayA (input array) and store size in n

    #s2 - arrayA, s3-arrayB, s4-size of arrays, return filled arrayB
    calculate_answer(s2, s3, s4)  # Call the function to calculate factorials for each element of arrayA, 
                                 # store the results in arrayB

    #s3 - arrayB for output, s4 - size of array for output, returns nothing
    output_array(s3, s4)        # Call the function to output the elements of arrayB (output array)

    exit                       # Exit the program