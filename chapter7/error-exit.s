.include "linux.s"

.equ ST_ERROR_MSG, 8

.globl error_exit
.type error_exit, @function

error_exit:
    pushl %ebp
    movl %esp, %ebp

    write_msg_STDERR: 
        movl ST_ERROR_MSG(%ebp), %ecx
        pushl %ecx
        call count_chars
        popl %ecx
        movl $STDERR, %ebx
        movl %eax, %edx
        movl $SYS_WRITE, %eax
        int $LINUX_SYSCALL

    pushl $STDERR
    call write_newline

    exit:
        movl $SYS_EXIT, %eax 
        movl $1, %ebx
        int $LINUX_SYSCALL

