.section .text
.globl power

# stack
.equ ST_RESULT, -4
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

