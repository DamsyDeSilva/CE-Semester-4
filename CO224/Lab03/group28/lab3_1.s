@ ARM Assembly - lab 3.1
@ Group Number : 28
@ Roshan Ragel - roshanr@pdn.ac.lk
@ Hasindu Gamaarachchi - hasindu@ce.pdn.ac.lk

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	
mypow:
	mov r2, r0	@keep x
	cmp r1, #0	@cmp n with 0
	bne l1
	mov r0, #1	@ n == 0 : return 1
	mov pc,lr

l1:
	sub sp, sp, #4
	str lr, [sp, #0]
	
	sub r1, r1, #1	@n-1;
	bl mypow	@mypow(x,n-1)
	mov r12, r0

	ldr lr, [sp, #0]
	add sp, sp, #4

	mul r0, r12, r2	  @ x * mypow(x,n-1)
	mov pc,lr

@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #8	@the value x
	mov r5, #3 	@the value n
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl mypow
	mov r6,r0
	

	@ load aguments and print
	ldr r0, =format
	mov r1, r4
	mov r2, r5
	mov r3, r6
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "%d^%d is %d\n"

