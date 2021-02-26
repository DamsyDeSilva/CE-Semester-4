@ ARM Assembly - exercise 7 
@ Group Number : 28

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	
Fibonacci:
	
	cmp r0, #2	
	bgt l1
	mov r0, #1		@n < 2 : return 1
	mov pc, lr

l1:
	sub sp, sp, #12
	str lr, [sp, #4]
	str r0, [sp, #0]

	sub r0, r0, #1 	 	@n-1;
	bl Fibonacci	 	@fib(n-1)
	mov r12, r0		
	str r12, [sp, #8]

	ldr r0, [sp, #0]	@ldr r0
	
	sub r0, r0, #2  	@n-2
	bl Fibonacci		@fib(n-2)
	mov r1, r0	
	
	ldr lr, [sp, #4]
	ldr r12, [sp, #8]
	add sp, sp, #12

	add r0, r1, r12		@fib(n-1) + fib(n-2)
	mov pc, lr

@ ---------------------
	
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #6	@the value n

	@ calling the Fibonacci function
	mov r0, r4 	@the arg1 load
	bl Fibonacci
	mov r5,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "F_%d is %d\n"

