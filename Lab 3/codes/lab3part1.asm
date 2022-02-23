##
## Instruction Count Program
## This program counts add and lw instructions.
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
	
main:
	la $a0, prompt	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
	
	add $zero, $zero, $zero # to try if it is counting add instructions
	add $zero, $zero, $zero
	
	la $a0, main
       	la $a1, instructionCount     	   
	jal instructionCount
	
	move $s6, $v0
	move $s7, $v1
	
	la $a0, numOfAdd
	li $v0, 4
	syscall
	
	move $a0, $s6 
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, numOfLW
	li $v0, 4
	syscall
	
	move $a0, $s7 
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, instructionCount
       	la $a1, end    	   
	jal instructionCount

	move $s6, $v0
	move $s7, $v1

	la $a0, numOfAdd
	li $v0, 4
	syscall
	
	move $a0, $s6 
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	la $a0, numOfLW
	li $v0, 4
	syscall
	
	move $a0, $s7 
	li $v0, 1
	syscall
	
	la $a0, endl
	li $v0, 4
	syscall
	
	j end
	
instructionCount:
	add $zero, $zero, $zero # to try if it is counting add instructions
	add $zero, $zero, $zero
	add $zero, $zero, $zero
	add $zero, $zero, $zero
	add $zero, $zero, $zero
	add $zero, $zero, $zero
		
	move $s0, $a0
	move $s1, $a1
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $s1, 4($sp)

	li $s2, 0
	li $s3, 0

	loop:
		beq $s0, $s1, done
		lw $s4, 0($s0)
		srl $s5, $s4, 26
		beq $s5, 35, plusLW
		beq $s5, 0, checkFunc
		addi $s0, $s0, 4
		j loop
	
	checkFunc:
		and $s5, $s4, 63
		beq $s5, 32, plusAdd
		addi $s0, $s0, 4
		j loop
	plusAdd:
		addi $s2, $s2, 1
		addi $s0, $s0, 4
		j loop
	plusLW:
		addi $s3, $s3, 1
		addi $s0, $s0, 4
		j loop
		
	done:   
		move $v0, $s2
		move $v1, $s3
		lw $s1, 4($sp)
		lw $s0, 0($sp)
		addi $sp, $sp, 8
		jr $ra
end:
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
prompt: .asciiz "Welcome... This program counts lw (load word) and add instructions!\n"
wait: .asciiz "Work in progress...\n"
bye:    .asciiz "Thanks for using this program! \n"
endl:	.asciiz "\n"
addCount: .word 0
lwCount: .word 0
numOfAdd: .asciiz "The number of the add instructions in this program is: "
numOfLW: .asciiz "The number of the load word instructions in this program is: "
##
## end of file lab3part1.asm
