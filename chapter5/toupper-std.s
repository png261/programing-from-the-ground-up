# Run(x86-64):
#   as --32 toupper.s -o toupper.o
#   ld -melf_i386 toupper.o -o toupper
#   echo "hello there" | ./toupper 
#   HELLO THERE
# or do something more cool:
#    journalctl | ./toupper 


# PURPOSE: uppercase content of STDIN and store it in STDOUT

.section .data

### CONSTANTS ###

# system call numbers: request a functions from OS: Linux kernel
.equ SYS_OPEN,  5
.equ SYS_WRITE, 4
.equ SYS_READ,  3
.equ SYS_CLOSE, 6
.equ SYS_EXIT,  1

# standard file descriptors
.equ STDIN,  0
.equ STDOUT, 1
.equ STDERR, 2

# system call interrupt
.equ LINUX_SYSCALL, 0x80
.equ END_OF_FILE, 0

.equ BUFFER_SIZE, 100 
# create symbol BUFFER_DATA: address of BUFFER_SIZE bytes storage location 
.lcomm BUFFER_DATA, BUFFER_SIZE 

.section .text
.globl _start
_start:

### MAIN LOOP ###
read_loop_begin: 
    movl $SYS_READ, %eax        # read(%ebx: file descriptor, %ecx: buffer_address, %edx: buffer_size) 

    movl $STDIN, %ebx   # file descriptor
    movl $BUFFER_DATA, %ecx     # buffer_address
    movl $BUFFER_SIZE, %edx     # buffer_size 

    int $LINUX_SYSCALL
    # => %eax: number bytes read

    # exit if reach the end
    cmpl $END_OF_FILE, %eax
    je end_loop


continue_read_loop: 
    # convert_to_upper(buffer_address, buffer_size)
    pushl $BUFFER_DATA  
    pushl %eax              # buffer_size
    call convert_to_upper

    popl %eax               # get the buffer_size back
    addl $4, %esp           # restore esp

    # write the block out to the output file
    # take buffer_size in %eax to %edx before use %eax to store system call
    movl %eax, %edx             # buffer_size 
    movl $SYS_WRITE, %eax       # write(%ebx: file descriptor, %ecx: buffer_address, %edx: buffer_size) 

    movl $STDOUT, %ebx  # file descriptor
    movl $BUFFER_DATA, %ecx     # buffer_address 

    int $LINUX_SYSCALL
    # => %eax: number of bytes written 

    jmp read_loop_begin


end_loop:
    # exit
    movl $SYS_EXIT, %eax            # exit(%ebx: exit number)
    movl $0, %ebx                   # exit number
    int $LINUX_SYSCALL


#   
# FUNCTION: 
#     convert_to_upper(buffer_size, buffer_address)
#       => uppercase buffer
#
# VARIABLES:
#	  %eax - beginning of buffer
#	  %ebx - buffer length
#	  %edi - buffer offset
#	  %cl  - current byte 
#

# CONSTANTS
.equ LOWERCASE_A, 'a'		# lower boundary of our search
.equ LOWERCASE_Z, 'z'		# upper boundary of our search

.equ UPPER_CONVERSION, 'A' - 'a' 
# 'A' - 'a' = 32 => 'a' + 32 = 'A' => lowercase + 32 = uppercase

# STACK STUFF
.equ ST_BUFFER, 12	    	# buffer address
.equ ST_BUFFER_LEN, 8		# buffer length

convert_to_upper:
    pushl %ebp
    movl %esp, %ebp

    # set up variable
    # %eax - beginning of buffer
    # %ebx - buffer length
    # %edi - buffer offset

    movl ST_BUFFER(%ebp), %eax
    movl ST_BUFFER_LEN(%ebp), %ebx
    movl $0, %edi

	# leave if buffer is empty
    cmpl $0, %ebx		
    je end_convert_loop		

    # otherwise continue, run convert_loop

convert_loop:
    movb (%eax, %edi, 1), %cl		
    # base indexed scale displacement:
    #        0       ( %eax,  %edi,    1    )
    #        |          |     |        |
    #  displacement  ( base,  index,  scale )
    # it refer to address: base + index * scale + displacement
    # then move 8 bytes from it to %cl

    # check if 'a' < letter < 'z' because we only handle lowercase alphabet characters 
    check_lowercase_alphabet:
        # ascii: 8 bytes, %cl: 8 bytes

        # if letter less than 'a' next_byte() 
        cmpb $LOWERCASE_A, %cl		   
        jl next_byte			       

        # if letter greater than 'z' next_byte() 
        cmpb $LOWERCASE_Z, %cl		   
        jg next_byte

    addb $UPPER_CONVERSION, %cl	    # otherwise, convert to uppercase: lowercase + 32 = uppercase
    movb %cl, (%eax, %edi, 1)		# store it back into buffer

next_byte:
    incl %edi			    # buffer offset += 1
    cmpl %edi, %ebx			# check if buffer offset = buffer_len: reached end of file
    jne convert_loop


end_convert_loop:
    movl %ebp, %esp			# no return value, just leave
    popl %ebp
    ret
