.include "resultCreate.s"
.include "outputFuncs.s"
.include "inputFuncs.s"

.data
.align  2
arrayB:      .space 40               # Space for storing results

testArray1:  .word 1, 2, 3, 4, 5    	# Simple array
testArray2:  .word 0, 1, 2, 10      	# Array with zero and a large number
testArray3:  .word -1, 6, 7, 8      	# Array with a negative number
testArray4:  .word 14, 15, 200         # Array with numbers those cause overflow
emptyArray:  .word 0                 	# Empty array for boundary case
bigArray:  .word 0                 		# Big array for boundary case

n1:          .word 5                 	# Size of array 1
n2:          .word 4                 	# Size of array 2
n3:          .word 4                 	# Size of array 3
n4:          .word 3                 	# Size of array 4
nEmpty:      .word -2                 # Size of empty array
nBig:        .word 15                	# Size of too big array

expectedResults1: .word 1, 2, 6, 24, 120        	# Expected results for testArray1
expectedResults2: .word 1, 1, 2, 3628800        	# Expected results for testArray2
expectedResults3: .word 0, 720, 5040, 40320     	# Expected results for testArray3 
expectedResults4: .word 0, 0, 0                 		# Expected results for testArray4
expectedEmpty:    .word 0                       		# Expected results for emptyArray
expectedBig:      .word 0                      		 	# Expected results for emptyArray

.global main

.text
main:

    # Test 1: Simple array
    la s2, testArray1               # Load address of the first test array
    la s3, arrayB                   # Load address for results
    la s4, n1				# Load size of the array
    #check inputed size. s4 - size
    read_n_test(s4)             # Check size of the array
    la s5, expectedResults1          # Load expected results
    #s2 - array for input, s4 - size of both arrays, s5 - array witch correct answer
    jal print_test_info              # Print test info
    #s2 - arrayA, s3 - arrayB(result), s4 - size of arrays
    calculate_answer(s2, s3, s4)     # Call to calculate factorials for the array
    print_str("Actual output: ")
    #s3 - array for output, s4 - size of array
    output_array(s3, s4) 
    #s5 - array with correct answer, s3 - array with result, s4 - size of both arrays
    jal check_results                 # Check the results for test 1

    # Test 2: Array with zero and large number
    la s2, testArray2
    la s3, arrayB
    la s4, n2
    #check inputed size. s4 - size
    read_n_test(s4)
    la s5, expectedResults2         
    #s2 - array for input, s4 - size of both arrays, s5 - array witch correct answer 
    jal print_test_info
    #s2 - arrayA, s3 - arrayB(result), s4 - size of arrays              
    calculate_answer(s2, s3, s4)     
    print_str("Actual output: ")
    #s3 - array for output, s4 - size of array
    output_array(s3, s4)
    #s5 - array with correct answer, s3 - array with result, s4 - size of both arrays
    jal check_results

    # Test 3: Array with negative number (invalid input)
    la s2, testArray3
    la s3, arrayB
    la s4, n3
    #check inputed size. s4 - size
    read_n_test(s4)
    la s5, expectedResults3
    #s2 - array for input, s4 - size of both arrays, s5 - array witch correct answer
    jal print_test_info
    #s2 - arrayA, s3 - arrayB(result), s4 - size of arrays
    calculate_answer(s2, s3, s4)
    print_str("Actual output: ")
    #s3 - array for output, s4 - size of array
    output_array(s3, s4) 
    #s5 - array with correct answer, s3 - array with result, s4 - size of both arrays
    jal check_results 

    # Test 4: Array with negative number (invalid input)
    la s2, testArray4
    la s3, arrayB
    la s4, n4
    #check inputed size. s4 - size
    read_n_test(s4)
    la s5, expectedResults4
    #s2 - array for input, s4 - size of both arrays, s5 - array witch correct answer
    jal print_test_info
    #s2 - arrayA, s3 - arrayB(result), s4 - size of arrays
    calculate_answer(s2, s3, s4)
    print_str("Actual output: ")
    #s3 - array for output, s4 - size of array
    output_array(s3, s4) 
    #s5 - array with correct answer, s3 - array with result, s4 - size of both arrays
    jal check_results 

   #Use these test separatly

    # Test 5: Empty array
    la s2, emptyArray
    la s3, arrayB
    la s4, nEmpty
    #check inputed size. s4 - size
    read_n_test(s4)
    la s5, expectedEmpty
    #s2 - array for input, s4 - size of both arrays, s5 - array witch correct answer
    jal print_test_info
    #s2 - arrayA, s3 - arrayB(result), s4 - size of arrays
    calculate_answer(s2, s3, s4)
    print_str("Actual output: ")
    #s3 - array for output, s4 - size of array
    output_array(s3, s4) 
    #s5 - array with correct answer, s3 - array with result, s4 - size of both arrays
    jal check_results 

    # Test 6: Too big array
    la s2, bigArray
    la s3, arrayB
    la s4, nBig
    #check inputed size. s4 - size
    read_n_test(s4)
    la s5, expectedBig
    #s2 - array for input, s4 - size of both arrays, s5 - array witch correct answer
    jal print_test_info
    #s2 - arrayA, s3 - arrayB(result), s4 - size of arrays
    calculate_answer(s2, s3, s4)
    print_str("Actual output: ")
    #s3 - array for output, s4 - size of array
    output_array(s3, s4) 
    #s5 - array with correct answer, s3 - array with result, s4 - size of both arrays
    jal check_results 

    # Exit the program
    exit

# Function to print test information
print_test_info:
    push(ra)
    print_str("Running test with array: ")
    #s2 - array for output, s4 - size of array
    output_test_array(s2, s4)                # Print the current test array
    print_str("Expected results: ")
    #s5 - array for output, s4 - size of array
    output_expected_array(s5, s4)
    pop(ra)
    ret

# Function to check results
check_results:
    li t2, 0                         # Initialize index
    lw t5, (s4)
check_loop:
    lw t3, (s5)                     # Load expected result
    lw t4, (s3)                     # Load actual result
    bne t3, t4, test_failed_label     # If they don't match, fail the test
    addi s5, s5, 4                   # Move to next expected result
    addi s3, s3, 4                   # Move to next actual result
    addi t2, t2, 1                   # Increment index
    bne t2, t5, check_loop           # Loop if there are more results
    print_str("Test passed\n")
    print_str("-----------------------------\n")
    ret

test_failed_label:
    print_str("Test failed\n")
    exit
