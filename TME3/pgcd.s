/*----------------------------------------------------------------
//           PGCD                                               //
----------------------------------------------------------------*/
	.text
	.globl	_start 

MOV r7, #data
MOV R6, #8
MOV R5, #1

loop:
ADD R5, R5, R5, LSL #2
STRB R5, [R7, #1]
SUBS R6, R6, #1
BNE loop


_good:

_bad:

data: .space 8
