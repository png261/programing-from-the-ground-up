
# Run(x86-64):
#   as --32 toupper.s -o toupper.o
#   ld -melf_i386 toupper.o -o toupper
#   ./toupper toupper.s uppercase.txt


# PURPOSE: uppercase content of input file and store to output file  
#
# PROCESS:
# 1. open input file
# 2. open output file
# 3. while until reach the end of input file:
#   3.a. read part of file into memory
#   3.b. go through each byte of memory: convert_to_upper()
#   3.c. write the memory buffer to output file
# 4. close files and exit


.section .data

### CONSTANTS ###

# system call numbers: request a functions from OS: Linux kernel
.equ SYS_OPEN,  5
.equ SYS_WRITE, 4
.equ SYS_READ,  3
.equ SYS_CLOSE, 6
.equ SYS_EXIT,  1

# read/write flags
.equ O_RDONLY, 0                    
.equ O_CREAT_WRONLY_TRUNC, 03101   

# standard file descriptors
.equ STDIN,  0
.equ STDOUT, 1
.equ STDERR, 2

# system call interrupt
.equ LINUX_SYSCALL, 0x80
.equ END_OF_FILE,   0         # read() return this when hit the end of file


.section .bss 
# BUFFER: save data from file before process: 
#       input -> *buffer* -> process:convert_to_upper() -> save to output file 

.equ BUFFER_SIZE, 500 
# create symbol BUFFER_DATA: address of BUFFER_SIZE bytes storage location 
.lcomm BUFFER_DATA, BUFFER_SIZE 

# save file descriptor in buffer
.lcomm FD_IN, 4 # size can be 100 and it still work
.lcomm FD_OUT, 4 

.section .text
# STACK POSITIONS 
# for example: ./toupper input.txt output.txt
.equ ST_ARGC, 0     # number of arguments (3)
.equ ST_ARGV_0, 4   # name of program (./toupper)
.equ ST_ARGV_1, 8   # input pathname (input.txt) 
.equ ST_ARGV_2, 12  # output pathname (output.txt)


.globl _start
_start:

#  _start(argc, argv1, argv2...), like function main(int argc, char ** argv) in C
# when use ./toupper argv1 argv2: we push args to stack 
# %ebp: base pointer here because it not change when push or pop stack
# argv2:                # ST_ARGV_2 = 12 -> 12(%esp)
# argv1:                # ST_ARGV_1 = 8  -> 8(%esp)
# argv0:                # ST_ARGV_0 = 4  -> 4(%esp)
# argc :                # ST_ARGC   = 0  -> 0(%esp)
# %esp: stack pointer here -> move base pointer to here
# _start here  
# other registers here 

# so we make %ebp(base pointer) = %esp(stack pointer) to access argc, argv
# then we don't needn't care about number of args because base pointer start from it
movl %esp, %ebp

# step to use linux system call:
#    - put system call number in %eax register.
#    - put arguments to system call in registers %eax, %ecx, %edx
#    - call interrupt.
#    - the result is usually returned in %eax register.


# open input and output file and store file descriptor in FD_IN, ST_FD_OUT
open_files: 
    open_fd_in:
        movl $SYS_OPEN, %eax        # open(%ebx: pathname, %ecx: flags, %edx: permission)

        movl ST_ARGV_1(%ebp), %ebx  # pathname
        movl $O_RDONLY, %ecx        # flags
        movl $0666, %edx            # permission

        int $LINUX_SYSCALL
        # => %eax: file descriptor


    store_fd_in:
        # save file descriptor 
        movl %eax, FD_IN


    open_fd_out:
        movl $SYS_OPEN, %eax                # open(%ebx: pathname, %ecx: flags, %edx: permission)

        movl ST_ARGV_2(%ebp), %ebx          # pathname
        movl $O_CREAT_WRONLY_TRUNC, %ecx    # flag
        movl $0666, %edx                    # permission

        int $LINUX_SYSCALL
        # => %eax: file descriptor


    store_fd_out:
        # save file descriptor
        movl %eax, FD_OUT



### MAIN LOOP ###
read_loop_begin: 
    movl $SYS_READ, %eax        # read(%ebx: file descriptor, %ecx: buffer_address, %edx: buffer_size) 

    movl FD_IN, %ebx   # file descriptor
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

    movl FD_OUT, %ebx  # file descriptor
    movl $BUFFER_DATA, %ecx     # buffer_address 

    int $LINUX_SYSCALL
    # => %eax: number of bytes written 

    jmp read_loop_begin



end_loop:
    # close output file
    movl $SYS_CLOSE, %eax           # close(%ebx: file descriptor) 
    movl FD_OUT, %ebx      # file descriptor
    int $LINUX_SYSCALL

    # close input file
    movl $SYS_CLOSE, %eax           # close(%ebx: file descriptor) 
    movl FD_IN, %ebx       # file descriptor
    int $LINUX_SYSCALL

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
   ret
