# PURPOSE: find the largest age in a record file and return to status code 
# ./largest-age record-file

.include "linux.s"
.include "record-def.s"

.section .data
    ERR_STR:
        .string "Oops! Something went wrong!\n"
.equ ERR_STR_LEN, 100

.section .bss
    .lcomm RECORD_BUFFER, RECORD_SIZE

# stack
.equ ST_FILENAME, 8
.equ ST_FD, -4
.equ LARGEST_AGE, -8

.section .text
systemcall: 
    int $LINUX_SYSCALL
    cmpl $0, %eax
    jl print_error
    ret

print_error:
    movl $SYS_WRITE, %eax
    movl $STDOUT, %ebx
    movl $ERR_STR, %ecx
    movl $ERR_STR_LEN, %edx
    int $LINUX_SYSCALL
    movl $SYS_EXIT, %eax
    movl $1, %ebx
    int $LINUX_SYSCALL

.globl _start
_start:
    movl  %esp, %ebp
    subl $8, %esp  

    open_file:
        movl $SYS_OPEN, %eax
        movl ST_FILENAME(%ebp), %ebx
        movl $0, %ecx    
        movl $0666, %edx
        call systemcall
        movl %eax, ST_FD(%ebp)

        movl $0, %edx

    record_read_loop:
        pushl ST_FD(%ebp)
        pushl $RECORD_BUFFER
        call read_record
        addl $8, %esp

        cmpl $RECORD_SIZE, %eax
        jne finished_reading

        check_current_age:
            movl RECORD_BUFFER + RECORD_AGE, %ecx # current age
            cmpl %ecx, LARGEST_AGE(%ebp)
            jge record_read_loop

            movl %ecx, LARGEST_AGE(%ebp) 
            jmp record_read_loop

    finished_reading:
        movl $SYS_EXIT, %eax
        movl LARGEST_AGE(%ebp), %ebx
        int $LINUX_SYSCALL
