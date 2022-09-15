# Run(x86-64):
#   as --32 factorial.s -o factorial.o
#   ld -melf_i386 factorial.o -o factorial
#   ./factorial 

# PURPOSE: compute factorial

.section .data

.section .text
.globl _start
_start:
   pushl $4 
   call factorial
   addl $4, %esp
   
   movl %eax, %ebx
   movl $1, %eax
   int $0x80

factorial:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %eax  # get the parameter
                        # 4(%ebp): return address
                        # 8(%ebp): parameter

    cmpl $1, %eax
    je end_factorial

    # factorial(%eax - 1)
    decl %eax
    pushl %eax
    call factorial
    
    # continue run these instructions after factorial ret
    movl 8(%ebp), %ebx # get the parameter 
    imull %ebx, %eax

end_factorial:
    movl %ebp, %esp
    popl %ebp
    ret

# program run like this:
#    factorial(4) ----> factorial(3) ----> factorial(2) ----> factorial(1)
#                                                                    |
#                                                              number == 1
#                                                                    |
#                                                            => end_factorial: ret
#                                                    go back to wherever function called
#                                                                    |
#                                                                    |
# 4 * 6 = 24  <--ret--  3 * 2 = 6  <--ret--  2 * 1 = 2  <-----ret----|
#    |
# %eax = 24
#    |
#    ---ret--> go back wherever function called
