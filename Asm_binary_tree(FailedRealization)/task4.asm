.data
	#sequence:	.word	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,   			#answer is 8 9 4 10 11 5 6 7 2 3 1
	#sequence:	.word	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15  	#answer is 8 9 4 10 11 5 12 13 6 14 15 7 2 3 1
	#sequence:	.word	32, 4, 56, 11, 77, 89				   	#answer is 11 77 4 89 56 32
	#sequence:	.word	32, 4, 56, 11, 77, 89, 67			   	#answer is 11 77 4 89 67 56 32
	#sequence:	.word	32, 4, 56,				   		#answer is 4 56 32
	#sequence:	.word	32, 4,				   			#answer is 4 32
	sequence:	.word	1, 2, 3, 4, 5, 6, 7, 8					#answer is 8 4 5 6 7 2 3 1

	num_of_elems:	.word	8
	
	space_str:	.asciiz	" " 
.text
	main:
#Number of elements
li	$t1,	0
lw 	$t6,	num_of_elems($t1)

#-----------������� ���������� ������� � t1-------------------------------
first_step:
li	$t1,	0
li	$t2,	1
	
num_of_levels_in_t1:
	mul	$t2,	$t2,	2
	addi	$t1,	$t1,	1 	
	ble	$t2,	$t6,	num_of_levels_in_t1
	
#-------------------------------------------------------------------------

#������� ����� ��������� �� ������ ������� �� ������������� ������ 
#��� ����� ����� t2 �������� �� 2, ����� ��� �� 2, � ����� �������� �� 4.  
#����� ���� ����� ������� ���� �������
move	$t3,	$t2
sub 	$t3,	$t3,	4

#������� ����� ������� �������� �� ��������� ������
#��� ����� ����� t2 �������� �� 2, � ����� �������� �� 4 <=> �������� �� 2
#����� ���� ����� ������� ���� �������
mul	$t2,	$t2,	2
sub 	$t2,	$t2,	4
	
#---��������� ���������� ��� ����� �� ������ ������ ������������---
li	$t4, 	1
sub	$t7,	$t1,	2
num_of_children_on_level_in_t4:
	mul	$t4,	$t4,	2
	sub	$t7,	$t7,	1 
	bgtz	$t7,	num_of_children_on_level_in_t4
	
beq	$t1,	1,	t4_is_0
beq	$t1,	2,	t4_is_1	

continue_after_init_t4:
#------------------------------------------------------------------


#t5 - ������ ������ �����
#t4 - ���������� ��� ����� �� ������
#t3 - ������ (������ ��������)*4
#t2 - ������ (������ �����)*4
#t1 - ������ ����� ������
#s0 - ��������� ���������� ���������

get_items_from_level:

	#����� �� �����	������������������ -> ����� �� ������ ����� 
	div,	$t5,	$t2,	4
	bge	$t5,	$t6,	print_parent
		
	#������ �������:
	lw	$a0,	sequence($t2)
	jal	print_a0
	jal	print_space
	addi	$s0,	$s0,	1	#��������� ���������� ���������

	#Move �� ����  ������� ������� �������
	addi	$t2,	$t2,	4
	
	#����� �� �����	������������������ -> ����� �� ������ ����� 
	div,	$t5,	$t2,	4
	bge	$t5,	$t6,	print_parent

	#������ �������:
	lw	$a0,	sequence($t2)
	jal	print_a0
	jal	print_space
	addi	$s0,	$s0,	1	#��������� ���������� ���������
	
	#Move �� ����  ������� ������� �������
	addi	$t2,	$t2,	4
	
	
	print_parent:
		#��������
		lw	$a0,	sequence($t3)
		jal	print_a0
		jal	print_space
		addi	$s0,	$s0,	1	#��������� ���������� ���������

		#Move �� ����  ������� ������� �������� � �������
		addi	$t3,	$t3,	4
	
		#��������� ���������� ��� �����
		sub	$t4,	$t4,	1
	
		#���� ����� ��� ����� �� 0, ����������: 
		bgtz 	$t4,	get_items_from_level
	
out_from_out_getting_level_items:
	sub 	$t1,	$t1,	2				#��������� ����� ������ �� 2
	sub	$t6,	$t6,	$s0				#�������� �� ������ ����� ���������� ���������� ���������
	li	$s0,	0					#�������� ������ ���������� ���������
	beq	$t6,	0,	exit_programm			#���� �������� ��� �������� ����������� ����������
	ble	$t1,	1,	print_root			#���� ��������� �� ������ ������, �������� ������ �������

	
	bge	$t6,	3,	first_step
	
print_root:
	li	$t3,	0
	lw	$a0,	sequence($t3)
	jal	print_a0
	
	
	
#---��������� ��������------------------------------------------------

exit_programm:
	#exit (terminate execution)
	li	$v0,	10
	syscall	
	
t4_is_0:
	li,	$t4,	0
	j	continue_after_init_t4

t4_is_1:
	li,	$t4,	1
	j	continue_after_init_t4

print_space:
	la	$a0,	space_str
	#Printing an string element in a0 register
	li	$v0,	4
	syscall
	#Reterning into the main program to the moment, where this func was called
	jr	$ra
	
print_a0:
	#Printing an integer element in a0 register as a decimal number
	li	$v0,	1	
	syscall
	jr	$ra
	
	
	
	


	
	
