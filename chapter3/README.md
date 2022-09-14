# Chapter3: Your firsrt programs

- Assembling is the process that transforms assembly code into intructions for
  the machine. It transforms the human-readable file into a machine-readable file 
- Object file is code that is in the machine's language, but has not been completely put together
- Linker is a program responsile for putting the object files together and
  adding information to it so that the kernel knows how to load and run it
 
# Outline of an Assembly Language Program
- anything starting with a period isn't directly translated into a machine
  instruction. Instead, it's an instruction to the assembler it self
- `.section .data`: where to list memory storage you need 
- `.section .text`: where the program instructions live
- symbol are generally used to makr locations of programs or data, so you can
  refer them by name instead of by their location number
- symbol is going going to be replaced by something else either during assembly or liking
- _start mark location where to begin running program
- label: symbol followed by a colon, define a symbol's value
- some general-purpose registers
    - %eax
    - %ebx
    - %ecx
    - %edx
    - %esi

- some special-purpose registers:
    - %ebp: base pointer
    - %esp: stack pointer
    - %eip 
    - %eflags 
     
     ```
     movl $1, %eax
     ```
- `$` in front of the one indicates that we want to use immediate mode addressing. move number 1 into %eax
     ```
     movl 1, %eax
     ```
- without `$` it would do direct addressing, load data from address 1 to %eax 
