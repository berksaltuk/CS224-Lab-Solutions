##
## Process Static Array Program
## Checks if the array is symmetric, finds min and max elements and prints the values in the array. 
## Hardcoded array and size.
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
	
	la $a0, array
	lw $a1, arraySize
	jal PrintArray # passing beginning of array and size as arguments
	
	la $a0, array
	lw $a1, arraySize
	jal CheckSymmetric # passing beginning of array and size as arguments
	
	la $a0, array
	lw $a1, arraySize
	jal FindMinMax # passing beginning of array and size as arguments
	
	move $s0, $v0 # saving the return values of FindMinMax subprogram
	move $s1, $v1
	
	la $a0, maxis	# output max message on terminal
        li $v0, 4	# syscall 4 prints the string
        syscall
        	
        move $a0, $s0
        li $v0 1
        syscall
        	
        la $a0, endl
       	li $v0, 4	
       	syscall
       		
        la $a0, minis	# output min message on terminal
        li $v0, 4	# syscall 4 prints the string
        syscall
        	
        move $a0, $s1
        li $v0 1
        syscall
        	
        la $a0, endl	
       	li $v0, 4	
       	syscall
	
	la $a0, bye	# output goodbye message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
	
	li $v0,10		# system call to exit
        syscall		#    bye bye

PrintArray: # Subprogram number 1
	move $s0, $a0 # saving the arguments in $s registers
	move $s1, $a1
	addi $sp, $sp, -8 # allocating space in stack
	
	sw $s0, 4($sp) # save $s0 on stack
 	sw $s1, 0($sp) # save $s1 on stack
      	
	print:
		lw $a0, 0($s0) # printing the value in the current index
        	li $v0 1
        	syscall
		
		la $a0, space	# output space on terminal
       		li $v0, 4	# syscall 4 prints the string
       		syscall
	
		addi $s0, $s0, 4 # incrementing the addres
		subi $s1, $s1, 1 # decrementing the counter
		bgt $s1, $zero, print
	
	subi $s0, $s0, 4 
	move $s2, $s0 # storing the address of last element of the array to use later
	
 	lw $s1, 0($sp) # restore $s1 from stack
 	lw $s0, 4($sp) # restore $s0 from stack
 	addi $sp, $sp, 8 # deallocate stack space
		
	la $a0, endl	
       	li $v0, 4	
       	syscall
	jr $ra
	
CheckSymmetric: # Subprogram number 2
	move $s0, $a0 # saving the arguments in $s registers
	move $s1, $a1
	addi $sp, $sp, -12 # allocating space in stack
	
	sw $s2, 8($sp) # save $s2 on stack
	sw $s0, 4($sp) # save $s0 on stack
 	sw $s1, 0($sp) # save $s1 on stack
 	
 	check:
 		lw $s3, ($s0)
 		lw $s4, 0($s2)

 		bne $s3, $s4, notSymmetric # if not equal not symmetric
 		
 		addi $s0, $s0, 4 # incrementing address
		subi $s2, $s2, 4 # decrementing address
		addi $s1, $s1, -1
		
 		bge $s1, 2, check

 	
 	la $a0, ans1	# output prompt message on terminal
        li $v0, 4	# syscall 4 prints the string
        syscall	
        
 	lw $s1, 0($sp) # restore $s1 from stack
 	lw $s0, 4($sp) # restore $s0 from stack
 	lw $s2, 8($sp) # restore $s2 from stack
 	addi $sp, $sp, 12 # deallocate stack space
	jr $ra		
 	
 	notSymmetric:
 		la $a0, ans2	# output not symmetric message on terminal
        	li $v0, 4	# syscall 4 prints the string
        	syscall	
        	jr $ra
 		lw $s1, 0($sp) # restore $s1 from stack
 		lw $s0, 4($sp) # restore $s0 from stack
 		lw $s2, 8($sp) # restore $s2 from stack
 		addi $sp, $sp, 12 # deallocate stack space
		jr $ra
	
FindMinMax: # sub program number 3
        move $s0, $a0 #array
	move $s1, $a1 #array size
	addi $sp, $sp, -8
	
	sw $s0, 4($sp) # save $s0 on stack
 	sw $s1, 0($sp) # save $s1 on stack
        
        lw $s2, 0($s0) # setting max and min to first element
        lw $s3, 0($s0)
        
        find:
        	lw $s5, 0($s0)
        	ble $s3, $s5, notMin # if current number is greater than min branch not min
        	move $s3, $s5 # not branched then new min is the current number
        	j notMax # not max if it has come too far
        notMin:
        	ble $s5, $s2, notMax # not greater than maz so branch not max
        	move $s2, $s5 # not branched then it new max
        notMax:
        	addi $s0, $s0, 4 # increment address
        	subi $s1, $s1, 1 # decrement count
        	bgt $s1, $zero, find # jump back to the loop
        
        	
        	move $v0, $s2 # storing min and max to return main
        	move $v1, $s3
        	lw $s1, 0($sp) # restore $s1 from stack
 		lw $s0, 4($sp) # restore $s0 from stack
 		addi $sp, $sp, 8 # deallocate stack space
        	jr $ra            
#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
array: .word 10, 20, 30, 30, 20, 10
arraySize: .word 6
prompt: .asciiz "Hello mate, I will show you some skills of mine!\nI will display the array, will find min and max of it and tell you if it is symmetric\nFirst of all let me print the contents of array: "
bye:    .asciiz "Thanks for using this program! \n"
ans1:	.asciiz "The array is symmetric. \n"
ans2:   .asciiz "The array is not symmetric. \n"
maxis: .asciiz "The max of array is: "
minis: .asciiz "The min of array is: "
space: .asciiz " "
endl:	.asciiz "\n"

##
## end of file lab2part1.asm
