##
## Finds the occurrence of the pattern in a given decimal
##  
##

#########################################
#					#
#  Created by Berk Saltuk Yýlmaz (bsy)	#
#					#
#########################################


#################################
#				#
#     	 text segment		#
#				#
#################################

.text		
	.globl __start	
	
__start:
	la $a0, prompt	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	la $a0, input	# output input message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	li $v0, 5
        syscall
       	sw $v0, number
       	
       	la $a0, patternOut	
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	li $v0, 5
        syscall
       	sw $v0, pattern
       	
       	la $a0, length	
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	li $v0, 5
        syscall
       	sw $v0, patLength
       	
       	la $a0, num	
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	lw $a0, number	
       	li $v0, 1	
       	syscall
       	
       	la $a0, endl    
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	la $a0, numHex	
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	lw $a0, number	
       	li $v0, 34	
       	syscall
       	
       	la $a0, endl     
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	la $a0, pat	
       	li $v0, 4	
       	syscall
       	
       	lw $a0, pattern	
       	li $v0, 34	
       	syscall
       	
       	la $a0, endl    
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	lw $a0, number # calling countBitPattern with number, pattern and pattern length
       	lw $a1, pattern 
       	lw $a2, patLength
       	jal countBitPattern
       	
       	move $s5, $v0
       	
       	la $a0, count	
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	move $a0, $s5
       	li $v0, 1	# syscall 4 prints the string
       	syscall
       	
       	la $a0, endl     
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	la $a0, bye     # output goodbye message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
	li $v0,10		# system call to exit
        syscall		#    bye bye


countBitPattern:
	  move $s0, $a0 # saving arguments in $s registers 
	  move $s1, $a1
	  move $s2, $a2
	  
	  addi $sp, $sp, -12
	  sw $s0, 0($sp) # save $s0 on stack
	  sw $s1, 4($sp) # save $s1 on stack
	  sw $s2, 8($sp) # save $s2 on stack
	  
	  li $s7, 1 # loading 1 to $s7
	  sllv $s7, $s7, $s2 # multiplying with 4 and subtracting 1 to get 1's in the number of pattern length
	  subi $s7, $s7, 1
	  
	  li $s4, 0 # setting the counter for occurrence
	  
	  li $s6, 32 
	  div $s6, $s2 # dividing 32 by the pattern length to figure out how many times do I need to shift 
	  mflo $s6 # setting the counter for loop
	  loop:
	  	beq $s6, $zero, done
	  	and $s5, $s0, $s7 # and the number with 1's length of pattern length
	  	beq $s5, $s1, counter # if equal increment the counter
	  	srlv $s0, $s0, $s2 # shifting by the amount of pattern length
	  	subi $s6, $s6, 1 # decrementing the counter
	  	j loop
	  counter:
	  	addi $s4, $s4, 1 # incrementing the pattern count
	  	srlv $s0, $s0, $s2
	  	subi $s6, $s6, 1
	  	j loop
	  done:
	  	move $v0, $s4 # returning pattern counter
	  	lw $s0, 0($sp) # restore $s0 from stack
	  	lw $s1, 4($sp) # restore $s1 from stack
	  	lw $s2, 8($sp) # restore $s2 from stack
 	  	addi $sp, $sp, 12 # deallocate stack space 
 	  	jr $ra  
#################################
#				#
#     	 data segment		#
#				#
#################################

	.data
prompt: .asciiz "This program will count the occurrence of the pattern in a number!\n"
num: .asciiz "This is the number you gave, don't forget it: "
pat: .asciiz "...and this is the pattern in Hexadecimal form: " 
patternOut: .asciiz "Can you give me the pattern?\n"
length: .asciiz "What is the bit length of your pattern?\n"
numHex: .asciiz "...and this is the Hexadecimal form of your number: "
count: .asciiz "The number of occurrence of the pattern: "
input: .asciiz "Can you please give an integer in decimal form?\n"
bye:    .asciiz "Thanks for using this program! \n"
space: .asciiz "         "
endl:	.asciiz "\n"
number: .word 0
pattern: .word 0
patLength: .word 0
##
## end of file lab2part4.asm
