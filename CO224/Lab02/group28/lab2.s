@ ARM Assembly - lab 2
@ Group Number : 28

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@ load values
	mov r0, #10
	mov r1, #5
	mov r2, #7
	mov r3, #-8

	
	@ Write YOUR CODE HERE
	
	@	Sum = 0;
	@	for (i=0;i<10;i++){
	@			for(j=5;j<15;j++){
	@				if(i+j<10) sum+=i*2
	@				else sum+=(i&j);	
	@			}	
	@	} 
	@ Put final sum to r5


	@ ---------------------

	
	mov r6, #0	@i	
	mov r5, #0	@sum

loop1:

	cmp	r6,#10	@cmp i, 10
	bge exit1
	
	mov r1, #5	@j
	loop2: 
		
		cmp	r1, #15	@cmp j,15
		bge exit2
		
		add r3, r6, r1 @i + j
		
		cmp	r3, #10	@cmp i+j, 10
		bge l1
		
		add r5, r5, r6, lsl#1
		b exit
	l1:
		and r4, r6,r1
		add r5, r5, r4
			
	exit:

		add r1, r1, #1 @ j++
		b loop2

	exit2:

	add r6, r6, #1 @ i++
	b loop1
exit1:	
	
	
	
	
	
	
	
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
format: .asciz "The Answer is %d (Expect 300 if correct)\n"

