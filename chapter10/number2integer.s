# function: number2integer(string)
# variable:
#    %eax: current character
#    %ebx: temp value
#    %ecx: character count
#    %edx: current character address
#    %edi: base number

# stack
.equ ST_STRING, 8

.section .bss
    .lcomm result, 4
.section .text
.globl number2integer
.type number2integer, @function

number2integer:
    pushl %ebp
    movl %esp, %ebp

    pushl ST_STRING(%ebp)
    call count_chars
    addl $4, %esp
    movl %eax, %ecx # string length
    subl $1, %ecx

    movl ST_STRING(%ebp), %edx   # current value 

    loop_begin:
        movb (%edx), %al
        cmpb $0, %al
        je end_loop

        subl $'0', %eax
        movl %eax, %ebx
        pushl %ebx

        pushl %ecx
        pushl $10
        call power
        addl $4, %esp
        popl %ecx

        popl %ebx
        imull %eax, %ebx 
        addl %ebx, result
        
        decl %ecx
        incl %edx

        jmp loop_begin
    
    end_loop:
        movl result, %eax

        movl %ebp, %esp
        popl %ebp
        ret
