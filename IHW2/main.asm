.include "macrolib.asm"

.global main 

.text
main:
    input                # Call the input macro to read points' coordinates.
    #x1 - fs1, y1 - fs2, x2 - fs3, y2 - fs4, x3 - fs5, y3 - fs6, x4 - fs7, y4 - fs8
    #returns result in a0
    checkPoints          # Call the macro to check if the points belong to the same circle.
    output               # Call the macro to output the result of the check.
    exit                 # Call the macro to exit the program.