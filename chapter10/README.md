# Chapter 10

<details>
<summary>Notes</summary>

# Notes

# Counting
## Couting like Human
- we have 10 fingers, we count and do match using base ten numbering system
- base ten: group everything  in tens

## Counting like a computer
- computer only has "two finger" 
- computer use base two,count in binary

## Conversions between binary and decimal
- binary -> decimal
```
1   0   0   1   0   1   0   1
= 1*128 + 0 * 64 + 0 * 32 + 1 * 16 + 0*8 +1*4 + 0*2 + 1*1 = 149

1100101
= 1*2^6 + 1*2^5 + 0*2^4 + 0*2^3 + 1*2^2 + 0*2^1 + 1*2^0
```

- decimal -> binary
```
17
    17/2 = 8 remaning 1 
    8/2  = 4 remaning 0 
    4/2  = 2 remaning 0 
    2/2  = 1 remaning 0 
    1/2  = 0 remaning 1 
    => 10001
   
261
    261/2 = 130 R=1
    130/2 = 65  R=0
    65/2  = 32  R=1
    32/2  = 16  R=0
    16/2  = 8   R=0
    8/2   = 4   R=0
    4/2   = 2   R=0
    2/2   = 1   R=0
    1/2   = 0   R=1
    => 100000101
    = 1*2^8 + 1*2^2 + 1*2^0 = 261
```
-  each digit in a binary number is called a `bit`, stands for binary digit
- computer diveup their memory into storage locaitons called bytes
- each storage location on an x86 processor (and most others) is 8 bits long.
- a byte can hold any number between 0 and 255 because the largest number can fit into 8 bits is 255:
```
11111111
= 2^7 + 2^6 + 2^5 ... + 2^0 = 255

00000000
= 0
```

