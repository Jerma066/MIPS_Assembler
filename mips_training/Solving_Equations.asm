.text
#Task:	z = 2x^2 + 3y + 2
	main:
#x = t0; x = 3
li	$t0,	3

#y = t1; y = 5
li	$t1,	5

#t2 = 2*x^2
mul	$t2,	$t0,	$t0
mul	$t2, 	$t2, 	2

#t3 = 3*y + 2
mul	$t3, 	$t1, 	3
add	$t3, 	$t3, 	2

#2*x^2 + 3y + 2
add	$t4,	$t3,	$t2

move	$a0,	$t4
#Printing an integer element in a0 register as a decimal number
li	$v0,	1	
syscall


#exit (terminate execution)
li	$v0,	4
syscall	
