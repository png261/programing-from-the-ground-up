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
     
     
- `$` in front of the one indicates that we want to use immediate mode addressing. move number 1 into %eax
     ```
     movl $1, %eax
     ```
- without `$` it would do direct addressing, load data from address 1 to %eax 
     ```
     movl 1, %eax
     ```
## Addressing Modes
```
ADDRESS_OR_OFFSET(%BASE_OR_OFFSET,%INDEX,MULTIPLIER)

FINAL ADDRESS = ADDRESS_OR_OFFSET + %BASE_OR_OFFSET + MULTIPLIER * %INDEX
```
ADDRESS_OR_OFFSET and MULTIPLIER must both be constants, while the other two must be
registers. If any of the pieces is left out, it is just substituted with zero in the equation.

# Review
## Know the Concepts
### 1. What does if mean if a line in the program starts with the "#" character
- it's a comment line. Comments are not translated by the assembler, they will be remove
### 2. What is the difference between an aseembly language file and an object code file?
- assembly lanaguge file is human-readable
- object code file is machine-readable
### 3. What does the linker do?
- Linker responsile for putting the object files together and
  adding information to it so that the kernel knows how to load and run it
### 4. How to you check the result status code of the last program you ran?
```
echo $?
```

### 5. What is the difference between movl $1, %eax and movl 1, %eax
- the first is  immediate addressing mode: move 1 into %eax
- the second is  direct addressing mode: load data from address 1 into %eax

### 6. Which register holds the system call number?
- %eax

### 7. What are indexes used for?
- indexes use for access item in a array
 
### 8. Why do indexes usually start at 0?
- because this is the start of array

### 9. If I issued the command `movl data_items(,%edi,4), %eax` and data_items was address 3634 and %edi held the value 13, what address would you be using to move into %eax
- address: 3634 + 13*4 = 3686

### 10. List the general-purpose registers.
- %eax
- %ebx
- %ecx
- %edx
- %esi

### 11. What is the difference between movl and movb?
- movl: copies a word of data (size of register?) one location to another
- movb: copies bytes one location to another

### 12. What is flow control?
- flow control is what tell computer which steps to follow and which patch to take

### 13. What does a conditional jump do?
- conditional jump is a flow control instruction
 
### 14. What things do you have to plan for when writting a program?
 
### 15. Go through every instruction and list what addressing mode is being used for each operand 
 
## Use the concepts
### What would the instruction movl _start, %eax do? Be specific, based on your knowledge of both addressing modes and the meaning or _start. How would this differ from the instruction movl $_start, %eax

the `_start` is a lable which will be substituted with the address of data
```
movl _start, %eax
```
it move data of this address to %eax 

```
movl $_start, %eax
```
it move the address number to %eax

## Going further

