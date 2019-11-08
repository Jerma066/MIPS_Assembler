.text 
	main:
	
la	$a0,	my_word
li	$a1,	14	

#read string:		$a0 = address of input buffer	
#			$a1 = maximum number of characters to read
li	$v0,	8
syscall	

#Printing an integer element in a0 register as a decimal number
li	$v0,	4
syscall

#exit (terminate execution)
li	$v0,	10
syscall	

.data
	my_word:	.space	20
