#
# PURPOSE: This program finds the maximum number of a set of data items.
#
# VARIABLES: The registers have the following uses:
# %edi - address of current items
# %ebx - smallest number 
# %eax - current number
#
# The following memory locations are used:
# data_items - contains the item data. A 0 is used to terminate the data
# end_data_items: ending address
#

.section .data
data_items:
    .long 2,3,5,4,0,1
end_data_items:

.section .text
.globl _start
_start:
    movl $data_items, %edi # %edi = address of list
    movl (%edi), %eax # get data at %edi address then move to %eax
    movl %eax, %ebx # move %eax to %ebx: %ebx = %eax = 2
    
start_loop:
    addl $4, %edi # +4 byte to the next item, 1 long has 4 byte
    cmpl $end_data_items, %edi # compare current address and ending address
    movl (%edi), %eax 
    je loop_exit

    cmpl %ebx, %eax
    jge start_loop
    movl %eax, %ebx
    jmp start_loop

loop_exit:
    movl $1, %eax
    int $0x80
