##
## A program which checks whether an array is symmetric.
## Inputs the size and elements from the user.
##

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
       
       la $a0, enterSize # asking for the size of the array
       li $v0, 4 # syscall 4 prints the string
       syscall
       
       li $v0, 5
       syscall
       sw $v0, arrsize # keeping the size of the array
       
       jal readArray # reading the array elements
       
       jal printArray # printing the array for error checking purposes
       
       la $a0, 0($t0)
       jal isSymmetric
	
       la $a0, bye	# output prompt message on terminal
       li $v0, 4	# syscall 4 prints the string
       syscall
       
       
       li $v0,10		# system call to exit
       syscall		#    bye bye
       
readArray:
	la $t0, array
	lw $t1, arrsize
	
	la $a0, enterElement # asking for the elements of the array
        li $v0, 4 # syscall 4 prints the string
        syscall
	
	read:
		li $v0, 5
        	syscall
		
		sw $v0, 0($t0)
		addi $t0, $t0, 4 # incrementing the addres
		subi $t1, $t1, 1 # decrementing the counter
		bgt $t1, $zero, read
	jr $ra

printArray: 
	la $t0, array
	lw $t1, arrsize
	
	la $a0, contents # intro message for printing elements
        li $v0, 4 # syscall 4 prints the string
        syscall
        
        print: 
        	lw $a0, 0($t0)
        	li $v0, 1
        	syscall
        	
        	la $a0, space	# output prompt message on terminal
       		li $v0, 4	# syscall 4 prints the string
      		syscall
      		
        	addi $t0, $t0, 4 # incrementing the addres
		subi $t1, $t1, 1 # decrementing the counter
		bgt $t1, $zero, print
        
        la $a0, endl	# output prompt message on terminal
        li $v0, 4	# syscall 4 prints the string
        syscall	
        jr $ra

isSymmetric: 
	 
	la $t0, array # first element's address
	subi $t1, $a0, 4 # last element's address
	lookForSymmetry:
		
		lw $t2, 0($t0) # assigning first and last elements
		lw $t3, 0($t1) 
		sw $t2, 0($t0) 
		sw $t3, 0($t1) 
		
		bne $t2, $t3, notSymmetric # if the symmetric elements i.t.o. indexes n.e. branch not sym.  
		sub $t2, $t1, $t0 # distance between addresses
		addi $t0, $t0, 4 # incrementing address
		subi $t1, $t1, 4 # decrementing address
		
		bge $t2, 4, lookForSymmetry # if the distance is more than one element, continue with loop
		
		j symmetric # if it is not branched to notSymmetric part, then jump to the symmetric part
	
	notSymmetric:
		la $a0, ans2	# output prompt message on terminal
        	li $v0, 4	# syscall 4 prints the string
        	syscall	
        	jr $ra
        symmetric:
		la $a0, ans1	# output prompt message on terminal
        	li $v0, 4	# syscall 4 prints the string
        	syscall	
        	jr $ra
#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
array: .space 40 #4 for each so max 10 elements
arrsize: .word 0
prompt:	.asciiz "Now watch and see, I will check if your array is symmetric. \n"
enterSize: .asciiz "Can you enter the size of your array? (Max 10 would be good :D) \n"
enterElement: .asciiz "Can you enter the elements of your array? \n"
contents: .asciiz "Contents of your array: \n"
msgsym: .asciiz "Let's see if this array is symmetric... \n"
ans1:	.asciiz "The array is symmetric. \n"
ans2:   .asciiz "The array is not symmetric. \n"
bye:    .asciiz "Thanks for using this program! \n"
space: .asciiz " "
endl:	.asciiz "\n"

##
## end of file lab1part1.asm
