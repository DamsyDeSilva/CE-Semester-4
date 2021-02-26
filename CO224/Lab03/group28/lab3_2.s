@ ARM Assembly - lab 3.2 
@ Group Number : 28

	.text 	@ instruction memory

	
@ Write YOUR CODE HERE	

@ ---------------------	
gcd:
	cmp r1, #0	
	bne l1		  @b == 0: return a
	mov pc, lr	

l1:
	sub sp, sp,#8
	str lr, [sp, #0]
	str r1, [sp, #4]

	bl mod		  @ a%b
	
	mov r1, r0	  @ r1 = a%b
	ldr r0, [sp, #4]  @ ldr prevoius b to r0
	bl gcd		  @ gcd(b, a%b)
	
	ldr lr, [sp, #0]
	add sp, sp, #8
		
	mov pc, lr

@mod function------
mod:

	cmp r0, r1	@r0 - a, r1 -b
	blt exit
	sub r0,r0,r1
	b mod	

exit:
	mov pc, lr




@ ---------------------	

	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	mov r4, #64 	@the value a
	mov r5, #24 	@the value b
	

	@ calling the mypow function
	mov r0, r4 	@the arg1 load
	mov r1, r5 	@the arg2 load
	bl gcd
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
format: .asciz "gcd(%d,%d) = %d\n"

