@ E/16/069
@ ARM Assembly proram 
@ to reverses  specified number of input strings 
@

    .text   @ instruction memory

    .global main

main : 

        @ allocate space for lr and first input
        sub sp, sp, #8 

        @ store lr to the stack
        str lr, [sp, #4]

        @ printf for string :"Enter the number of strings"
        ldr r0, = formatN
        bl printf

        @ str 0 in sp : if integer input was a string then to skip the code
        mov r12, #0
        str r12, [sp, #0]

        @ scanf for int
        ldr r0, = format4
        mov r1, sp
        bl scanf            

        ldr r4, [sp]        @ r4 = number of strings

        cmp r4, #0
        beq exitM

        cmp r4, #0
        blt exitInvalid     @ invalid input number

        mov r5, #0          @ count the number of inputs

    loopM: 
        cmp r5, r4          @ checking number of inputs
        bge exitM           

        @ allocate space for 100  chars : scanf
        sub sp, sp, #100

        @ printf for string :"Enter the input string %d: \n"
        ldr r0, = format1
        mov r1, r5
        bl printf

        @ str 0 in sp
        mov r12, #0
        str r12, [sp, #0]

        @ scanf for string 
        ldr r0, = format2
        mov r1, sp
        bl scanf                @ scanf("%s", sp)

        @ stringLength function call
        mov	r0, sp
        bl	stringLen

        mov r6, r0              @ r6 = length of input
        mov r7, sp              @ r7 = sp (input string address)

        @ check for lenghth 0 inputs
        cmp r6, #0
        beq end1

        
        @ allocate space for  : reverse string
        sub sp, sp, #4          @ str 0 between input string and output
        mov r8, #0
        str r8, [sp, #0]
        sub sp, sp, r6          @ space same as the input string length
        str r8, [sp, #0]
        
        @ strRev function call
        mov r2, r6              @ length of the input string
        mov r0, sp              @ reverse
        mov r1, r7              @ original
        bl stringRev

        @ print answer : "Output String %d is :\n%s\n"
        mov r1, r5
        mov r2, sp
        ldr r0, = format3
        bl printf

    
        @ clear stack
        add sp, sp, #104
        add sp, sp, r6
        
        @ increase counter
        add r5, r5, #1          
        b loopM
 

    end1:  @ length 0 inputs
        bl getchar

        @ print a new line 
        ldr r0, = format5
        mov r1, r5
        bl printf

        add sp, sp, #100      
        add r5, r5, #1          @ increase counter
        b loopM


    exitM:
        @ stack handling and return
        mov r0, #0              @ return 0
        ldr lr, [sp, #4]
        add sp, sp, #8
        mov pc, lr

    exitInvalid:
        ldr r0, = formatI
        bl printf
        b exitM 

    @ string reverse function
        @ r0 - pointer to reversed char array: x[]
        @ r1 - pointer to original char array: y[]
        @ r2 - length of the string	     
stringRev:
        sub sp, sp, #16
        str r4, [sp, #0]
        str r5, [sp, #4]
        str r6, [sp, #8]
        str	lr, [sp, #12]

        mov r4, #0          @ i = 0
        mov r5, r2          @ r5 = length of string
    
    loopR:
        cmp r4, r2
        bge exit1           @ exit if i >= length

        sub r5, r5, #1      @ length-1 -i

        add r6, r5, r1      @ address of y[length-1-i]
        ldrb r3, [r6, #0]   @ r3 = y[length-1-i]
        
        add r12, r4, r0     @ address of x[i]
        strb r3, [r12, #0]  @ x[i] = y[length-1-i]

        add r4, r4, #1      @ i++
        b loopR

    exit1:

        ldr r4, [sp, #0]
        ldr r5, [sp, #4]
        ldr r6, [sp, #8]
        ldr lr, [sp, #12]
        add sp, sp, #16
        mov pc, lr


    @ string length function
        @ r0 - pointer to string  
stringLen:
        sub	sp, sp, #4
        str	lr, [sp, #0]

        mov	r1, #0	        @ length counter

    loop:
        ldrb r2, [r0, #0]
        cmp	r2, #0
        beq	endLoop

        add	r1, r1, #1	    @ count length
        add	r0, r0, #1	    @ move to the next element in the char array
        b	loop

    endLoop:
        mov	r0, r1		    @ to return the length
        ldr	lr, [sp, #0]
        add	sp, sp, #4
        mov	pc, lr

    .data @ data memory

formatN: .asciz "Enter the number of strings : \n"
format1: .asciz "Enter the input string %d : \n"
format2: .asciz "%[^\n]%*c"
format3: .asciz "Output string %d is :\n%s\n"
format4: .asciz "%d%*c"
formatI: .asciz "Invalid number\n"
format5: .asciz "Output string %d is :\n\n"
