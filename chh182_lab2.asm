.data
# put variables here.
small: .byte 200
medium: .half 400
large: .word 0
.eqv NUM_ITEMS 5
values: .word 0:NUM_ITEMS


.text 
.globl main
main:
# part 1 & 2--------------------------------------------------------------
	
lbu t0, small # loads the 1 byte at small as an unsigned 8-bit value into t0
lhu t1, medium # loads the 1 byte at medium as an unsigned 16-bit value into t1
lw t2, large # loads the 1 byte at large as an unsigned 32-bit value into t2
mul t2, t0, t1
move a0, t2
li v0, 1
syscall

# part 3 & 4 ------------------------------------------------------------

li s0, 0 # 0 = i, initalized as 0 in the beginning


ask_loop_top:  
blt s0, NUM_ITEMS, ask_loop_body # if s0 is less than NUM_ITEMS, go to label 'ask_loop_body'
j ask_loop_exit # after comparison and i is larger or equal to NUM_ITEMS we come to this line, and jumps to label 'ask_loop_exit', to exit the loop


ask_loop_body: 
li v0, 5 # asks user for input
syscall
la	a0, values # puts the base address in a0.
move	a1, s0 # puts the index in a1.
mul	a1, a1, 4 # multiply index by size of a word
add	a0, a0, a1 # compute effective address (base + offset)
sw	v0 , (a0) # stores the value of v0 into memory starting at the address stored in a0
add s0, s0, 1 # i++
j ask_loop_top # goes back and check the condition again


ask_loop_exit: # exit loop


