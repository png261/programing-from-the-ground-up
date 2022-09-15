#
# PURPOSE: This program finds the maximum number of a set of data items.
#
# VARIABLES: The registers have the following uses:
# %edi - index
# %ebx - largest number
# %eax - current number
#
# The following memory locations are used:
# data_items - contains the item data. A 0 is used to terminate the data
#

.section .data
data_items:
    .long 3,67,34,222,45,75,54,34,44,33,22,11,66

.section .text
.globl _start
_start:
    movl $0, %edi
    movl data_items(, %edi, 4), %eax
    movl %eax, %ebx
    
start_loop:
    incl %edi
    movl data_items(, %edi, 4), %eax
    cmpl $0, %eax
    jle loop_exit

    cmpl %ebx, %eax
    jge start_loop
    movl %eax, %ebx
    jmp start_loop

loop_exit:
    movl $1, %eax
    int $0x80
