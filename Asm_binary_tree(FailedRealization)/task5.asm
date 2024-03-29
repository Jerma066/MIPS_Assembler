.data
	#sequence:	.word	'+', '*', 56, 11, 77  			#answer is (11*77) + 56 = 903 
	#sequence:	.word	'+', '*', 56, 0, 77  			#answer is (0*77) + 56 = 56
	#sequence:	.word	'+', '*', '*', 11, 77, 1, 56		#answer is (11*77) + (56*1) = 903
	sequence:	.word	'-', '*', 6, 1, 7			#answer is (1*7) - 6 = 1
	exec_seq:	.word	
	num_of_elems:	.word	5
	
.text
	main:
#Number of elements
li	$t1,	0
lw 	$t6,	num_of_elems($t1)

move	$s1,	$t6		#�������� ��� �������� ��������� � ����������
mul	$s1,	$s1,	4	#������ � ����������� ����������������� �� ������� ����� ����

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

#t8 - (��������� �� ������� � ����������� ������������������)*4
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
	jal	add_a0
	addi	$s0,	$s0,	1	#��������� ���������� ���������

	#Move �� ����  ������� ������� �������
	addi	$t2,	$t2,	4
	
	#����� �� �����	������������������ -> ����� �� ������ ����� 
	div,	$t5,	$t2,	4
	bge	$t5,	$t6,	print_parent

	#������ �������:
	lw	$a0,	sequence($t2)
	jal	add_a0
	addi	$s0,	$s0,	1	#��������� ���������� ���������
	
	#Move �� ����  ������� ������� �������
	addi	$t2,	$t2,	4
	
	
	print_parent:
		#��������
		lw	$a0,	sequence($t3)
		jal	add_a0
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
	beq	$t6,	0,	execute_binary_tree		#���� �������� ��� �������� ����������� ����������
	ble	$t1,	1,	add_root			#���� ��������� �� ������ ������, �������� ������ �������

	bge	$t6,	3,	first_step
	
add_root:
	li	$t3,	0
	lw	$a0,	sequence($t3)
	jal	add_a0
	
execute_binary_tree:
	#t1 - (������ �������� ����������� ������������������)*4
	#a1 - ������ ����� �� ������������������, ��� ������� ����������� �������
	#a2 - ������ ����� �� ������������������ ��� ������� ����������� ��������
	#a3 - ������ ��������� ��������
	#t2 - ������ ��������
	#t3 - ������ ��������� ���������� ��������
	
	li,	$t1,	0
	
	#������ ��� ������ �����, ������ ������ ��������, ����� ������ ����������
	lw	$a1,	exec_seq($t1)	#�������� ������ ����� ��� ������� ����� ����������� ��������
	addi	$t1,	$t1,	4	#������� ��������� �� ����������� �����������������
	
	lw	$a2,	exec_seq($t1)	#�������� ������ ����� ��� ������� ����� ����������� ��������
	addi	$t1,	$t1,	4	#������� ��������� �� ����������� �����������������
	
	lw	$t2,	exec_seq($t1)	#�������� �������� �������, ����� �����������
	#����� ������� ������ ����������� �������������������� �� �����, ������ ��� ����� ������������ �� �������, � ������� �������� ���� ����
	
	beq	$t2,	43,	sum_a1_a2	
	beq	$t2,	42,	mul_a1_a2
	beq	$t2,	45,	sub_a1_a2
	
	make_operations:
		find_operation:
			#�������� ������ ����� �� ������������������
			sub	$t1,	$t1,	8
			lw	$a1,	exec_seq($t1)
			
			#�������� ������ ����� �� ������������������
			addi	$t1,	$t1,	4
			lw	$a2,	exec_seq($t1)	
			
			#���������� ������� �� �����
			addi	$t1,	$t1,	4	
			
		
			lw	$t2,	exec_seq($t1)		#�������� �������� �������, ����� �����������
			
			beq	$t2,	43,	sum_a1_a2	#���� �� �������� ������ �������� 
			beq	$t2,	42,	mul_a1_a2	#���� �� �������� ������ �������� 
			beq	$t2,	45,	sub_a1_a2	#���� �� �������� ������ �������� 

			bge	$t1,	$s1,	exit_programm	#���� �� � ����� ����� ����������� ������������������, �������
			addi	$t1,	$t1,	4		#������� ��������� �� ����������� �����������������
			
			j find_operation
	  	
	  	after_operation:
	  	
	  	bge	$t1,	$s1,	exit_programm
	  	j	make_operations
	  	
#---��������� ��������------------------------------------------------
exit_programm:
	sub,	$t1,	$t1,	4
	lw,	$a0,	exec_seq($t1)		#���������� ��, �� ���� �����
	#��������� ������ a0
	li	$v0,	1			
	syscall	

	#exit (terminate execution)
	li	$v0,	10
	syscall	
	
sum_a1_a2:
	add	$a3,	$a2,	$a1
	sw,	$a3,	exec_seq($t1)		#������ �������� � �� �����, ������ ������� ��������
	
	#��������� ���������� ��������� ����� ������������� ���������, ���������� ����������� ���������
	sub	$t1,	$t1,	4
	sw,	$t3,	exec_seq($t1)		#������ �������� � �� �����, ������ ������� ��������
	add	$t1,	$t1,	4
	move	$t3,	$a3			#����������� ������ 
	
	j	after_operation
	
mul_a1_a2:
	mul	$a3,	$a2,	$a1		
	sw,	$a3,	exec_seq($t1)		#������ �������� � �� �����, ������ ������� ��������

	#��������� ���������� ��������� ����� ������������� ���������, ���������� ����������� ���������
	sub	$t1,	$t1,	4
	sw,	$t3,	exec_seq($t1)		#������ �������� � �� �����, ������ ������� ��������
	add	$t1,	$t1,	4
	move	$t3,	$a3			#����������� ������ 
	
	j	after_operation	
	
sub_a1_a2:
	sub	$a3,	$a1,	$a2
	sw,	$a3,	exec_seq($t1)		#������ �������� � �� �����, ������ ������� ��������
	
	#��������� ���������� ��������� ����� ������������� ���������, ���������� ����������� ���������
	sub	$t1,	$t1,	4
	sw,	$t3,	exec_seq($t1)		#������ �������� � �� �����, ������ ������� ��������
	add	$t1,	$t1,	4
	move	$t3,	$a3			#����������� ������ 
	
	j	after_operation
	
t4_is_0:
	li,	$t4,	0
	j	continue_after_init_t4

t4_is_1:
	li,	$t4,	1
	j	continue_after_init_t4
	
add_a0:
	sw	$a0,	exec_seq($t8)
	addi	$t8,	$t8,	4	 #����� ������ � ����������� ������������������
	jr	$ra	
	
print_a0:
	#Printing an integer element in a0 register as a decimal number
	li	$v0,	1	
	syscall
	jr	$ra	
