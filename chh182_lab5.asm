.include "led_keypad.asm"

.data
dot_x: .word 32
dot_y: .word 32


.text 
.globl main
main:

main_loop:
        li	a0, 16
	li	v0, 32
	syscall
	
	jal     check_for_input
	jal	draw_dot
	jal     display_update_and_clear
	
	
	j	main_loop
	jr	ra
	
	
draw_dot:
        push	ra

        lw	a0, dot_x
        lw	a1, dot_y
        li	a2, COLOR_BLUE
	jal     display_set_pixel
	pop	ra
	jr	ra
	
	
check_for_input:
        push	ra
        jal	input_get_keys
        pop	ra
         
        and     t0, v0, KEY_L
        bne     t0, 0, dot_x_minus
        
        push	ra
        jal	input_get_keys
        pop	ra
        
        and     t0, v0, KEY_R
        bne     t0, 0, dot_x_plus
        
        push	ra
        jal	input_get_keys
        pop	ra
          
        and     t0, v0, KEY_U
        bne     t0, 0, dot_y_minus
        
        push	ra
        jal	input_get_keys
        pop	ra
        
        and     t0, v0, KEY_D
        bne     t0, 0, dot_y_plus
        


       
        jr	ra
        
        
        
dot_x_minus:
     
        lw	a0, dot_x
        sub    a0, a0, 1
        and     a0, a0, 0x003F
        sw      a0, dot_x
	jr	ra
	
dot_x_plus:

        lw	a0, dot_x
        add    a0, a0, 1
        and     a0, a0, 0x003F
        sw      a0, dot_x
	jr	ra
	
	
dot_y_plus:

        lw	a0, dot_y
        add    a0, a0, 1
        and     a0, a0, 0x003F
        sw      a0, dot_y
	jr	ra
	
dot_y_minus:
        lw	a0, dot_y
        sub    a0, a0, 1
        and     a0, a0, 0x003F
        sw      a0, dot_y

	jr	ra
