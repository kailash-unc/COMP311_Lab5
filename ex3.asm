# Assembly starter file for Exercise 3

.data 0x0
  
  columnPrompt:	.asciiz "Enter the column to print a line at (must be an integer in the range 0-29):\n"
  newline:	.asciiz "\n"
  displayChar:  .asciiz "*"
  lineChar:  .asciiz "|"
  


.text 0x3000

main:
 	# Print the prompt for reading the column number
  addi	$v0, $0, 4  			  # system call 4 is for printing a string
  la 	$a0, columnPrompt 		  # address of columnPrompt is in $a0
  syscall           			  # print the string


  addi	$v0, $0, 5			  # system call 5 is for reading an integer
  syscall 				  # integer value read is in $v0
  add	$s0, $0, $v0		          # copy the column number into $s0
  
  li $8, 0				  # sets $8 as col amt
  li $9, 30				  # sets $9 as max col
  li $10, 0				  # sets $10 as row amt
  li $11, 10				  # sets $11 as max row
  
	# Creates the cols of the rows
loopcol:
  beq $8, $9, looprow			  # branches to looprow if we are done with this row
  beq $8, $s0, addline			  # branches to add line if we are at col
  j addchar				  # branches to code that input a '*'
	
	#Adds a '*' val to the row
addchar:
  addi	$v0, $0, 4  			  # system call 4 is for printing a string
  la 	$a0, displayChar 		  # address of displayChar is in $a0
  syscall 				  # print the string
  addi $8, $8, 1			  # increments col size
  j loopcol				  # branches to main code for the cols of the row

	#Adds a '|' to the chosen col
addline:
  addi	$v0, $0, 4  			  # system call 4 is for printing a string
  la 	$a0, lineChar 		 	  # address of lineChar is in $a0
  syscall				  # print the string
  addi $8, $8, 1		          # increments col size
  beq $8, $9, looprow
  j addchar 				  
 
 	#Adds new line/row and resets row vars
 looprow:
  addi $10, $10, 1			  # adds 1 to row count
  addi	$v0, $0, 4  			  # system call 4 is for printing a string
  la 	$a0, newline 		 	  # address of newline is in $a0
  syscall           			  # print the string
  
  beq $10, $11, exit			  # goes to the exit branch if we reached 10 rows
  
  li $8, 0				  # resets column counter
  j loopcol				  # creates all the columns in the next row
  
  

	# Exit from the program
exit:
  ori $v0, $0, 10       		  # system call code 10 for exit
  syscall               		  # exit the program
