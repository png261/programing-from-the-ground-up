# Run(x86-64):
#   as --32 heynow.s -o heynow.o
#   ld -melf_i386 heynow.o -o heynow
#   ./heynow
#   cat heynow.txt

# system call numbers
.equ SYS_OPEN,  5
.equ SYS_WRITE, 4
.equ SYS_READ,  3
.equ SYS_CLOSE, 6
.equ SYS_EXIT,  1

# read/write flags
.equ O_RDONLY, 0                    
.equ O_CREAT_WRONLY_TRUNC, 03101   

# system call interrupt
.equ LINUX_SYSCALL, 0x80
.equ END_OF_FILE,   0         # read() return this when hit the end of file

.section .data
FILENAME:
    .string "heynow.txt"
.equ STR_LEN, 100
STRING:
    .string "Hey diddle diddle!"

.equ BUFFER_SIZE, 100
.bss
    .lcomm FD_OUT, 4

.section .text
.globl _start
_start:
    open_file:
        movl $SYS_OPEN, %eax
        movl $FILENAME, %ebx
        movl $O_CREAT_WRONLY_TRUNC, %ecx
        movl $0666, %edx
        int $LINUX_SYSCALL
        movl %eax, FD_OUT

    write_file:
        movl $SYS_WRITE, %eax
        movl FD_OUT, %ebx
        movl $STRING, %ecx
        movl $STR_LEN, %edx
        int $LINUX_SYSCALL

    exit:
        movl $SYS_CLOSE, %eax
        movl FD_OUT, %ebx
        int $LINUX_SYSCALL
    
        movl $1, %eax
        movl $0, %ebx
        int $LINUX_SYSCALL
