/*
;********************************************************************************************
; Program name:          The king of assembly.                                              *
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
;   					                                                                          *
;                                                                                           *
;********************************************************************************************
; This File                                                                                 *
;    Name:      main.c                                             		   	              *  
;    Purpose:   Prints the welcome message, asks the user for name and salary then it       *
;				    returns it to the asm file to determine the offer the user will get.        *
;                                                                                           *
;********************************************************************************************
*/

#include <stdio.h>
#include <stdint.h>

extern double interview(char name_[], double salary_); //name in asm label (ex. global start)

int main()
{
   char name[50];
   
   double salary;
   
 printf("Welcome to Software Analysis by Paramount Programmers, Inc.\n");
 printf("Please enter your first and last name and press enter: ");
 gets(name);
 printf("Thank you, ");
 puts(name);
 printf("Our records show that you applied for employment here\n");
 printf("with our agency a week ago.\n");
 printf("Please enter your expected annual salary when employed at Paramount: ");
 scanf("%lf", &salary);
 printf("Your interview with Ms Linda Fenster, Personnel Manager, will begin shortly.\n");

 double offer = interview(name, salary);

 if (offer == 88000.88) {
   printf("Hello %s I am the receptionist.\n", name);
   printf("This envelope contains your job offer with starting salary of %lf Please\n",offer);
   printf("check back on Monday morning at 8am.\n");
   printf("Bye\n");
 }
 else if (offer == 1200.12) {
    printf("Hello %s I am the receptionist.\n", name);
    printf("We have an opening for you in the company cafeteria for $%lf annually.\n", offer);
    printf("Take your time to let us know your decision.\n");
    printf("Bye\n");
 }
 else if (offer == 1000000.00) {
    printf("Hello Mr Sawyer.  I am the receptionist.\n");
    printf("This envelope has your job offer starting at 1 million annual.  Please start any\n");
    printf("time you like.  In the middle time our CTO wishes to have dinner with you.\n");
    printf("Have a very nice evening Mr Sawyer.\n");
 }
 return 0;
}