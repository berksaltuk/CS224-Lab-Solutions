##
## Reverse Bits Program	
## Reverses the bits of given decimal number and outputs the reversed version.
## Inputs the decimal number.

#########################################
#					#
#  Created by Berk Saltuk Yýlmaz (bsy)	#
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
	la $a0, prompt	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	la $a0, input	
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	li $v0, 5
        syscall
       	sw $v0, number
       	
       	la $a0, num	
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	lw $a0, number	
       	li $v0, 1	# syscall 4 prints the string
       	syscall
       	
       	la $a0, endl     
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	la $a0, numHex	
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	lw $a0, number	
       	li $v0, 34	# syscall 4 prints the string
       	syscall
       	
       	la $a0, endl     
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	lw $a0, number
       	jal ReverseBits # calling sub program
       	
       	move $s5, $v0
       	
       	la $a0, numReverse	
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	move $a0, $s5
       	li $v0, 34	# syscall 4 prints the string
       	syscall
       	
       	la $a0, endl   
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	la $a0, bye     
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
	li $v0,10		# system call to exit
        syscall		#    bye bye

ReverseBits: 
	  move $s0, $a0 # moving the original number
	  
	  addi $sp, $sp, -4
	  sw $s0, 0($sp) # save $s0 on stack
	  
	  li $s1, 0 # setting reversed version 0
	  li $s3, 32 # counter that set to max shift amount
	  loop:
	  	beq $s3, $zero, done # if counter 0 done
	  	sll $s1, $s1, 1 # creating room for new bit and by shifting left, in the end $s1 have lsb of number as msb
	  	andi $s2, $s0, 1 # and with 1 to obtain lsb
	  	add $s1, $s1, $s2 # adding bit to the room I created for new bit
	  	srl $s0, $s0, 1 # shifting right original number
	  	subi $s3, $s3, 1 # decrement counter
	  	j loop
	  done:
	  	move $v0, $s1 # storing $s1 to return 
	  	lw $s0, 0($sp) # restore $s0 from stack
 	  	addi $sp, $sp, 4 # deallocate stack space 
 	  	jr $ra 
#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
prompt: .asciiz "Welcome! This program will reverse the bits of your number!\n"
num: .asciiz "This is the number you gave, don't forget it: "
numHex: .asciiz "...and this is the Hexadecimal form of your number: "
numReverse: .asciiz "This is the reversed version of your number in Hexadecimal form: "
input: .asciiz "Can you please give an integer in decimal form?\n"
bye:    .asciiz "Thanks for using this program! \n"
space: .asciiz "         "
endl:	.asciiz "\n"
number: .word 0

##
## end of file lab2part2.asm
