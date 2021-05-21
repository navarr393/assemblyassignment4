  
;********************************************************************************************
; Program name:          The king of assembly                                               *
; Programming Language:  x86 Assembly                                                       *
; Program Description:   This program asks a user to enter their name and salary they would *
;                        like to receive, then it moves on to ask if that person is chris   *
;                        or not, if they are not then it moves to calculate the resistance. *
;********************************************************************************************
; Author Information:                                                                       *
; Name:         David Navarro                                                               *
; Email:        navarrod253n@csu.fullerton.edu                                              *    
; Institution:  California State University - Fullerton                                     *
; Course:       CPSC 240-01 Assembly Language                                               *
;                                                                                           *
;********************************************************************************************
; Copyright (C) 2021 David Navarro                                                          *
; This program is free software: you can redistribute it and/or modify it under the terms   * 
; of the GNU General Public License version 3 as published by the Free Software Foundation. * 
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
; without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. * 
; See the GNU General Public License for more details. A copy of the GNU General Public     *
; License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;                                                                                           *
;********************************************************************************************
; Program information                                                                       *
;   Program name: The king of assembly                                                      *
;   Programming languages: One module in C, one module in X86, one bash file                *
;   Files in this program: main.c, interview.asm, r.sh                                      *   
;   					                                                                    *
;                                                                                           *
;********************************************************************************************
; This File                                                                                 *
;    Name:      interview.asm                                                               *
;    Purpose:   To accept a users input of name and salary, then it moves on to ask some    *
;               questions, based on what the user answers the program will jump to a        *
;               specific block of code and execute it.                                      *
;********************************************************************************************
extern printf
extern scanf
global interview                ; Makes function callable from other linked files.

section .data
    hello_message db "Hello. %s I am Ms Fenster. The interview will begin now.",10,0
    salary db "Wow! $%lf  that's a lot of cash. Who do you think you are, Chris Sawyer (y or n)?",0
    answers db "%s",0
    electricity db "Alright.  Now we will work on your electricity.",10,0
    enter_resitance1 db "Please enter the resistance of circuit #1 in ohms: ",0
    resistance1 db "%lf",0
    enter_resitance2 db "What is the resistance of circuit #2 in ohms: ",0
    resistance2 db "%lf",0
    display_resistance db "The total resistance is %lf Ohms.",10,0
    cs_mojor_prompt db "Were you a computer science major (y or n)?",0
    answer2 db "%s",0
    cs_major_exit db "Thank you.  Please follow the exit signs to the front desk.",10,0

section .bss

section .text

interview:

push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

;Registers rax, rip, and rsp are usually not backed up.
push qword 0

mov r15, rdi            ;save name 
movsd xmm15, xmm0         ;save salary

;Display hello message
push qword 0
mov rax, 0
mov rdi, hello_message  ;"Hello. %s I am Ms Fenster. The interview will begin now."
mov rsi, r15
call printf
pop rax

;Display salary message
push qword 0
mov rax, 1
mov rdi, salary          ;"Wow! $ %lf that's a lot of cash. Who do you think you are, Chris Sawyer (y or n)?"
movsd xmm0, xmm15
call printf
pop rax

;Begin the scanf block to input if the person is Chris or not.
push qword 0
mov rax, 0
mov rdi, answers
mov rsi, rsp
call scanf

;if answer == 'y' then move to i_am_chris_sawyer:
mov rax, 121 ;'y' value
cmp rax, [rsp]
pop rax
je i_am_chris_sawyer

;Display electricity message
push qword 0
mov rax, 0
mov rdi, electricity  ;"Alright.  Now we will work on your electricity."
call printf
pop rax

;Display enter resistance1 message
push qword 0
mov rax, 0
mov rdi, enter_resitance1     ;"Please enter the resistance of circuit #1 in ohms: "
call printf
pop rax

;Begin the scanf block to input the first resistance.
push qword 0
mov rax, 0
mov rdi, resistance1 
mov rsi, rsp
call scanf
movsd xmm14, xmm0   ;moves the first resistance to xmm14
pop rax

;Display enter resistance2 message
push qword 0
mov rax, 0
mov rdi, enter_resitance2   ;"What is the resistance of circuit #2 in ohms:"
call printf
pop rax

;Begin the scanf block to input the first resistance2.
push qword 0
mov rax, 0
mov rdi, resistance2
mov rsi, rsp
call scanf
movsd xmm13, xmm0   ;moves the resistance 2 to xmm13
pop rax

;calculate and display the total resistance
push qword 0
mov r8, 1 
cvtsi2sd xmm12, r8 
divsd xmm12, xmm14  ;This block makes 1/the first resistance and saves it in xmm12
pop rax

push qword 0
mov r9, 1 
cvtsi2sd xmm10, r9 
divsd xmm10, xmm13  ;This block makes 1/the second resistance and saves it in xmm10
pop rax

;This block adds the resistances
mov rax, 1
addsd xmm12, xmm10  

mov r10, 1
cvtsi2sd xmm9, r10
divsd xmm9, xmm12   ;This block divides 1/(1/r1 + 1/r2) to get the total resistance


;Display resistance
push qword 0
mov rax, 1
mov rdi, display_resistance ;"the total resistance is: "
movsd xmm0, xmm9
call printf
pop rax

;Ask the user if they were CS major or not
push qword 0
mov rax, 1
mov rdi, cs_mojor_prompt  ;"Were you a computer science major (y or n)?"
call printf
pop rax

;Begin the scanf block to input if the person is a CS major or not.
push qword 0
mov rax, 0
mov rdi, answer2  ;saves the users answer to rdi 
mov rsi, rsp
call scanf

;if answer == 'y' then move to i_am_cs_major
mov rax, 121 ;y value 
cmp [rsp], rax
pop rax
je i_am_cs_major

push qword 0
mov rax, 1
mov rdi, cs_major_exit  ;"Thank you.  Please follow the exit signs to the front desk."
call printf
mov rax, 0x4092C07AE147AE14 ;1200.12 in hex format
movq xmm5, rax ; stores it in xmm7 to return to the caller 
movsd xmm0, xmm5 ;1200.12 will return to the caller
pop rax
jmp conclusion

i_am_chris_sawyer:
;Display the exit message for the cs major
push qword 0
mov rax, 1
mov rdi, cs_major_exit  ;"Thank you.  Please follow the exit signs to the front desk."
call printf
mov rax, 0x412E848000000000 ;1 million in hex format
movq xmm6, rax ;saves one million to xmm6
movsd xmm0, xmm6 ;one million will be returned to the front desk
pop rax
jmp conclusion

i_am_cs_major:
;Display the exit message for the cs major
push qword 0
mov rax, 1
mov rdi, cs_major_exit  ;"Thank you.  Please follow the exit signs to the front desk."
call printf
mov rax, 0x40F57C0E147AE148 ;88000.88 in hex format
movq xmm7, rax ;88000.88 is saved in xmm7 
movsd xmm0, xmm7 ; 88000.88 will now be returned to the front desk
je conclusion
pop rax


conclusion:

pop rax                        ;Reverse the push near the beginning of this asm function.



;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret