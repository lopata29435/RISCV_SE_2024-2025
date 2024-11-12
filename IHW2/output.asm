.include "macrolib.asm"

.global outputResult

.text
outputResult:
    # Check the value of a0 (result from the determinant calculation)
    beqz a0, yes             			# If a0 == 0, jump to the 'yes' label

    # Case when points do not belong to the same circle
    print_str("4 points don't belong to the same circle!")
    j return                 			# Jump to the return label

yes:
    # Case when points belong to the same circle
    print_str("4 points belong to the same circle!")

return:
    # Return to the caller
    ret
