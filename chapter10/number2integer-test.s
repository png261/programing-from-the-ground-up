.include "linux.s"
.section .data
    string_number: .ascii "261\0"
.section .bss
    .lcomm tmp_buffer, 100

.section .text
.globl _start
_start:
    movl %esp, %ebp

    pushl $string_number
    call number2integer

    # interger2string(number, buffer_address)
    pushl $tmp_buffer
    pushl %eax
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
