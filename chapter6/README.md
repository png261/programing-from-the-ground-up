# Chapter 6

<details>
<summary>Notes</summary>
 
- Structured data: 
    - data divided up into fixed-lenght records and fixed-format fields so
      computer can interpret data 
    - the fields and recors are fixed-length
 
- `.rept`: 
    - assembler directive repeats the contents of the file between `.rept`
      and `.endr` 
    - usually used to pad values in  the .data section 

# Notes
</details>

<details>
<summary>Review</summary>

# Review
## Know the concepts
### 1.What is a record?
- a collection of fields, possibly of different data types

### 2.What is the advantage of fixed-length records over variable-length records?
- easy to access and manage data

### 3.How do you include constants in multiple assembly source files?
- put constants in a file then use `.include` 

### 4.Why might you want to split up a project into multiple source files?
- easy to maintain and develop

### 5.
- What does the instruction incl record_buffer + RECORD_AGE do? 
    - increment the data of address record_buffer + RECORD_AGE: increment age field  
- What addressing mode is it using? 
    - direct addressing mode 
- How many operands does the incl instructions have in this case? 
    - one operand 
- Which parts are beging handled by the assembler and which parts are being handled when the program is run? 
    - assembler computes `record_buffer + RECORD_AGE` to an address number
    - increment at data at address number is being handled when the program run
     
## Use the concepts
### Create a program to find the largest age
largest-age.s
### Create a program to find the smallest age
smallest-age.s

## Going further

</details>
