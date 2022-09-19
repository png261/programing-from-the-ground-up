.include "linux.s"
.include "record-def.s"
.section .data
    no_open_file_msg:
        .ascii "Can't open input file\0"

output_file_name:
.ascii "testout.dat\0"

.section .bss
.lcomm record_buffer, RECORD_SIZE

#Stack offsets of local variables
.equ ST_INPUT_FILENAME, 8
.equ ST_INPUT_DESCRIPTOR, -4
.equ ST_OUTPUT_DESCRIPTOR, -8

.section .text

error_check:
    cmpl $0, %eax
    jl print_error
    ret

print_error:
    pushl $no_open_file_msg
    call error_exit

.globl _start
_start:
#Copy stack pointer and make room for local variables
movl  %esp, %ebp
subl  $8, %esp

#Open file for reading
movl  $SYS_OPEN, %eax
movl  ST_INPUT_FILENAME(%ebp), %ebx
movl  $0, %ecx
movl  $0666, %edx
int $LINUX_SYSCALL
call error_check

continue_processing:
movl  %eax, ST_INPUT_DESCRIPTOR(%ebp)

#Open file for writing
movl  $SYS_OPEN, %eax
movl  $output_file_name, %ebx
movl  $0101, %ecx
movl  $0666, %edx
int   $LINUX_SYSCALL
call error_check

movl  %eax, ST_OUTPUT_DESCRIPTOR(%ebp)

loop_begin:
pushl ST_INPUT_DESCRIPTOR(%ebp)
pushl $record_buffer
call  read_record
addl  $8, %esp

#Returns the number of bytes read.
#If it isn't the same number we
#requested, then it's either an
#end-of-file, or an error, so we're
#quitting
cmpl  $RECORD_SIZE, %eax
jne   loop_end

#Increment the age
incl  record_buffer + RECORD_AGE

#Write the record out
pushl ST_OUTPUT_DESCRIPTOR(%ebp)
pushl $record_buffer
call  write_record
addl  $8, %esp

jmp   loop_begin

loop_end:
movl  $SYS_EXIT, %eax
movl  $0, %ebx
int   $LINUX_SYSCALL

