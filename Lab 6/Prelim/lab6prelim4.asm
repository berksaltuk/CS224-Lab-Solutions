##
## Matrix Computer
##  

#########################################
#					#
#  Created by Berk Saltuk Y?lmaz (bsy)	#
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
	jal interface
		
	la $a0, bye	# output goodbye message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
	
	li $v0,10	# system call to exit
        syscall		# bye bye

interface:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, prompt	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
	
	userLoop:
		la $a0, sep # output prompt message on terminal
       		li $v0, 4	# syscall 4 prints the string
       		syscall
       		
		la $a0, option1	# output prompt message on terminal
       		li $v0, 4	# syscall 4 prints the string
       		syscall
       		
       		la $a0, option2	# output prompt message on terminal
       		li $v0, 4	# syscall 4 prints the string
       		syscall
       		
       		la $a0, option3	# output prompt message on terminal
       		li $v0, 4	# syscall 4 prints the string
       		syscall
       		
       		la $a0, option4	# output prompt message on terminal
       		li $v0, 4	# syscall 4 prints the string
       		syscall
       		
       		la $a0, option5	# output prompt message on terminal
       		li $v0, 4	# syscall 4 prints the string
       		syscall
       		
		la $a0, quitOp	# output prompt message on terminal
       		li $v0, 4	# syscall 4 prints the string
       		syscall
       		
       		la $a0, waiting	# output prompt message on terminal
       		li $v0, 4	# syscall 4 prints the string
       		syscall
       		
       		li $t0, 1
       		li $t1, 2
       		li $t2, 3
       		li $t3, 4
       		li $t4, 5
       		li $t5, 6
       		
       		li $v0, 5
       		syscall
       		
       		move $s0, $v0
       		
       		la $a0, endl	# output prompt message on terminal
       		li $v0, 4	# syscall 4 prints the string
       		syscall
       		op1: 	bne $s0, $t0, op2
       		
       			la $a0, getDim	# output prompt message on terminal
       			li $v0, 4	# syscall 4 prints the string
       			syscall
       			
       			li $v0, 5
       			syscall
       			
       			move $s1, $v0
       			mul $s2, $s1, $s1 # num of elements
       			
       		     	j notThis
       		     	
       		op2: 	bne $s0, $t1, op3
       			
       			mul $a0, $s2, 4
       			li $v0, 9
       			syscall
       			
       			move $s3, $v0 # first element of matrix
       			
       			jal createMatrix
       			
       			j notThis
       			
       		op3:	bne $s0, $t2, op4
       		
       			la $a0, giveRow	# output prompt message on terminal
       			li $v0, 4	# syscall 4 prints the string
       			syscall
       			
       			li $v0, 5 
			syscall
			
			sw $v0, row
       		
       			la $a0, giveColumn	# output prompt message on terminal
       			li $v0, 4	# syscall 4 prints the string
       			syscall
       			
       			li $v0, 5 
			syscall
			
			sw $v0, col
			
			lw $a0, row
			lw $a1, col
			
			jal displaySpecific
			
       			j notThis
       			
       		op4: 	bne $s0, $t3, op5
       		
       			jal rowMajorAvg
       			j notThis
       		
       		op5: 	bne $s0, $t4, op6
       			
       			jal colMajorAvg
       			j notThis
       			
       		op6: 	beq $s0, $t5, quit
       			j notThis
       			
       		notThis: j userLoop
       		
	quit:	lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra

