@ ARM Assembly - exercise 4
@ Group Number : 28

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@ load values
	mov r0, #3
	mov r1, #5
	mov r2, #7
	mov r3, #-8

	
	@ Write YOUR CODE HERE
	@ if (i>5) f = 70;
	@ else if (i>3) f=55;
	@ else f = 30;
	@ i  in r0
	@ Put f to r5
	@ Hint : Use MOV instruction
	@ MOV r5,#70 makes r5=70

	@ ---------------------
	

	cmp r0, #5	@cmp i, 5
	bgt seq1	@if greater than  go to seq1

	cmp r0, #3	@else cmp i, 3
	bgt seq2	@if greater than  go to seq2
	
	mov r5, #30 @f = 30
	b exit

seq2: 
	
	mov r5, #55	@f = 55
	b exit
seq1:

	mov r5, #70	@f = 70

exit:
	

	
	
	@ ---------------------
	
	
	@ load aguments and print
	ldr r0, =format
	mov r1, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "The Answer is %d (Expect 30 if correct)\n"

