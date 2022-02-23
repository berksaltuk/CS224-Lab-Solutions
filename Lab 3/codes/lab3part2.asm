##
## Recursive Division Program
## Recursively subtracts divisor from divident and calculates quotient and remainder.
## Inputs the dividend and divisor.

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
	.globl menu	
	
menu:
	la $a0, prompt	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	j multCaller
       	
again:       	
       	la $a0, oneMore	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	li $v0, 5
        syscall
        
        beq $v0, 1, multCaller
        beq $v0, 2, exit
        
	j menu

multCaller:	
	la $a0, getNum1	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	li $v0, 5
        syscall
       	sw $v0, dividend
       	
       	la $a0, getNum2	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	li $v0, 5
        syscall
       	sw $v0, divisor
       	
       	lw $t0, divisor
       	beq $t0, $zero, warning
       	
       	la $a0, wait	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall

       	lw $a0, dividend
       	lw $a1, divisor
       	jal recursiveDivision
	move $s5, $v0
	move $s6, $v1
	
	la $a0, resultMsg1	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	move $a0, $s5	
       	li $v0, 1
       	syscall
       	
       	la $a0, endl   
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	la $a0, resultMsg2	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	move $a0, $s6	
       	li $v0, 1
       	syscall
       	
       	la $a0, endl   
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
 	j again
 	
recursiveDivision:	
    	addi $sp, $sp, -12
	sw $ra, 0($sp) 
	sw $a0, 4($sp)
	sw $a1, 8($sp) 

    	li $v0, 0	
    	blt $a0, $a1, done
    	sub $a0, $a0, $a1
    	move $v1, $a0
    	 
    	jal recursiveDivision
    	addi $v0, $v0, 1
	#addi $sp, $sp, 12
    	
done:
	lw $ra, 0($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	addi $sp, $sp, 12
	jr $ra    

		
warning: 	

 	la $a0, warningMsg   
       	li $v0, 4	# syscall 4 prints the string
       	syscall

 	j again
exit:   
	la $a0, bye     
       	li $v0, 4	# syscall 4 prints the string
       	syscall	
	li $v0,10		# system call to exit
        syscall		#    bye bye      	
#################################
#				#
#     	 data segment		#
#				#
#################################

	.data
prompt: .asciiz "Welcome! This is a program divides your numbers recursively!\n"
getNum1: .asciiz "Which number do you want to divide?\n"
getNum2: .asciiz "Which number is divisor?\n"
wait: .asciiz "Work in progress...\n"
oneMore: .asciiz "All done... Type 1 if you want one more division or 2 to exit!\n"
bye:    .asciiz "Thanks for using this program! \n"
space: .asciiz "         "
endl:	.asciiz "\n"
divisor: .word 0
dividend: .word 0
resultMsg1: .asciiz "Quotient is: "
resultMsg2: .asciiz "Remainder is: "
warningMsg: .asciiz "Divisor cannot be zero!\n"
##
## end of file lab3part2.asm
