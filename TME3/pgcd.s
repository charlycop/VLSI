/*----------------------------------------------------------------
//           PGCD                                               //
----------------------------------------------------------------*/
	.text
	.globl	_start 


_start:               
	
    // On donne un valeur a R1 et R0
	MOV r0, #18
    MOV r1, #36

_while: 
    CMP r0, r1  
    BEQ _end    //si r0==r1 on jump
    BGT _else   // si r0>r1 on jump else
    SUB r1, r1, r0
    b _while

_else:
    SUB r0, r0, r1
    b _while

_end:

_good:

_bad:
