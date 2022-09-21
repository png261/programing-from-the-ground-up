# function: integer2string(number,base,buffer_address)
# variable:
#    %ecx: count of characters porcessed
#    %eax: current value
#    %edi: base number

# how it work?
#    our number: 261
#    
#    261/10 = 26  R=1
#    26/10  = 2   R=6
#    2/10   = 0   R=2
#    
#    the remain is our number but has been reversed. 
#    we convert these each remain to ascii code by adding to '0'
#    then we pushl it to stack: 
#    
#    "1"
#    "6"
#    "2"
#    
#    then pop it:
#    
#    "2"
#    "6"
#    "1"
#
#   done, we have string "261"

# stack
.equ ST_VALUE, 8
.equ ST_BASE, 12
.equ ST_BUFFER, 16

.section .text
.globl integer2string
.type integer2string, @function

integer2string:
    push %ebp
    movl %esp, %ebp

    movl $0, %ecx               # char count
    movl ST_VALUE(%ebp), %eax   # current value 
    movl ST_BASE(%ebp), %edi   # base number

    # while(%eax != 0)
    conversion_loop:
        movl $0, %edx
        divl %edi # divide %eax by 10, save quotient in %eax, remainder in %edx

        # convert number to ascii code
        addl $'0', %edx

        # push ascii code to stack
        pushl %edx

        # increment char count
        incl %ecx

        # end loop if current value == 0
        cmpl $0, %eax
        jne conversion_loop

    end_conversion_loop:
        movl ST_BUFFER(%ebp), %edx

        copy_reversing_loop:
            popl %eax
            movb %al, (%edx)

            # count down char count
            decl %ecx

            # next byte
            incl %edx

            cmpl $0, %ecx
            jne copy_reversing_loop
     
        end_copy_reversing_loop:
            # add null character at the end of string
            movb $0, (%edx)

            movl %ebp, %esp
            popl %ebp
            ret
