# Run(x86-64):
#   as --32 power.s -o power.o
#   ld -melf_i386 power.o -o power
#   ./power 


# PURPOSE: calculate 2^3 + 5^2

.section .data
.section .text

.globl _start
_start:
    # power(2, 3)
    pushl $3
    pushl $2
    call power
    addl $8, %esp

    pushl %eax

    # power(5, 2)
    pushl $2
    pushl $5
    call power
    addl $8, %esp

    popl %ebx
    addl %eax, %ebx

    movl $1, %eax
    int $0x80


# PURPOSE: function compute value of a number raised to a power
# power(base, power)
# VARIABLES:
#    %eax temporary number  
#    %ebx - base number
#    %ecx - power number
#    -4(%ebp): current result

.type power, @function
power:
    pushl %ebp
    movl %esp, %ebp
    subl $4, %esp

    movl 8(%ebp), %ebx # first parameter: base
    movl 12(%ebp), %ecx # second parameter: power
    movl %ebx, -4(%ebp)

    # if power == 0 return 1
    cmpl $0, %ecx
    jg power_loop_start

    zero_power:
        movl $1, -4(%ebp)
        jmp end_power

    power_loop_start:
        cmpl $1, %ecx
        je end_power

        movl -4(%ebp), %eax
        imull %ebx, %eax
        movl %eax, -4(%ebp)

        decl %ecx
        jmp power_loop_start

    end_power:
        movl -4(%ebp), %eax

        movl %ebp, %esp
        popl %ebp
        ret
