
#David Navarro
#CPSC240-01 
#Bash file to compile and link all files from "The king of assembly program"


echo "Bash script has started"

rm *.out    # Remove other helper files.
rm *.o
rm *.lis

echo "Assembling interview.asm"

    # Assemble x86 module.
nasm -f elf64 -l interview.lis -o interview.o interview.asm

echo "Compiling main.c"
gcc -c -Wall -m64 -no-pie -o main.o main.c -std=c11

echo "Linking all the files"
    # Link object files.
gcc -m64 -no-pie -o executable.out -std=c11 interview.o main.o 

echo "Running the program"
./executable.out

echo "The bash script file will terminate"