createMatrix:
	addi $sp, $sp, -8
	sw $ra, 0($sp)
	sw $s3, 4($sp)
	
	li $t1, 1
	create:
		sw $t1, 0($s3)
		addi $s3, $s3, 4
		addi $t1, $t1, 1
		ble $t1, $s2, create
	
	
	la $a0, readyMatrix	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
	lw $s3, 4($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 8
	jr $ra

displaySpecific:
	move $t4, $a0
	move $t5, $a1
	
	addi $t1, $a0, -1 # (i - 1)
	mul $t1, $t1, 4 # (i - 1)*4
	mul $t1, $t1, $s1 # (i - 1)*4*N
	
	addi $t0, $a1, -1 # (j - 1)
	mul $t0, $t0, 4 # (j - 1)*4
	
	add $t1, $t1, $t0 # (i - 1)*N*4 + (j - 1)*4
	add $t1, $t1, $s3 # finding displacement base address to specific address
	
	la $a0, specific	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
	
	move $a0, $t4	# output prompt message on terminal
       	li $v0, 1	# syscall 4 prints the string
       	syscall
   	
       	la $a0, comma	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	move $a0, $t5	# output prompt message on terminal
       	li $v0, 1	# syscall 4 prints the string
       	syscall
       	
       	la $a0, element	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	lw $a0, 0($t1)	# output prompt message on terminal
       	li $v0, 1	# syscall 4 prints the string
       	syscall
       	
       	la $a0, endl	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
	jr $ra
rowMajorAvg:
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s2, 4($sp)
	sw $s3, 8($sp)
	
	li $t0, 0
	
	findRowSum:
		lw $t1, 0($s3)
		add $t0, $t0, $t1
		addi $s3, $s3, 4
		addi $s2, $s2, -1
		bgt $s2, $zero, findRowSum
	
	lw $s2, 4($sp)
	div $t0, $s2
	mflo $t2
	
	la $a0, rowMessage	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	move $a0, $t2
       	li $v0, 1
       	syscall
       	
       	la $a0, endl	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
	lw $s3, 8($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	jr $ra

colMajorAvg:
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s2, 4($sp)
	sw $s3, 8($sp)
	
	li $t0, 0 # current sum
	
	li $t1, 0 # current col is zero
	mul $t2, $s1, 4 # N*4
	colLoop: # column changes at 4 and row changes N*4 
		li $t4, 0 # cur row
		
		mul $t3, $t1, 4 # current disp of col
		add $t6, $s3, $t3
		lw $t5, 0($t6)
		add $t0, $t0, $t5
		
		rowLoop:
			add $t6, $t6, $t2
			lw $t5, 0($t6)
			add $t0, $t0, $t5
			addi $t4, $t4, 1
			blt $t4, $s1, rowLoop
		add $t1, $t1, 1
		blt $t1, $s1, colLoop
	
	lw $s2, 4($sp)
	div $t0, $s2
	mflo $t7
	
	la $a0, colMessage	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
       	move $a0, $t7
       	li $v0, 1
       	syscall
       	
       	la $a0, endl	# output prompt message on terminal
       	li $v0, 4	# syscall 4 prints the string
       	syscall
       	
	lw $s3, 8($sp)
	lw $ra, 0($sp)
	addi $sp, $sp, 12
	jr $ra
#################################
#				#
#     	 data segment		#
#				#
#################################

	.data
prompt: .asciiz "Welcome to the coolest matrix average computer!\nThere are several options you can choose:\n"
bye:    .asciiz "Thanks for using this program! \n"
getDim: .asciiz "What is the dimension of the matrix? : \n"
space: .asciiz " "
endl:	.asciiz "\n"
option1: .asciiz "1. Choose a dimension for the matrix.\n"
option2: .asciiz "2. Allocate the array for me!\n"
option3: .asciiz "3. Display a specific array by giving row and column no.\n"
option4: .asciiz "4. Display the row-major average.\n"
option5: .asciiz "5. Display the column-major average.\n"
waiting: .asciiz "Waiting for answer:"
quitOp: .asciiz "6. Quit\n"
giveRow: .asciiz "Can you give the row number? : \n"
giveColumn: .asciiz "Can you give the column number? : \n"
sep: .asciiz "*******************************************************\n"
row: .word 0
col: .word 0
rowMessage: .asciiz "Average found in row-major fashion is: "
colMessage: .asciiz "Average found in col-major fashion is: "
specific: .asciiz "The element in ("
comma: .asciiz ", "
element: .asciiz ") is "
readyMatrix: .asciiz "Matrix has been created.\n"
##
## end of file lab6prelim4.asm
