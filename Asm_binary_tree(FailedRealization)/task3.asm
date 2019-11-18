.data
First_Str:	.asciiz	"Hello, world! "
Islam_Str:	.asciiz	"My name is Islam"


.text
	main:
la	$a0,	First_Str
#Printing an string element in a0 register
li	$v0,	4
syscall

la	$a0,	Islam_Str		
li	$v0,	4
syscall	

#exit (terminate execution)
li	$v0,	4
syscall	