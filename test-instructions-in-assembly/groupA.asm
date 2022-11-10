beq x1, x1, firstLabel

add x31, x5, x1

firstLabel:

sub x31, x5, x1

bne x1, x0, secondLabel

add x30, x5, x1

secondLabel:

sub x30, x5, x1

blt x0, x1 thirdLabel

add x29, x5, x1

thirdLabel:

sub x29, x5, x1

bge x1, x0, fourthLabel

add x28, x5, x1

fourthLabel:

sub x28, x5, x1

bltu x0, x1, fifthLabel

add x27, x5, x1

fifthLabel:

sub x27, x5, x1

bgeu x1, x0, sixthLabel

add x26, x5, x1

sixthLabel:

sub x26, x5, x1
