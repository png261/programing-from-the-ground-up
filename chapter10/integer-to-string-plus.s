# function: integer2string(number, buffer_address)
# variable:
#    %ecx: count of characters porcessed
#    %eax: current value
#    %edi: base 

# stack
.equ ST_VALUE, 8
.equ ST_BUFFER, 12

.section .text
.globl integer2string
.type integer2string, @function

integer2string:
    pushl %ebp
    movl %esp, %ebp

    movl $0, %ecx               # char count
    movl ST_VALUE(%ebp), %eax   # current value 
    movl $16, %edi              # base 10

    # while(%eax != 0)
    conversion_loop:
        movl $0, %edx
        divl %edi # divide %eax by 10, save quotient in %eax, remainder in %edx

        cmpl $9, %edx 
        jg use_letters 

        # convert number to ascii code
        addl $'0', %edx
        jmp continue

        use_letters:
        subl $10, %edx # get the index
        addl $'a', %edx 

        continue:
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
