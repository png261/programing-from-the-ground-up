# Chapter 2: Computer Architecture
<details>
<summary>Notes</summary>

# Notes
- Mordern computer architecture based off of Von Neumann architecture.
- Von Neumann architecture divides computer into two main parts:
    - CPU(Central Processing Unit)
    - Memory
    
![von neumann architecture](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/Von_Neumann_Architecture.svg/2560px-Von_Neumann_Architecture.svg.png)

## Structure of Computer Memory
- a numbered sequence of fixed-size storage locations
- the number attached to each storage location is called it's address
- each location has the same, fixed-length size and store only single number

## The CPU
- CPU function: reads in instructions from memory one at a time and executes
  theme. It's is fetch-execute cycle
 
- CPU contains elements to accomplish: 
    - program counter
    - instruction decoder
    - data bus
    - general-purpose registers
    - arithmetic and logic unit
     
### program counter (instruction pointer)
- holds memory address of next instruction that would be executed

### data bus
- set of wires that allows one part of motherboard connect and
  communicate with other parts 
- connect CPU with memory
 
### register
- regsiter: special, high-speed memory locations
- provide the fastest way to access data.
- as a place on your desk: its holds thing you are currently working on
- the size of a typical register is called `computer's word size`.
- on x86 size of register is four bytes
- two kinds:
    - general registers
    - special-purpose register
     
## Address and Pointer
- address is a number has four bytes long, fit into a register
- store address same way with any other number
- address stored in memory are also called `pointer` because they point to a
  different location in memory

### Instruction
- computer instruction also stored in memory same way that other data is stored.
- an memory location pointed by an special-purpose register `instruction
  pointer` is an instruction
 
## Interpreting Memory 
- computers can only store numbers, so letters, pictures, music and anything
  else are just a long sequences of numbers in the computer which pariticular
  porgrams know how to interpret 
 
## Data Acessing Methods
- Addressing modes: diffrent ways of accessing data
    - immediate mode: register = data
    - register addressing mode: register = register
    - direct addressing mode: register = address
    - indexed addressing mode: register =  address + index regsiter to
      offset that address
    - base poiter addressing mode: similar to indierct addressing, but also
      include a number called offset to add the register's value before using
      it for look up
</details>

<details>
<summary>Review</summary>

# Review

## Know the concepts

### 1.Describe the fetch-execute cycle
- 4 steps:
    - Fetch: take the address of instruction from "program counter"
    - Decode: figure out what instruction mean: 
        - what process needs to take place?
        - what memory locations are going to involved
    - Execute: 
        - use data bus fetch the memory locations to be used
        - store data to register
        - execute in arithmetic and logic unit
    - Store: place result on data bus and send them to location/register, as
      specified by the instruction
     
### 2. What is a register? How would computation be more difficult without registers? 
- register is special, highspeed memory locations hold data currently being worked
- computation would be harder without registers because computer not have a space to
  save a temporary data, it always need to access the memory and save data. Memory
  is slower than register so computation become slower and harder
     
### 3. How do you represent numbers larger than 255?
- combination bytes 
 
### 4. How big are the registers on the machines we will be using? 
- 4 bytes

### 5. How does a computer know how to interpret a given byte or set of bytes of memory? 
- the computer knows what to do with the different memory though the registers
 
### 6.What are the addressing modes and what are they used for? 
- addressing modes: different ways of accessing data
- usage:
    - Immediate mode: 
    - Register Addressing mode: 
    - Direct Addressing mode: 
    - Indexed Addressing mode:
    - Base pointer addressing mode:

### 7. What does the instruction pointer do?
- show computer a location is an instruction by point to this location.
- hold the next instruction
 
## Use the Concepts

### 1. What data would you use in an employee record? How would you lay it out in memory?
- An employee record contain: first name, last name, title, id.
- Start of record:
    Employee's firstname pointer(1 word)- start of record
    Employee's lastname pointer(1 word) - start of record + 4
    Employee's title pointer(1 word) - start of record + 8
    Employee's id pointer(1 word) - start of record + 12
    
### 2. If had the pointer the the beginning of the employee record above, and wanted to acess a particular piece of data inside of it, what addressing mode would I use? 
- Indexed addressing mode.

### 3. In base pointer addressing mode, if you have a register holding the value 3122, and an offset of 20, what address you would be trying to acess?
- address: 3122 + 20 = 3142
 
### 4. In indexed addressing mode, if the base address is 6512, the index register has a 5, and the multiplier is 4, what address would you be trying to acess?
- address: 6512 + 5 * 4 = 6532
 
### 5. In indexed addressing mode, if the base address is 123472, the index register has a 0, and the multiplier is 4, what address would you be trying to acess? 
- address: 123472 + 0*4 = 123472

### 6. In indexed addressing mode, if the base address is 9123478, the index register has a 20, and the multiplier is 1, what address would you be trying to acess? 
- address: 9123478 + 20*1 = 9123498

## Going further
### 1. What are the minimum number of addressing modes needed for computation?
- only need direct addressing mode use for get data and save data
 
### 2.Why include addressing mode that aren't strictly needed?


### 3. Research and then describe how pipelining(or one of the other complication factors) affects the fetch-execute cycle
- pipelining: 
    - a technique for implementing instruction-level parallelism within a single processor.
    - attempts to keep every part of the processor busy with some
      instruction by dividing incoming instructions into a series of sequential
      steps performed by different processor units with different parts of instructions processed in parallel 
     
=> it improve performance: Fetch can be occurring while
the execute is taking place, and is then ready to be executed as soon
as the cycle completes.

### 4. Research and then describe the tradeoffs between fixed-length instructions and variable-length instructions.
- Fixed-length: makes instructions fetching predictable, increase performance
  but some instructions may larger than required
- Variabl-length: reduces the memory space required, flexible, but required multi-step
  fetch and decode 

<details>
