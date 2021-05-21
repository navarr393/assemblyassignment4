;calculate and display the total resistance
push qword 0
mov r8, 1 
cvtsi2sd xmm12, r8 
divsd xmm12, xmm14  ;This block makes 1/the first resistance
pop rax

push qword 0
mov r9, 1 
cvtsi2sd xmm13, r9 
divsd xmm11, xmm13  ;This block makes 1/the second resistance
pop rax

mov rax, 1
addsd xmm12, xmm11  ;This block adds the resistances 

mov r11, 1 
cvtsi2sd xmm10, r11
divsd xmm11, xmm12
movsd xmm9, xmm11
