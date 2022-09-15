.section .text

# export function for another program
.globl square
.type square, @function  

square:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %eax
    imull %eax, %eax

    movl %ebp, %esp
    popl %ebp
    ret

    
