# Chapter5: Dealing with Files

## Describe the life cycle of a file descriptor?
            open -> process -> close
            
## What are the standard file descriptor and what are they used for?
- standard file descriptor: file descriptor of special files use to handle I/O resources
 
## What is a buffer?
- buffer: 
    - an allocation in memory that holds data before it gets processed 
    - continous block of bytes  used for bulk data transfer
    - the place operating system needs to store the data when read a file
    - store data temporarily

## What is the difference between the .data section and the .bss section?
- .bss: only reserve space
    - doesn't take up space in executable
    - can't set an initial value
    
- .data: take space and set it to 0
    - take up space in executable 
    - need to be initial in the executable

## What are the system calls related to reading and writing files?
    - SYS_OPEN, 5
    - SYS_WRITE, 4
    - SYS_READ, 3
    - SYS_CLOSE, 6

