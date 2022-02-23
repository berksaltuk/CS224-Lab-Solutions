##
## A program which finds min, max of an array and average of elements.
## Inputs the size and elements of the array and displays them in terms of both address and value. 
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
	
	jal printArray
	
	jal findMax
	jal findMin
	
	la $a0, bye	# output prompt message on terminal
        li $v0, 4	# syscall 4 prints the string
        syscall
	
	li $v0,10		# system call to exit
        syscall		#    bye bye
        
       

printArray:
	la $a0, memadd # Memory address and element 
        li $v0, 4 # syscall 4 prints the string
        syscall
        
        la $a0, posval # pos and value headers
        li $v0, 4 # syscall 4 prints the string
        syscall
        
        la $a0, separator # printing a separator
        li $v0, 4 # syscall 4 prints the string
        syscall
        
        la $t0, array
	lw $t1, arrsize

        print: 
		add $a0, $zero, $t0
		li $v0, 34
		syscall
		
		la $a0, space	# output prompt message on terminal
       		li $v0, 4	# syscall 4 prints the string
      		syscall
		
        	lw $a0, 0($t0)
        	li $v0 1
        	syscall
        	
        	la $a0, endl	# output prompt message on terminal
       		li $v0, 4	# syscall 4 prints the string
      		syscall
		
      		lw $t2, 0($t0)
        	add $t3, $t3, $t2

        	addi $t0, $t0, 4 # incrementing the addres
		subi $t1, $t1, 1 # decrementing the counter
        	bgt $t1, $zero, print
        
        
       	lw $t4, arrsize
        div $t3, $t4
        mflo $t3
       	sw $t3, avg
        
        la $a0, endl	# output prompt message on terminal
        li $v0, 4	# syscall 4 prints the string
       	syscall
        	
        la $a0, ans1	# output prompt message on terminal
        li $v0, 4	# syscall 4 prints the string
        syscall	
        
        lw $a0, avg
        li $v0 1
        syscall
        
        la $a0, endl	# output prompt message on terminal
        li $v0, 4	# syscall 4 prints the string
        syscall	
        
        jr $ra
	
findMax:
	la $t0, array
	lw $s0, 0($t0)
	
	lw $t1, arrsize	
	
	find: 
		ble $t1, $zero, done
		addi $t0, $t0, 4 # incrementing the addres
		lw $t3, ($t0)
		bge $s0, $t3, newmax
		lw $s0, 0($t0)

	newmax:
		subi $t1, $t1, 1 # decrementing the counter
		
		j find

	done: 
		
		la $a0, ans2	# output prompt message on terminal
       		li $v0, 4	# syscall 4 prints the string
       		syscall	
        
        	li $v0 1
        	la $a0 ($s0)
        	
       		syscall
        	
       		la $a0, endl	# output prompt message on terminal
		li $v0, 4	# syscall 4 prints the string
       		syscall	
     
  		jr $ra    
 
findMin:

	la $t0, array
	lw $s0, 0($t0)
	
	lw $t1, arrsize	
		
	for: 
		ble $t1, $zero, donemin
		addi $t0, $t0, 4 # incrementing the addres
		lw $t3, ($t0)
		ble $s0, $t3, newmin
		lw $s0, 0($t0)

	newmin:
		subi $t1, $t1, 1 # decrementing the counter
		
		j for

	donemin: 
		la $a0, ans3	# output prompt message on terminal
       		li $v0, 4	# syscall 4 prints the string
       		syscall	
        
        	li $v0 1
        	la $a0 ($s0)
       		syscall
        	
       		la $a0, endl	# output prompt message on terminal
		li $v0, 4	# syscall 4 prints the string
       		syscall	
     
  		jr $ra   	
#################################
#					 	#
#     	 data segment		#
#						#
#################################

	.data
array: .word 10, 20, 2, 4, 23, 82, 23 #4 for each so max 20 elements
arrsize: .word 7
prompt:	.asciiz "Welcome! This program will do several things with the array you will give. \n"
enterSize: .asciiz "Can you enter the size of your array? (Max 20 would be good :D) \n"
enterElement: .asciiz "Can you enter the elements of your array? \n"
memadd: .asciiz "Memory Address     Array Element\n"
posval: .asciiz "Position (hex)     Value (int)\n"
separator: "================   ================\n"
ans1:	.asciiz "Average: "
ans2:   .asciiz "Max: "
ans3: .asciiz "Min: "
avg: .word 0

bye:    .asciiz "Thanks for using this program! \n"
space: .asciiz "         "
endl:	.asciiz "\n"

##
## end of file lab1part3.asm
