.data
	magic_numbers: .word	35, 40, 41, 544, 65, 215, 1351, 66, 90, 15, 13, 26, 320, 540, 97, 32, 85, 915, 48, 58
	
.text
	main:
li	$t1,	0

loop:
	mul	$t3,	$t1,	4
	lw	$t0,	magic_numbers($t3)	# Подгружаем в $t0 жлемент массива под номером $t1
	rem	$t4,	$t0,	5		# В t4 кладем остаток от деления на 5
	beq	$t4,	0,	magic_br	#the main branch
	move	$t4,	$zero
	
magic_br:
	addi	$t1,	$t1,	1
	beq	$t1,	20,	endloop
	j	loop
	
endloop:
	li	$v0,	10
	syscall 
