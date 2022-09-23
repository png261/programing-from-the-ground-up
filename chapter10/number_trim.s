# number_trim(string_number_address)
# terminate string where character is not a number character

.section .text
# stack
.equ ST_STRING, 8

.globl number_trim
.type number_trim, @function 

terminate_string:
    movb $0, (%edx) 
    jmp exit

number_trim:
   pushl %ebp 
   movl %esp, %ebp 

   movl ST_STRING(%ebp), %edx

   loop_begin:
        movb (%edx), %al

        cmpb $'0', %al   
        jl terminate_string

        cmpb $'9', %al   
        jg terminate_string

        incl %edx
        jmp loop_begin
   exit:
       movl %ebp, %esp 
       popl %ebp 
       ret
    