- The way to convert faster: (The easy way to convert decimal numbers to binary)[https://www.youtube.com/watch?v=XdZqk8BXPwg]

## Truth, falsehood, and binary numbers
- AND: 
    - take 2 bits and return 1 bit.
    - return a 1 only if both bits are 1, and 0 otherwise
    - 1 AND 1 = 1, 1 AND 0 = 0, 0 AND 0 = 0
 
 ```
    10100010    AND
    10001000
    --------
    10000000
 ```
 
- OR: 
    - take 2 bits and return 1 bit. 
    - return 1 if either of the orignal bits is 1
    - 1 OR 1 = 1, 1 OR 0 = 1, 0 OR 0 = 0
     ```
     10100010    OR
     10001000
     --------
     10101010
     ```
     
- NOT 
    - takes one bit and return it's opposite
     ```
     10100010    NOT
     --------
     01011101
     ```
     
- XOR: 
    - like OR, except it reuturns 0 if both bits are 1
    - XOR a number with itself, result is 0 
    - 1 XOR 1 = 0, 1 XOR 0 = 1, 0 XOR 0 = 0
     ```
     10100010    XOR
     10001000
     --------
     00101010
        
        
     10100010    XOR
     10100010    
     --------
     00000000
     ```

- These operations are useful for two reasons:
    - the computer can do them extremely fast  
    - you can use them to compare many truth values at the same time
- AND, OR, NOT, XOR are called boolean operators
- two binary aren't boolean operators: shift, rotate
- shifts and roates each do what their name implies, and can do so to the right or the left
- left shift moves each digit of a binary number one space to the left, puts a
  zero in the ones spot and chops off the furthest digit to the left
- A left roate does the same thing, but takes the furthest digit to the left and puts it in the ones spot
 
```
<----
shift left          10010111 = 00101110

<----
rotate left         10010111 = 00101111
---->

```
- masking is the process eliminating everything you don't want
- when a number represent a set of options for a function or system call, the
  individual true/false elements are called flags
- use OR to combine flags together
- many functions and system calls use flags for options, as it allows a single
  word to hold up to 32 possible options if each option represented by a single
  bit

## The program status register
- program status regsiter: 
    - contain information about the state or the processor
    - holds a lot of information about what happens in a computation
    - has a flag called the carry flag
     
- when do compare(cmpl) instruction, the result is stored in this register
- the conditional jump instruction use these result to tell whether or not they should jump

## other numbering systems
### Floating-point numbers
- the way computer handles decimals is by storing them at a fixed precision(number of significant bits). 
- A computer stores decimal numbers in tow parts 
    - exponent: what magnitude the number is 
    - mantissa: contains the actual digits that will be used  
 
    12345.2 is stored as 1.23452 * 10^4
    the mantissa is 1.23451 and the exponent is 4

### Negative numbers
- `two's complement representation`:
    1. Perform a NOT operation on the number 
    2. Add one to the resulting number
    
```
negative of 00000001:

00000001 NOT
11111110 ADD 1
=> 11111111 

```
- when increase size of signed quantity of two's complement representation, you have to perform `sign extension`
- `sign extension`: 
    - pad the left-hand side of the quantity with whatever digit is in the sign digit 
    - extend a negative number by 4 digits, we should fill the new digits with 1
     
### Octal and hexadecimal numbers
#### Octal
- octal is a representation  that only uses the numbers 0 through 7
- octal number 10 is 8(1 group of 8), octal 121 is 81 (1*8^2 + 2 * 8 + 1)
- Permissions in LINUX are done using octal. This because Linux permissions are
  based on the ability to read, write and execute
- The first bit is read, second is write, third is execute permission
- 0(000) gives no permission, 6(110) gives read and write permission, 5(101) gives read and exeecute permissions
- each digit represent 3 bits (8)

#### Hexadecimal 
- use the numbers 1-15 for each digit. However, since 1--15 don't have their
  own numbers, hex use the letters a through f to represent them.
- each digit represent 4 bits (16)
- f means what all bits are set

### Converting numbers for display
- add '0' to number to convert this number to ascii code: '0' + 9 = '9'


</details>

<details>
<summary>Review</summary>

# Review
## Know the concepts
### 1. Convert decimal number 5294 to binary

    5294 / 2 = 2647 R=0
    2647 / 2 = 1323 R=1
    1323 / 2 = 661  R=1
    661  / 2 = 330  R=1
    330  / 2 = 165  R=0
    165  / 2 = 82   R=1
    82   / 2 = 41   R=0
    41   / 2 = 20   R=1
    20   / 2 = 10   R=0
    10   / 2 = 5    R=0
    5    / 2 = 2    R=1
    2    / 2 = 1    R=0
    1    / 2 = 0    R=1

    => 0001 0100 1010 1110

### 2. What number does 0x0234aeff represent? Specify in binary, octal, and decimal.
- this number is hexadecimal numbers(base 16)
``` 
    0x 0234aeff

    decimal: base 10
        = 0*16^7 ++ 2*16^6 + 3*16^5 + 4*16^4 + a*16^3 + e*16^2 + f*16^1 + f*16^0 
        = 0*16^7 + 2*16^6 + 3*16^5 + 4*16^4 + 10*16^3 + 14*16^2 + 15*16^1 + 15*16^0 
        = 37007103 
        
    binary: base 2
        =    0    2    3    4    a      e    f     f  
        =    0    2    3    4    10    14    15    15 
        = 0000 0010 0011 0100  1010  1110  1111  1111 
        
    octal: base 8
        = 0000 0010 0011 0100  1010  1110  1111  1111 
        = 00000010001101001010111011111111 
        = 00 000 010 001 101 001 010 111 011 111 111 
        =  0   0   2   1   5   1   2   7   3   7   7
``` 

### 3. Add the binary numbers 10111001 and 101011
```
      10111001
    + 00101011
      --------
      11100100
```

### 4. Multiply the binary numbers 1100 1010110
```
    1010110
    x  1100
    -------
    0000000
   0000000
  1010110
 1010110
------------ 
10000001000
```

### 5. convert the result of the previous two problems into decimal
```
    11100100
    = 2^7 + 2^6 + 2^5 + 2^2 
    = 228

    10000000100
    = 2^10 + 2^3
    = 1032
```
### 6. Descride how AND, OR, NOT and XOR work.
- AND returns true only if both inputs are true:
```
    & 0 1
    ------
    0 0 0
    1 0 1
```
- OR returns true if either or both inputs are true:
```
    | 0 1
    -----
    0 0 0
    1 0 1
```
- NOT returns true if the input is false or false if the input is
  true:
```
    ~ 0 1
    -----
      1 0
```
- XOR returns true if either one input or the other is true, but not
  both:
```
    ^ 0 1
    -----
    0 0 1
    1 1 0
```

### 7. What is masking for?
- masking is for eliminating everything we don't want
- it is accomplished by doing an and with a number that has the bits we are interested set to 1.
- e.g: to determine if the second bit is set in the number 1010:
```
    1010 >> 1 = 0101
 
    0101
  & 0001
    ----
    0001
```

the result here can be compared to 1 to determine if the second bit was set to
1 or 0  

### 8. What number would you use for the flags for the open system call if you wanted to open file for writing, and create the file if it doesn't exist?
- the flags to use are O_WRONLY | O_CREAT
```
    0000 0001
  | 0100 0000
  ------------
    0100 0001
  = 65 = 0101 = 0x41
```

### 9. How would you represent -55 in a thirty-two bit register?
```
    55: 
    convert with the faster way:
    1  3 6 13 27 55
    1  1 0  1  1  1
    
    in thirty-two bit:
    55 = 0000 0000 0000 0000 0000 0000 0011 0111
    
    -55:
    ~ 0000 0000 0000 0000 0000 0000 0011 0111
    ------------------------------------------
      1111 1111 1111 1111 1111 1111 1100 1000 
    + 0000 0000 0000 0000 0000 0000 0000 0001 
    ------------------------------------------
      1111 1111 1111 1111 1111 1111 1100 1001
```

### 10. Sign-extend the previous quantity into a 64-bit register 
	1111 1111 1111 1111 1111 1111 1111 1111 1111 1111 1111 1111 1111 1111 1100 1001
    
### 11. Describe the difference between little-endian and big-endian storage of words in memory
    - Big-endian is the intuitive approach: it stores words in memory with
	  the most significant byte  on the left and the least significant
	  byte on the right, just like we are used to seeing. For example, the
	  4-byte word 0x0234aeff (assuming 8-bit bytes) would be stored as
	  follows (remember 2 hex numbers make an 8-bit byte):
		address/index:	 0  1  2  3
		value:		     02 34 ae ff
	- Little-endian is very unintuitive, but it is more convenient from a
	  hardware perspective, and it has different performance
	  characteristics. It simple reverses the order of the bytes, so that
	  the 4-byte word above would be stored in memory as:
		address/index:	 0  1  2  3
		value:		     ff ae 34 02
	  Note that it's note the individual _bits_ that are stored in reverse
	  order, it's the _bytes_!
     
## Use the concepts
### 1. Modify the integer2string code to return results in octal:
   you only need to change base number to 8: integer-to-string-octal.s
### 2. Modify the integer2string code so that the conversion base is a parameter rather than hardcoded: 
    integer-to-string-parameter.s
## Going further
### 1. Modify the integer2string code so that the conversion base can be greater than 10(this requires you to use letters for numbers past 9) 
integer-to-string-plus.s

### 2. Create function that does the reverse of integer2string called number2integer...
number2integer.s
number2integer-test.s

### 3. Write program that stores likes and dislike into a single machine word, and then compares two sets of likes and displikes for commonalitites. 

### 4. Write a program that reads a string of characters from STDIN and converts them to a number
std-number.s

</details>
