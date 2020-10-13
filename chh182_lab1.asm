#ChingWei Hsieh, CHH182

.data
hello_message: .asciiz "Hello, world!"

.text

#function that prints integer and enters a new line---------------------
print_int:
li v0, 1
syscall
li a0, '\n'
li v0, 11
syscall
jr ra
#------------------------------------------------------------------------


#function that prints string--------------------------------------------
print_string:
li v0, 4
syscall
li a0, '\n'
li v0, 11
syscall
jr ra
#------------------------------------------------------------------------


#function that prints 123--------------------------------------------------
print_123:
push ra

li a0, 1
jal print_int
li a0, 2
jal print_int
li a0, 3
jal print_int

pop ra
jr ra
#--------------------------------------------------------------------------


.globl main
main: 
jal print_123
li a0, 1234
#li v0, 1
#syscall
#here we put 1 into v0, which is also equivalent to print integer in syscall
jal print_int
li a0, 5678
jal print_int

la a0, hello_message #when stepping through here, a0 loads the value of 10010000, which is the address of hello_message
jal print_string
