.text 
	main:
lb	$a0,	0x10010000

#$a0 = character to print
li	$v0,	11
syscall

lb	$a0,	0x10010001
#li	$v0,	11
syscall

lb	$a0,	0x10010002
#li	$v0,	11
syscall

lb	$a0,	0x10010003
#li	$v0,	11
syscall


.data
bird_string:	.asciiz	"bird"