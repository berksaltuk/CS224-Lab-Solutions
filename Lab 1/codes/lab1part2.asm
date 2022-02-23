##
## A program which evaluates  x= a * (b - c) % d.
## Inputs a, b, c and d from the user.
##

#########################################
#					#
#  Created by Berk Saltuk Y�lmaz (bsy)	#
#					#
#########################################


#################################
#					 	#
#     	 text segment		#
#						#
#################################

.text		
	.globl __start	
	
__start:

	la $a0, welcome # prompting welcome message
	li $v0, 4
	syscall
	
	la $a0, entera # input a msg
	li $v0, 4
	syscall

        li $v0, 5 # save a
        syscall
        sw $v0, a
        
        
        la $a0, endl 
	li $v0, 4
	syscall
	
        la $a0, enterb # input b msg
	li $v0, 4
	syscall
	
        li $v0, 5 # save b
        syscall
        sw $v0, b
        
        la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, enterc # input c msg
	li $v0, 4
	syscall
	
        li $v0, 5 # save c
        syscall
        sw $v0, c
        
        la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, enterd # input d msg
	li $v0, 4
	syscall
	
        li $v0, 5 # save d
        syscall
        sw $v0, d
        
        la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, hmm # calculating msg
	li $v0, 4
	syscall

	lw $a0, a # passing 4 arguments to calculator method
	lw $a1, b
	lw $a2, c
	lw $a3, d
	jal calculator # jump and link calculator
	
	la $a0, result # prompting result msg
	li $v0, 4
	syscall
	
	lw $a0, x
	li $v0 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, bye # bye message
	li $v0, 4
	syscall
	
	li $v0,10		# system call to exit
        syscall		#    bye bye
        
calculator:
        
        sub $t0, $a1, $a2 # temp = b - c
        
        mult $a0, $t0 # a * ( b - c )
        mflo $t1 # moving the lo register's content to $t1, ignoring the overflow
        
        bge $t1, $zero, positive # if result of the part before modulo >= 0, branch to positive part

	negative: 
		
		loop: # t1 = t1 + d until the result is greater than 0
			add, $t1, $t1, $a3
			ble $t1, $zero, loop
		
		div $t1, $a3 
        	mfhi $t4 # getting the remainder from hi register
        	
        	move $v0, $t4 # moving t4 to v0
        	sw $v0, x # saving the x value
		jr $ra # returning the main
		
	positive:
        	div $t1, $a3
        	mfhi $t4 # getting the remainder from hi register
        	
        	move $v0, $t4 # moving t4 to v0
        	sw $v0, x # saving the x value
        	jr $ra # returning the main
        	
#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
welcome: .asciiz "Welcome to bsy's basic calculator!\n This program calculates x = a * (b - c) % d \n"
entera: .asciiz "What is the value of a?: "
enterb: .asciiz "What is the value of b?: "
enterc: .asciiz "What is the value of c?: "
enterd: .asciiz "What is the value of d?: "
hmm: .asciiz "Hmm... Let me evaluate this hard-looking problem!\n"
result: .asciiz "The result... wait for it ...is: "
bye: .asciiz "Thanks for using this simple mips program, see you!\n"
endl: .asciiz "\n"
a: .word 0
b: .word 0
c: .word 0
d: .word 0
x: .word 0

##
## end of file lab1part2.asm