# run 
# make std-number
# echo "4" | ./std-number
# echo $?

.include "linux.s"

.equ buffer_size, 3 # max 255
.section .bss
    .lcomm tmp_buffer, buffer_size

.section .text
.globl _start
_start:
    movl $SYS_READ, %eax
    movl $STDIN, %ebx
    movl $tmp_buffer, %ecx
    movl $buffer_size, %edx
    int $LINUX_SYSCALL

    # string get from std have "\n", or "\r" it need to be remove 
    # or input not valid like "4r" => "4"
    pushl $tmp_buffer
    call number_trim
    addl $4, %esp

    pushl $tmp_buffer
    call count_chars
    addl $4, %esp

    pushl $tmp_buffer
    call number2integer
    addl $4, %esp

    movl %eax, %ebx
    movl $SYS_EXIT, %eax 
    int $LINUX_SYSCALL
