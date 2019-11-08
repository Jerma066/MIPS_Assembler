.text
	main:
la	$a0,	First_Str
la	$t0,	Islam_Str

#Printing an string element in a0 register
li	$v0,	4
syscall

move	$a0,	$t0
		
li	$v0,	4
syscall	

#exit (terminate execution)
li	$v0,	4
syscall	
				
.data
First_Str:	.asciiz	"Hello, world! "
Islam_Str:	.asciiz	"My name is Islam"