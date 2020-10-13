.macro print_str %str
	.data
	print_str_message: .asciiz %str
	.text
	la	a0, print_str_message
	li	v0, 4
	syscall
.end_macro

.macro print_char %chr
	li	a0, %chr
	li	v0, 11
	syscall
.end_macro

# --------------------------------------------------------------

encode_instruction:
	push	ra
	
	sll a0, a0, 26
	sll a1, a1, 21
	sll a2, a2, 16
	and a3, a3, 0xFFFF # mask with hexdigit 0xFFFF in order to keep bottom lower 16 bits
	or a0, a0, a1
	or a0, a0, a2
	or a0, a0, a3
	
	li      v0, 34
	syscall

	# fill me in!!!

	print_char '\n'

	pop	ra
	jr	ra

# --------------------------------------------------------------

decode_instruction:
	push	ra
	push	s0 # must save a0 in s0
	move	s0, a0
	move    t0, a0

	# fill me in!!!
	
	print_str "\nopcode = "
	move    t0, s0
	srl     t0, t0, 26
	move    a0, t0
	li      v0, 1
	syscall

	print_str "\nrs = "
	move    t0, s0       # load original value into s0
	srl     t0, t0, 21
	and     t0, t0, 0x1F # mask with 11111
	move    a0, t0
	li      v0, 1
	syscall

	print_str "\nrt = "
	move    t0, s0
	srl     t0, t0, 16
	and     t0, t0, 0x1F
	move    a0, t0
	li      v0, 1
	syscall

	print_str "\nimmediate = "
	move    t0, s0
	and     t0, t0, 0xFFFF
	sll     t0, t0, 16
	sra     t0, t0, 16 # shift right *arithmetic*
	move    a0, t0
	li      v0, 1
	syscall

	print_char '\n'

	pop	s0
	pop	ra
	jr	ra

# --------------------------------------------------------------

.globl main
main:
	# addi t0, s1, 123
	li	a0, 8
	li	a1, 17
	li	a2, 8
	li	a3, 0x7B # 123 in hex
	jal	encode_instruction

	# beq t0, zero, -8
	li	a0, 4
	li	a1, 8
	li	a2, 0
	li	a3, -8
	jal	encode_instruction

	li	a0, 0x2228007B
	jal	decode_instruction

	li	a0, 0x1100fff8
	jal	decode_instruction
