# Starter code for reversing the case of a 30 character input.
# Put in comments your name and date please.  You will be
# revising this code.
#
# Dianne Foreback 
# Sept 2016
# 
# This code displays the authors name (you must change
# outpAuth to display YourFirstName and YourLastName".
#
# The code then prompts the user for input
# stores the user input into memory "varStr"
# then displays the users input that is stored in"varStr" 
#
# You will need to add code to reverse the case of the characters
# in varStr.  You must use a loop to do this.  Another buffer
# varStrRev is created to hold the reversed case string
# and print it.
#
# If using MARS, make certain in "Settings" to check
# "popup dialog for input syscalls 5,6,7,8,12"
#
            .data      # data segment
	    .align 2   # align the next string on a word boundary
outpAuth:   .asciiz  "This is John Luan presenting revCase.\n"
outpPrompt: .asciiz  "Please enter 30 characters (upper/lower case mixed):\n"
	    .align 2   #align next prompt on a word boundary
outpStr:    .asciiz  "You entered the string: "
            .align 2   # align users input on a word boundary
varStr:     .space 32  # will hold the user's input string thestring of 20 bytes 
                       # last two chars are \n\0  (a new line and null char)
                       # If user enters 31 characters then clicks "enter" or hits the
                       # enter key, the \n will not be inserted into the 21st element
                       # (the actual users character is placed in 31st element).  the 
                       # 32nd element will hold the \0 character.
                       # .byte 32 will also work instead of .space 32
            .align 2   # align next prompt on word boundary
outpStrRev: .asciiz   "Your string in reverse case is: "
            .align 2   # align the output on word boundary
varStrRev:  .space 32  # reserve 32 characters for the reverse case string
###############################################################
            .text      # code section begins
            .globl	main 
main:  
###############################################################
# system call to display the author of this code
	 la $a0,outpAuth	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	

###############################################################
# system call to prompt user for input
	 la $a0,outpPrompt	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	
###############################################################
# system call to store user input into string thestring
	li $v0,8		# system call 8 for read string needs its call number 8 in $v0
        			# get return values
	la $a0,varStr    	# put the address of thestring buffer in $a0
	li $a1,32 	        # maximum length of string to load, null char always at end
				# but note, the \n is also included providing total len < 22
        syscall
        #move $t0,$v0		# save string to address in $t0; i.e. into "thestring"
################################################################
# system call to display "You entered the string: "
	 la $a0,outpStr 	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall  	
################################################################
# system call to display user input that is saved in "varStr" buffer
	 la $a0,varStr  	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	
################################################################
#  YOUR CODE TO REVERSE THE STRING GOES HERE
	li $t3, 0		#loop counter initialized
	la $t0, varStr		#initialize pointer to beginning of the string
	la $t2, varStrRev	#initialize pointer to beginning of output string
While:	beq $t3, 32, Exit
	lbu $t1, 0($t0)
	blt $t1, 95, Uppercase
	j Lowercase
While2:
	sb $t1, 0($t2)
	addi $t0, $t0, 1
	addi $t2, $t2, 1
	addi $t3, $t3, 1
	j While
Uppercase:
	addi $t1, $t1, 32
	j While2
Lowercase:
	subi $t1, $t1, 32
	j While2

#
################################################################
# system call to display "Your string in reverse case is: "
Exit:
	 la $a0,outpStrRev 	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall  	
# system call to display the user input that is in reverse case saved in the varRevStr buffer
	 la $a0,varStrRev  	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	
# Exit gracefully
         li   $v0, 10       # system call for exit
         syscall            # close file
###############################################################
