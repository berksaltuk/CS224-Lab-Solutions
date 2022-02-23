##
## Creates a dynamic array by inputting size and elements from user.
##  Displays max and min values, checks if the array is syymetric and display the values in the array.
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
	
	jal getArray # calling getArray to input size and elements
	
	move $t0, $v0 # saving address of first element and size in $t registers to use later
	move $t1, $v1
	
	la $a0, ($t0) # calling check symmetric	
	move $a1, $t1
	jal CheckSymmetric
	
	la $a0, ($t0) # calling check symmetric	
	move $a1, $t1
	jal FindMinMax
	
	move $s0, $v0 # saving min and max to print
	move $s1, $v1
	
	la $a0, maxis	# output max message on terminal
        li $v0, 4	# syscall 4 prints the string
        syscall
        	
        move $a0, $s0
        li $v0 1
        syscall
        	
        la $a0, endl	
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       		
        la $a0, minis	# output min message on terminal
        li $v0, 4	# syscall 4 prints the string
        syscall
        	
        move $a0, $s1
        li $v0 1
        syscall
        	
        la $a0, endl	
       	li $v0, 4	# syscall 4 prints the string
       	syscall
	
	la $a0, bye	# output goodbye message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
	
	li $v0,10	# system call to exit
        syscall		# bye bye

getArray:
	addi $sp, $sp, -12
	
	la $a0, getSize	# output get size message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
		
	li $v0, 5
	syscall
	
	beqz $v0, getArray # if size entered is 0 ask again...
	
	sw $v0, size

	lw $s5, size # keeping size in $s5 
	sll $s6, $s5, 2 # multiplying with 4 for allocation
	
	move $a0, $s6 # The bytes size of the memory location to be allocated
	li $v0, 9 # Used for dynamic storage allocation
	syscall # Perform storage allocation by using values stored in $a0 (memory size) and $v0 (action to be

	add $s7, $zero, $v0 # storing the address of first element
	
	sw $s7 0($sp) # save $s7 on stack
	sw $s5 4($sp) # save $s5 on stack
	sw $ra, 8($sp) # saving return address to be able to return main after returning from print array subprogram
	la $a0, read	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
	
	getElements:
		li $v0, 5 # getting elements
        	syscall
		
		sw $v0, 0($s7) # saving value to the current address
		addi $s7, $s7, 4 # incrementing the addres
		subi $s5, $s5, 1 # decrementing the counter   
			
		bgt $s5, $zero, getElements
		  
	
	lw $s7 0($sp) # restore $s7 from stack
	lw $s5 4($sp) # restore $s5 from stack

	la $a0, ($s7) # calling printArray
	move $a1, $s5
	jal PrintArray
	
	lw $ra, 8($sp) # restoring ra to get back to main (it is overwritten printArray)
	addi $sp, $sp, 12 # deallocating the stack
	
	la $v0, 0($s7) # returning size and first element's address
	move $v1, $s5
	jr $ra

PrintArray:
	move $s0, $a0 # saving arguments
	move $s1, $a1
	addi $sp, $sp, -8 # allocating space from stack
	
	sw $s0, 4($sp) # save $s0 on stack
 	sw $s1, 0($sp) # save $s1 on stack
      	
      	la $a0, contents 
      	li $v0, 4
      	syscall
      	
	print:
		lw $a0, 0($s0) # printing the element in the current index
        	li $v0 1
        	syscall
		
		la $a0, space	# output prompt message on terminal
       		li $v0, 4	# syscall 4 prints the string
       		syscall
	
		addi $s0, $s0, 4 # incrementing the addres
		subi $s1, $s1, 1 # decrementing the counter
		bgt $s1, $zero, print
	
	subi $s0, $s0, 4 # keeping the last element's array
	move $s2, $s0
	
 	lw $s1, 0($sp) # restore $s1 from stack
 	lw $s0, 4($sp) # restore $s0 from stack
 	addi $sp, $sp, 8 # deallocate stack space
		
	la $a0, endl	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
	jr $ra
	
CheckSymmetric:
	move $s0, $a0 # saving size and address of first element
	move $s1, $a1
	addi $sp, $sp, -12 # allocate space from stack
	
	sw $s2, 8($sp) # save $s2 on stack
	sw $s0, 4($sp) # save $s0 on stack
 	sw $s1, 0($sp) # save $s1 on stack
 	
 	check:
 		lw $s3, ($s0)
 		lw $s4, 0($s2)

 		bne $s3, $s4, notSymmetric
 		
 		addi $s0, $s0, 4 # incrementing address
		subi $s2, $s2, 4 # decrementing address
		addi $s1, $s1, -1
		
 		bge $s1, 2, check

 	
 	la $a0, ans1	# output symmetric message on terminal
        li $v0, 4	# syscall 4 prints the string
        syscall	
        
 	lw $s1, 0($sp) # restore $s1 from stack
 	lw $s0, 4($sp) # restore $s0 from stack
 	lw $s2, 8($sp) # restore $s2 from stack
 	addi $sp, $sp, 12 # deallocate stack space
	jr $ra		
 	
 	notSymmetric:
 		la $a0, ans2	# output notSymmetric message on terminal
        	li $v0, 4	# syscall 4 prints the string
        	syscall	
        	jr $ra
 		lw $s1, 0($sp) # restore $s1 from stack
 		lw $s0, 4($sp) # restore $s0 from stack
 		lw $s2, 8($sp) # restore $s2 from stack
 		addi $sp, $sp, 12 # deallocate stack space
		jr $ra
	
FindMinMax:
        move $s0, $a0 #array
	move $s1, $a1 #array size
	addi $sp, $sp, -8
	
	sw $s0, 4($sp) # save $s0 on stack
 	sw $s1, 0($sp) # save $s1 on stack
        
        lw $s2, 0($s0) # setting max and min to first element
        lw $s3, 0($s0)
        
        find:
        	lw $s5, 0($s0)
        	ble $s3, $s5, notMin  # if current number is greater than min branch not min
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
        	lw $s1, 0($sp) # restore $t0 from stack
 		lw $s0, 4($sp) # restore $s0 from stack
 		addi $sp, $sp, 8 # deallocate stack space
        	jr $ra            
#################################
#				#
#     	 data segment		#
#				#
#################################

	.data
prompt: .asciiz "Hello mate, I will show you some skills of mine!\nI will display the array, will find min and max of it and tell you if it is symmetric\n"
bye:    .asciiz "Thanks for using this program! \n"
getSize: .asciiz "Please enter the size of your array (It cannot be zero):"
ans1:	.asciiz "The array is symmetric. \n"
ans2:   .asciiz "The array is not symmetric. \n"
maxis: .asciiz "The max of array is: "
minis: .asciiz "The min of array is: "
read: .asciiz "Please enter the elements of your array: \n"
contents: .asciiz "The contents of your array: "
size: .word 0
space: .asciiz " "
endl:	.asciiz "\n"

##
## end of file lab2part3.asm
