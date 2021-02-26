loadi 0 0x03
loadi 1 0x02
loadi 2 0x02
loadi 3 0x00

beq 0x02 0 1  // will not take the branch
beq 0x01 1 2  // will take the branch

add 4 0 1   // r4 = 5
add 5 4 2   // r5 = 9

j 0xFE
