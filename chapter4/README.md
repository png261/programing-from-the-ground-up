# Chapter4: All about function

## Dealing with complexity
- function: units of code, do a defined piece of work on specified types of data
- parameters: data items function are given to process
- function's interface: parameter list and the processing expactations(what
  is it expected to do with the parameters) of a function 
- primitive functions: do the thing must be provied by system. they are the
  basics which everything else is built off of
- in assembly language, the primitives are usually the same thing as the system
  calls, even though system calls aren't true functions

## How function work
- function name: 
    - symbol represents the address where the function's code starts.  
    - defined by typing the function's name as a lable before function's code
- function parameters:
    - data items are given to the function for processing  
- local variables:
    - data storage that a function uses while processing, thrown away when function finished
- static variables:
    - data storage that a function uses while processing that is not thrown
      away afterwards, reused for every time the function's code is actived
    - not accessible from outside of function 
    - generally not used unless absolutely necessary, as they can cause problems later on
- global variable:
    - data storage that a function uses for processing which are managed outside the function 
- return address:
    - an "invisible" parameter in that it isn't directly used during the function  
    - tells the function where to resume executing after the function is completed
    - function need it to get back to wherever it was called from
    - the `call` instruction passing the return address and `ret` handles using address to return back
- return value:
    - main method of transferring data back to the main program
    - most programming languages only allow a single return value for a function 
     
- language's calling convention: a standardized medthod for function to be implemented and called by machine. The way variables are stored and the
  parameters and return values are transferred by the computer
- calling convention specify how arguemtns are passed to a function, how return
  value are passed back out of a function, how the function is called, and how
  the function manages the stack and it stacks frame. In short the calling
  convention specifies how a function call in C or C++ is converted into
  assembly language
- more about [calling conventions](https://en.wikibooks.org/wiki/X86_Disassembly/Calling_Conventions)
- C calling convention is the standard for Linux platforms
 
## Assembly-language functions using the C calling convention
- `stack`: 
    - region of memory function uses to work properly
    - computer's stack lives at the very top addresses of memory
    - grows downward from the top of memory
    - In C calling convention, the stack is the key element for implementing a
      functon's local variables, parameters, and return address.
 
- `pushl`: push register or memory values onto the top of the stack 
- `popl`: pop values off the top save it into memory location or register
- stack pointer `%esp`: point to the top of stack change when `pushl` or `popl`
 

- before excecuting a function, a program pushes all of the parameters for the
  function onto the stack in the *reverse* order that they are documented and then use `call` instruction
- `call` instruction does two things: 
    - pushes address of the next instruction, which is the return address, onto the stack
    - modifies the instruction pointer(%eip) to point to the start of the function 
    ```
                        <---- (%ebp): base pointer
        Parameter #N
        ...
        Parameter 2
        Parameter 1
        Return Address <--- (%esp)
    ```

- base pointer (%ebp): a special register used for accessing function parameters and local variables, fixed index
 
- setup function:
    - save the base pointer
    - move base pointer to the top of stack

- save the base pointer:
    ```
    pushl %ebp
    ```
    ```
                        <---- (%ebp): base pointer
        Parameter #N
        ...
        Parameter 2
        Parameter 1
        Return Address 
        Old %ebp        <--- (%esp)
    ```

- move base pointer to the top of stack:
    ```
    movl %esp, %ebp
    ```
    ```
        Parameter #N
        ...
        Parameter 2
        Parameter 1
        Return Address 
        Old %ebp        <--- (%esp),(%ebp)
    ```

- we need to use base pointer because it is fixed. stack pointer always change
- for example: 
 
    ```
        pushl %eax
    ```
    ```
        Parameter #N
        ...
        Parameter 2
        Parameter 1
        Return Address 
        Old %ebp <--- (%ebp)
        value of %eax <--- (%esp): stack pointer has been move to the top of stack 
    ```

- when setup is finished, we can access parameter using base pointer addresing mode use %ebp register:
    ```
        Parameter #N <--- N*4+4(%ebp)
        ...
        Parameter 2 <--- 12(%ebp)
        Parameter 1 <--- 8(%ebp)
        Return Address <--- 4(%ebp)
        Old %ebp <--- (%esp) and (%ebp)
    ```

- function reserves space on the stack by simple moving the stack pointer out of the way.
    ```
        subl $8, %esp
    ```
    substract 8 from %esp, now we have two words of memory. This variable is
    allocated on the stack frame so it will only be alive during this function.
    When function return, stack fram will go away, and so will these variable
    That's local variable
- stack now look like:
    ```
        Parameter #N <--- N*4+4(%ebp)
        ...
        Parameter 2 <--- 12(%ebp)
        Parameter 1 <--- 8(%ebp)
        Return Address <--- 4(%ebp)
        Old %ebp <--- (%ebp)
        Local Variable 1 <--- -4(%ebp)
        Local Variable 2 <--- -8(%ebp) and (%esp)
    ```


- when function is done executing, it does there thing:
    - store it's return value in `%eax` 
    - resets the stack to what it was when it was called: return base pointer
      back, and stack frame will be overwrite
    - return control back to wherever it was called from: use `ret`
        - `ret`: pops whatever value is at the top of the stack, and sets the instruction pointer, %eip, to that value
    ```
        movl %ebp, %esp
        popl %ebp
        ret
    ```
# Review
## Know the concepts
### 1. What are primitives?
- basic thing which everything build off of
### 2. What are calling conventions?
- language's calling convention: a standardized medthod for function to be implemented and called by machine. The way variables are stored and the
  parameters and return values are transferred by the computer
- calling convention specify how arguemtns are passed to a function, how return
  value are passed back out of a function, how the function is called, and how
  the function manages the stack and it stacks frame. In short the calling
  convention specifies how a function call in C or C++ is converted into
  assembly language
- more about [calling conventions](https://en.wikibooks.org/wiki/X86_Disassembly/Calling_Conventions)
- C calling convention is the standard for Linux platforms
### 3. What is the stack?
- `stack`: 
    - region of memory function uses to work properly
    - computer's stack lives at the very top addresses of memory
    - grows downward from the top of memory
    - In C calling convention, the stack is the key element for implementing a
      functon's local variables, parameters, and return address.
### 4. How do `pushl` and `popl` affect the stack? What special-purpose register do they affect?
- `pushl`: push register or memory values onto the top of the stack 
- `popl`: pop values off the top save it into memory location or register
- they affect to stack pointer(%esp):
    - `pushl`: increment stack pointer  
    - `popl`: decrement stack pointer  
### 5. What are local variables and what they used for?
- local variable
### 6. Why are local variables so necessary in recursive functions 
- local variables: data storage that a function uses while processing, thrown away when function finished
### 7. What are %ebp and %esp used for?
- %ebp: base pointer use to access data with addressing mode
- %esp: stack pointer use to store data, it always point to next physical memory address
### 8. What is stack frame?
- stack frame: storage consists of all the stack variables used within a funtion: 
    - arguments
    - local variables
    - return address 

## Use the concepts
### 1.Explain the problems that would arise without a standard calling convention?
- it would be nearly impossible for programs created using different compliers
  to communicate and interact with one another

## Going further
### 1.Do you think it's better for a system to have a large set of primitives or a small one, assuming that the larger set can be written in terms of the smaller one?
- I think have a small one is better. A primitive should do only one function 
### 2. Can you build a calling convention without using the stack? What limitations might it have? 

### 3. What test cases should we use in our example program to check to see if it is working properly
