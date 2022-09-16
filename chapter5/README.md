# Chapter 5: Dealing with Files

```
After all, when we reboot our computers, the only thing that remains from
previous sessions are the things that have been put on disk
```
- Data stored in file called persistent data


## The Unix file concept
- Unix file, no matter what program created them, can all be accessed as a sequential stream of bytes
- You access a file by opening it by name, opertating system give a number
  called file descriptor, which use to refer to the file until you are through
  with it
- you can read and write using file descriptor. After you close file, file descriptor is useless
 
- system call for dealing with files:
    - 5: open(%ebx: pathname, %ecx: flags, %edx: permission)
        => return file descriptor
    - 3: read(%ebx: file descriptor, %ecx: buffer_address, %edx: buffer_size) 
    - 4: write(%ebx: file descriptor, %ecx: buffer_address, %edx: buffer_size) 
    - 6: close(%ebx: file descriptor) 
 
- more about these function use `man 2`:
    ```
    man 2 open
    ```

## Buffers and .bss
- Buffer: 
    - is a continuous block of bytes used for bulk data transfer
    - place operating system needs to have to store the data it reads when you request to read a file
    - store data temporily
    - fixed size
- `.bss` section: like the data section, except that it doesn't take up space in the executable, can reserve storage, but it can't initialize it
- in `.data` section you could reserve storage and set it to an initial value,
  in the `.bss` section, you can't set an initial value.  
  This usefull for buffers, because we only want to reserve data, we don't want initialize them 
 
- create a buffer: 
```
.section .bss
.lcomm my_buffer, 500
```
- `.lcomm` create symbol `my_buffer` refers to a 500-bytes storage location that we can use as a buffer   
 
# Standard and special files

- STDIN: 
    - standard input
    - read-ony file
    - represents your keyboard
    - file descriptor 0 
    
- STDOUT:
    - standard output. 
    - write-only file
    - represents your screen display

- STDERR:
    - standard error
    - write-only file
    - represent your screen display error
 
 - Unix-based operating systems treat all input/output systems as a files:
    - Network connections 
    - serial port
    - audio devices
    - .....

## Using Files in a program
- `.equ`: assign names to number
- step to use linux system call:
    - put system call number in %eax register.
    - put arguments to system call in registers %eax, %ecx, %edx
    - call interrupt.
    - the result is usually returned in %eax register.
     
- `constants` is a value that is assigned when a program assembles or complie and never change

# Review
## Know the concepts
### 1.Describe the life cycle of a file descriptor?
    open -> file descriptor -> process read/write -> close -> file descriptor now useless
            
### 2.What are the standard file descriptor and what are they used for?
- standard file descriptor: file descriptor of special files use to handle I/O
  resources
 
### 3.What is a buffer?
- is a continuous block of bytes used for bulk data transfer
- place operating system needs to have to store the data it reads when you request to read a file
- store data temporily
- fixed size

### 4.What is the difference between the .data section and the .bss section?
- .bss: only reserve space
    - doesn't take up space in executable
    - can't set an initial value
    
- .data: take space and set it to 0
    - take up space in executable 
    - need to be initial in the executable

### 5.What are the system calls related to reading and writing files?
    - SYS_OPEN, 5
    - SYS_WRITE, 4
    - SYS_READ, 3
    - SYS_CLOSE, 6
    
## Use the concepts
### 1. Modify the toupper program so that it read reads from STDIN and writes to STDOUT instead of using the files on the comand-line
    toupper-std.s
### 2. Rewrite the program so that it uses storage in the .bss section rather than the stack to store the file descriptors 
    toupper-bss.s
### 3. Write a program that will create a file called heynow.txt and write the words "Hey diddle diddle!" into it
    heynow.s
## Going Further
### 1.What difference does the size of the buffer make?
- if size too big, it's waste memeory
- if size too small, take more loops to read and write make program slower
- with small program it may not have too much difference

### 2.What error results can be returned by each of these system calls?
see in man page 2
```
    man 2 read
    man 2 ....
```
### 3.Make the program able to either operate on command-line arguments or use STDIN or STDOUT based on the number of command-line arguments specified by ARGC?
    toupper-argc.s
### 4. Modify the program so that it checks the results of each system call, and prints out an error message to STDOUT when it occurs.
    toupper-error.s
