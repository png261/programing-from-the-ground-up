.include "linux.s"

.section .bss
    .lcomm tmp_buffer, 100

.section .text

# stack
.equ ST_STRING_NUMBER, 8   

.globl _start
_start:
    movl %esp, %ebp

    # argv number is a string so we need to convert it to integer
    pushl ST_STRING_NUMBER(%ebp) 
    call number2integer 

    pushl %eax
    call is_negative

    pushl $tmp_buffer
    pushl %eax
    call integer2string

    pushl $tmp_buffer
    call count_chars
    addl $4, %esp

    movl %eax, %edx
    movl $SYS_WRITE, %eax
    movl $STDOUT, %ebx
    movl $tmp_buffer, %ecx
    int $LINUX_SYSCALL

    pushl $STDOUT
    call write_newline

    movl $SYS_EXIT, %eax
    movl $0, %ebx
    int $LINUX_SYSCALL
