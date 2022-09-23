.include "linux.s"

.section .data

# ST
.equ ST_VALUE, 8

.section .text
.globl is_negative
.type is_negative, @function

is_negative:
    pushl %ebp
    movl %esp, %ebp
    movl $0, %eax
    movl ST_VALUE(%ebp), %ebx

    cmpl $0, %ebx
    jge exit
    movl $1, %eax

    exit:
        movl %ebp, %esp
        popl %ebp
        ret
