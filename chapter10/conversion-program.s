.include "linux.s"

.section .bss
    .lcomm tmp_buffer, 100

.section .text
.globl _start
_start:
    movl %esp, %ebp

    # interger2string(number, buffer_address)
    pushl $tmp_buffer
    pushl $261
    call integer2string
    addl $8, %esp

    pushl $tmp_buffer 
    call count_chars
    addl $4, %esp

    movl %eax, %edx         # string length
    movl $SYS_WRITE, %eax 
    movl $STDOUT, %ebx
    movl $tmp_buffer, %ecx
    int $LINUX_SYSCALL

    pushl $STDOUT 
    call write_newline

    movl $SYS_EXIT, %eax
    movl $0, %ebx
    int $LINUX_SYSCALL
