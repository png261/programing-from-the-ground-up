# Run(x86-64):
#   as --32 square.s -o square.o
#   as --32 square_test.s -o square_test.o
#   ld -melf_i386 square.o square_test.o -o square_test
#   ./square_test 

.section .text

.globl _start
_start:
    # square(2)
    pushl $2
    call square
    movl %eax, %ebx
    movl $1, %eax
    int $0x80
