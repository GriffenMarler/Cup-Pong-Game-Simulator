; Final Project
; Author: Griffen Marler and Iain Black
; Date: 27 November 2018

INCLUDE Irvine32.inc


.data
colRed DWORD (red * 16)               
CupArray BYTE 20 DUP ("    ", 0)
WelcomeMSG BYTE "Welcome to the beer pong game simulator! Grab a friend and play!", 0
AimPrompt1 BYTE "Player one, pick a row to aim for (1, 2, 3, or 4)", 0
AimPrompt2 BYTE "Player two, pick a row to aim for (1, 2, 3, or 4)", 0
GoAgain BYTE 0
GoAgainPrompt BYTE "You hit multiple cups on the same turn! You get to shoot again!", 0
HitCupDisplay BYTE "You hit a cup!", 0
MissCupDisplay BYTE "You missed!", 0
WinMsg1 BYTE "Player 1 wins! Congrats!", 0
WinMsg2 BYTE "Player 2 wins! Congrats!", 0
WinCount1 BYTE 0
WinCount2 BYTE 0
Row4Label BYTE "(4)", 0
Row3Label BYTE "(3)", 0
Row2Label BYTE "(2)", 0
Row1Label BYTE "(1)", 0
TurnCount BYTE 3                               ; Used to track player turns
PROWVAL DWORD ?                                ; Used to store which row the player would like to shoot at
FourthDl1 BYTE ?                               ; Dh and Dl variables for each row and player side.
FourthDh1 BYTE ?
FourthDl2 BYTE ?
FourthDh2 BYTE ?
ThirdDl1 BYTE ?
ThirdDh1 BYTE ?
ThirdDl2 BYTE ?
ThirdDh2 BYTE ?
SecondDl1 BYTE ?
SecondDh1 BYTE ?
SecondDl2 BYTE ?
SecondDh2 BYTE ?
FirstDl1 BYTE ?
FirstDh1 BYTE ?
FirstDh2 BYTE ?
FirstDl2 BYTE ? 


.code
main PROC                                       ;Display Welcome Message upon starting Program
    call Randomize
    mov eax, white
    call SetTextColor
    mov dh, 1
    mov dl, 38
    call gotoxy
    mov edx, OFFSET WelcomeMSG
    call WriteString
    call OutputCups                                   ; Call functions to set game in motion
    call Player1Throw


main ENDP

OutputCups PROC
    mov eax, colRed
    call SetTextColor

    mov FourthDh1, 1                                    ;Create variables to hold cursor locations based on row
    mov FourthDl1, 1

    mov FourthDh2, 24
    mov FourthDl2, 1

    mov ThirdDh1, 4
    mov ThirdDl1, 4

    mov ThirdDh2, 21
    mov ThirdDl2, 4

    mov ecx, 4                                          ;Set loop counter
    mov esi, OFFSET CupArray
    add esi, 5*9                                        ;Set starting positions within cupArray for each player
    mov edi, OFFSET CupArray
    add edi, 5*19

FourthRow:  
    mov dh, FourthDh1                                   ;Set cursor
    mov dl, FourthDl1
    call gotoxy

    mov edx, esi                                        ; Passing in OFFSET str1 (Stored in ebx from main)
    call WriteString
    add FourthDh1, 1                                    ; Double up the cup size and outputs cup 
    mov dh, FourthDh1
    mov dl, FourthDl1
    call gotoxy
    mov edx, esi  
    call WriteString                                    

    add FourthDl1, 6                                    ; Sets spacing between the cups
    mov FourthDh1, 1                                    ; Reset row value 

    mov dh, FourthDh2                                   ;Repeats output process for second player's cups
    mov dl, FourthDl2
    call gotoxy
    mov edx, edi
    call WriteString
    add FourthDh2, 1
    mov dh, FourthDh2
    mov dl, FourthDl2
    call gotoxy
    mov edx, edi
    call WriteString
    add FourthDl2, 6
    mov FourthDh2, 24

    sub esi, 5                                          ;Decrements member of cupArray that is beinv accessed
    sub edi, 5
    dec ecx
    jne FourthRow

    mov eax, green                                      ; Set text color to white
    call SetTextColor
    mov dh, 1                                           ; Position cursor to right of row
    mov dl, 24
    call gotoxy
    mov edx, OFFSET Row4Label                   
    call WriteString                                    ; Output number label of row

    mov eax, white                                      ; Set text color to white
    call SetTextColor
    mov dh, 24                                          ; Position cursor to right of row
    mov dl, 24
    call gotoxy
    mov edx, OFFSET Row4Label                   
    call WriteString                                     ; Output number label of row

    mov eax, colRed                                     ; Reset text color back to red
    call SetTextColor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    mov ecx, 3
    mov esi, OFFSET CupArray
    add esi, 5*5                 ; Accessing 5th cup
    mov edi, OFFSET CupArray
    add edi, 5*15                ; Accessing 15th cup
ThirdRow:
    mov dh, ThirdDh1
    mov dl, ThirdDl1
    call gotoxy
    mov edx, esi
    call WriteString
    add ThirdDh1, 1             ; Double up cup size
    mov dh, ThirdDh1
    mov dl, ThirdDl1
    call gotoxy
    mov edx, esi
    call WriteString

    add ThirdDl1, 6         ; Set spacing between the cups
    mov Thirddh1, 4         ; Reset Row value


    mov dh, ThirdDh2
    mov dl, ThirdDl2
    call gotoxy
    mov edx, edi
    call WriteString
    add ThirdDh2, 1             ; Double up cup size
    mov dh, ThirdDh2
    mov dl, ThirdDl2
    call gotoxy
    mov edx, edi
    call WriteString

    add ThirdDl2, 6         ; Set spacing between the cups
    mov ThirdDh2, 21         ; Reset Row value
    
    sub esi, 5              ; Decrement down one cup on one side
    sub edi, 5              ; Decrement down one cup on one side
    dec ecx
    jne ThirdRow

    mov eax, green                              ; Set text color to white
    call SetTextColor
    mov dh, 4                                  ; Position cursor to right of row
    mov dl, 24
    call gotoxy
    mov edx, OFFSET Row3Label                   
    call WriteString                            ; Output number label of row

    mov eax, white                              ; Set text color to white
    call SetTextColor
    mov dh, 21                                  ; Position cursor to right of row
    mov dl, 24
    call gotoxy
    mov edx, OFFSET Row3Label                   
    call WriteString                            ; Output number label of row
    mov eax, colRed                             ; Reset text color back to red
    call SetTextColor

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    mov SecondDl1, 7 
    mov SecondDh1, 7
    mov SecondDl2, 7
    mov SecondDh2, 18
    mov ecx, 2 
    mov esi, OFFSET CupArray
    add esi, 5*2                 ; Accessing #2 cup
    mov edi, OFFSET CupArray
    add edi, 5*12                ; Accessing #12 cup
SecondRow:
    mov dh, SecondDh1
    mov dl, SecondDl1
    call gotoxy
    mov edx, esi
    call WriteString
    add SecondDh1, 1             ; Double up cup size
    mov dh, SecondDh1
    mov dl, SecondDl1
    call gotoxy
    mov edx, esi
    call WriteString

    add SecondDl1, 6         ; Set spacing between the cups
    mov SecondDh1, 7         ; Reset Row value


    mov dh, SecondDh2
    mov dl, SecondDl2
    call gotoxy
    mov edx, edi
    call WriteString
    add SecondDh2, 1             ; Double up cup size
    mov dh, SecondDh2
    mov dl, SecondDl2
    call gotoxy
    mov edx, edi
    call WriteString

    add SecondDl2, 6         ; Set spacing between the cups
    mov SecondDh2, 18         ; Reset Row value
    
    sub esi, 5              ; Decrement down one cup on one side
    sub edi, 5              ; Decrement down one cup on one side
    dec ecx
    jne SecondRow

    mov eax, white                              ; Set text color to green
    call SetTextColor
    mov dh, 18                                 ; Position cursor to right of row
    mov dl, 24
    call gotoxy
    mov edx, OFFSET Row2Label                   
    call WriteString                            ; Output number label of row

    mov eax, green                              ; Set text color to white
    call SetTextColor
    mov dh, 7                                  ; Position cursor to right of row
    mov dl, 24
    call gotoxy
    mov edx, OFFSET Row2Label                   
    call WriteString                            ; Output number label of row

    mov eax, colRed                             ; Reset text color back to red
    call SetTextColor

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    mov FirstDl1, 10                            ; Initial dh and dl values for cups that show up on top of screen
    mov FirstDh1, 10

    mov FirstDl2, 10                            ; Initial dh and dl values for cups that show on bottom of screen
    mov FirstDh2, 15

    mov esi, OFFSET CupArray
    add esi, 5 * 0          ; Accessing Cup #0

    mov edi, OFFSET CupArray
    add edi, 5 * 10         ; Accessing Cup #10
FirstRow:
    mov dh, FirstDh1
    mov dl, FirstDl1
    call gotoxy
    mov edx, esi
    call WriteString
    add FirstDh1, 1
    mov dh, FirstDh1
    mov dl, FirstDl1
    call gotoxy
    mov edx, esi
    call WriteString

    mov dh, FirstDh2
    mov dl, FirstDl2
    call gotoxy
    mov edx, edi
    call WriteString
    add FirstDh2, 1
    mov dh, FirstDh2
    mov dl, FirstDl2
    call gotoxy
    mov edx, edi
    call WriteString

    mov eax, green                              ; Set text color to green
    call SetTextColor
    mov dh, 10                                 ; Position cursor to right of row
    mov dl, 24
    call gotoxy
    mov edx, OFFSET Row1Label                   
    call WriteString                            ; Output number label of row
    mov eax, white                              ; Set text color to white
    call SetTextColor
    mov dh, 15                                 ; Position cursor to right of row
    mov dl, 24
    call gotoxy
    mov edx, OFFSET Row1Label                   
    call WriteString                            ; Output number label of row

    mov eax, colRed                             ; Reset text color back to red
    call SetTextColor
    ret                                         ; Return back to the next instruction in main
OutputCups ENDP


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Player One Turn
Player1Throw PROC   
    cmp WinCount1, 9
    ja EndGame

    .IF GoAgain == 2                               ; Tracks if the user hits two cups on the same turn 
        mov GoAgain, 0                             ; resets counter for number of hit cups
        mov TurnCount, 3                           ; sets number of times a player can throw (2)
        call Clrscr
        call OutputCups
        mov eax, white
        call SetTextColor
        mov dh, 6
        mov dl, 38
        call gotoxy
        mov edx, OFFSET GoAgainPrompt              ; Displays text prompting user to throw again if they hit 2 cups in the same turn
        call WriteString
    .ENDIF

    dec TurnCount                                 ; Player uses one of their turns
    .IF TurnCount == 0                            ; If counter is 0, player is out of turns
        mov GoAgain, 0                              ; resets counter for number of hit cups
        mov TurnCount, 3                                             
        jmp Player2Throw
    .ENDIF

    mov eax, white                                  ; displays prompt for user to choose row to aim for
    call SetTextColor
    mov dh, 3
    mov dl, 38
    call gotoxy
    mov edx, OFFSET AimPrompt1                      
    call WriteString

    mov dh, 5                                       ; Reads in row choice from user
    mov dl, 38
    call gotoxy
    call ReadInt
    mov PROWVAL, eax
                                               

; Front Row 
Front:
    cmp PROWVAL, 1                                 ; If user chooses to aim for this row, steps through row loop
    ja Second                                       ; If number is greater than one, jumps to next row loop
    mov eax, 2                                      ; Calls random number to create odds of hitting a cup in this row
    call RandomRange

    .IF eax > 0                                     ; If random numnber is greater than 0, they missed the cup
        call Clrscr
        call OutputCups
        mov eax, white
        call SetTextColor
        mov dh, 7
        mov dl, 38
        call gotoxy
        mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
        call WriteString
        jmp Player1Throw                            ; Jumps to next shot (beginning of outer loop)

    .ELSE                                           ; If random number is 0, cup has been hit

    .IF CupArray[5 * 10] == 0
        call Clrscr
        call OutputCups   
        mov eax, white
        call SetTextColor
        mov dh, 7
        mov dl, 38
        call gotoxy
        mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
        call WriteString
        jmp Player1Throw                            ; Jumps to next shot (beginning of outer loop)   
    .ENDIF
    
    ; Make Cup
    mov CupArray[5 * 10], 0                     ; Changes value within cup array to not display cup
    inc GoAgain                                 ; Increments value of GoAgain counter, if counter reaches 2 player gets to go again
    call Clrscr
    call OutputCups
    mov dh, 7
    mov dl, 38
    call gotoxy
    mov eax, white
    call SetTextColor
    mov edx, OFFSET HitCupDisplay               ; Outputs text to inform user that they have hit a cup
    call WriteString
    inc WinCount1
    jmp Player1Throw                            ; jumps to top of outer loop
    .ENDIF


; SECOND ROW
Second:
    cmp PROWVAL, 2
    ja Third
    mov eax, 3
    call RandomRange
    .IF eax == 1                                     ; Repeats process of hitting a cup if random number equals 1
        .IF CupArray[5 * 11] == 0                    ; Checks if value of cup they hit is 0, if so the cup isnt there and it is actually a miss
            call Clrscr
            call OutputCups
            mov eax, white
            call SetTextColor
            mov dh, 7
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player1Throw                            ; Jumps to next shot (beginning of outer loop)   
        .ENDIF
        
        mov CupArray[5 * 11], 0
        inc GoAgain
        inc WinCount1
        call Clrscr
        call OutputCups
        mov eax, white
        call SetTextColor
        mov dh, 7
        mov dl, 38
        call gotoxy
        mov edx, OFFSET HitCupDisplay
        call WriteString
        jmp Player1Throw
    .ELSEIF eax == 0                                  ; Repeats process of hitting a cup if random number equals 0
        .IF CupArray[5 * 12] == 0                    ; Checks if value of cup they hit is 0, if so the cup isnt there and it is actually a miss
            call Clrscr
            call OutputCups
            mov eax, white
            call SetTextColor
            mov dh, 7
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player1Throw                            ; Jumps to next shot (beginning of outer loop)   
    .ENDIF
    ; Make Cup
    mov CupArray[5 * 12], 0
    inc GoAgain
    call Clrscr
    call OutputCups
    mov eax, white
    call SetTextColor
    inc WinCount1
    mov dh, 7
    mov dl, 38
    call gotoxy
    mov edx, OFFSET HitCupDisplay
    call WriteString
    jmp Player1Throw
    .ELSE                                             ; Repeats process of missing a cup if random number is not 1 or 0
    call Clrscr
    call OutputCups 
    mov eax, white
    call SetTextColor   
    mov dh, 7
    mov dl, 38
    call gotoxy
    mov edx, OFFSET MissCupDisplay
    call WriteString
    jmp Player1Throw
.ENDIF


; THIRD ROW
Third:
    cmp PROWVAL, 3
    ja Fourth
    mov eax, 4
    call RandomRange
    .IF eax == 0                                       ;Repeats process of hitting a cup if random number equals 0
        .IF CupArray[5 * 15] == 0
            call Clrscr
            call OutputCups
            mov eax, white
            call SetTextColor
            mov dh, 7
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player1Throw                            ; Jumps to next shot (beginning of outer loop)   
        .ENDIF
    mov CupArray[5 * 15], 0
    inc GoAgain
    inc WinCount1
    call Clrscr
    call OutputCups
    mov eax, white
    call SetTextColor
    mov dh, 7
    mov dl, 38
    call gotoxy
    mov edx, OFFSET HitCupDisplay
    call WriteString
    jmp Player1Throw
    .ELSEIF eax == 1                                   ;Repeats process of hitting a cup if random number equals 1
        .IF CupArray[5 * 14] == 0
            call Clrscr
            call OutputCups
            mov eax, white
            call SetTextColor
            mov dh, 7
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player1Throw                            ; Jumps to next shot (beginning of outer loop)           
        .ENDIF
    mov CupArray[5 * 14], 0
    inc GoAgain
    inc WinCount1
    call Clrscr
    call OutputCups
    mov eax, white
    call SetTextColor
    mov dh, 7
    mov dl, 38
    call gotoxy
    mov edx, OFFSET HitCupDisplay
    call WriteString
    jmp Player1Throw
    .ELSEIF eax == 2                                   ;Repeats process of hitting a cup if random number equals 2
        .IF CupArray[5 * 13] == 0
            call Clrscr
            call OutputCups
            mov eax, white
            call SetTextColor
            mov dh, 7
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player1Throw                            ; Jumps to next shot (beginning of outer loop)           
        .ENDIF
    mov CupArray[5 * 13], 0
    inc GoAgain
    inc WinCount1
    call Clrscr
    call OutputCups
    mov eax, white
    call SetTextColor
    mov dh, 7
    mov dl, 38
    call gotoxy
    mov edx, OFFSET HitCupDisplay
    call WriteString
    jmp Player1Throw
    .ELSE                                               ; Repeats process of missing a cup if random number is not 0, 1, or 2
        call Clrscr
        call OutputCups
        mov eax, white
        call SetTextColor
        mov dh, 7
        mov dl, 38
        call gotoxy
        mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
        call WriteString
        jmp Player1Throw                            ; Jumps to next shot (beginning of outer loop)           
    .ENDIF


Fourth:
    mov eax, 5
    call RandomRange
    .IF eax == 0                                        ;Repeats process of hitting a cup if random number equals 0
        .IF CupArray[5 * 19] == 0
            call Clrscr
            call OutputCups
            mov eax, white
            call SetTextColor
            mov dh, 7
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player1Throw                            ; Jumps to next shot (beginning of outer loop)   
        .ENDIF
    mov CupArray[5*19], 0
    inc GoAgain
    inc WinCount1
    call Clrscr
    call OutputCups
    mov eax, white
    call SetTextColor
    mov dh, 7
    mov dl, 38
    call gotoxy
    mov edx, OFFSET HitCupDisplay
    call WriteString
    jmp Player1Throw
    .ELSEIF eax == 1                                    ;Repeats process of hitting a cup if random number equals 1
        .IF CupArray[5 * 18] == 0
            call Clrscr
            call OutputCups
            mov eax, white
            call SetTextColor
            mov dh, 7
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player1Throw                            ; Jumps to next shot (beginning of outer loop)   
        .ENDIF
    mov CupArray[5*18], 0
    inc GoAgain
    inc WinCount1
    call Clrscr
    call OutputCups
    mov eax, white
    call SetTextColor
    mov dh, 7
    mov dl, 38
    call gotoxy
    mov edx, OFFSET HitCupDisplay
    call WriteString
    jmp Player1Throw
    .ELSEIF eax == 2                                    ;Repeats process of hitting a cup if random number equals 2
        .IF CupArray[5 * 17] == 0
            call Clrscr
            call OutputCups
            mov eax, white
            call SetTextColor
            mov dh, 7
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player1Throw                            ; Jumps to next shot (beginning of outer loop)   
        .ENDIF
    mov CupArray[5*17], 0
    inc GoAgain
    inc WinCount1
    call Clrscr
    call OutputCups
    mov eax, white
    call SetTextColor
    mov dh, 7
    mov dl, 38
    call gotoxy
    mov edx, OFFSET HitCupDisplay
    call WriteString
    jmp Player1Throw
    .ELSEIF eax == 3                                    ;Repeats process of hitting a cup if random number equals 3
        .IF CupArray[5 * 16] == 0
            call Clrscr
            call OutputCups
            mov eax, white
            call SetTextColor
            mov dh, 7
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player1Throw                            ; Jumps to next shot (beginning of outer loop)   
        .ENDIF
    mov CupArray[5*16], 0
    inc GoAgain
    inc WinCount1
    call Clrscr
    call OutputCups
    mov eax, white
    call SetTextColor
    mov dh, 7
    mov dl, 38
    call gotoxy
    mov edx, OFFSET HitCupDisplay
    call WriteString
    jmp Player1Throw
.ELSE                                               ; Repeats process of missing a cup if random number is not 0, 1, 2, or 3
        call Clrscr
        call OutputCups
        mov eax, white
        call SetTextColor
        mov dh, 7
        mov dl, 38
        call gotoxy
        mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
        call WriteString
        jmp Player1Throw                            ; Jumps to next shot (beginning of outer loop)   
.ENDIF


Player1Throw ENDP



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Player2Throw PROC

    cmp WinCount2, 9
    ja EndGame

    .IF GoAgain == 2                               ; Tracks if the user hits two cups on the same turn 
        mov GoAgain, 0                             ; resets counter for number of hit cups
        mov TurnCount, 3                         ; sets number of times a player can throw (2)
        call Clrscr
        call OutputCups
        mov eax, green
        call SetTextColor
        mov dh, 22
        mov dl, 38
        call gotoxy
        mov edx, OFFSET GoAgainPrompt              ; Displays text prompting user to throw again if they hit 2 cups in the same turn
        call WriteString
    .ENDIF

    dec TurnCount                                 ; Player uses one of their turns
    .IF TurnCount == 0                            ; If counter is 0, player is out of turns
        mov GoAgain, 0                              ; resets counter for number of hit cups
        mov TurnCount, 3                                             
        jmp Player1Throw
    .ENDIF

    mov eax, green
    call SetTextColor
    mov dh, 26
    mov dl, 38
    call gotoxy
    mov edx, OFFSET AimPrompt2
    call WriteString

    mov dh, 28                                       ; Reads in row choice from user
    mov dl, 38
    call gotoxy
    call ReadInt
    mov PROWVAL, eax
                                                ; Moves the user input place 2 cursor spots over


; Front Row 
Front:
    cmp PROWVAL, 1                                 ; If user chooses to aim for this row, steps through row loop
    ja Second                                       ; If number is greater than one, jumps to next row loop
    mov eax, 3                                      ; Calls random number to create odds of hitting a cup in this row
    call RandomRange

    .IF eax > 0                                     ; If random numnber is greater than 0, they missed the cup
        call Clrscr
        call OutputCups
        mov eax, green
        call SetTextColor
        mov dh, 23
        mov dl, 38
        call gotoxy
        mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
        call WriteString
        jmp Player2Throw                            ; Jumps to next shot (beginning of outer loop)

    .ELSE                                           ; If random number is 0, cup has been hit
        .IF CupArray[5 * 0] == 0

            call Clrscr
            call OutputCups   
            mov eax, green
            call SetTextColor
            mov dh, 23
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player2Throw                            ; Jumps to next shot (beginning of outer loop)   
        .ENDIF

        
        mov CupArray[5 * 0], 0                     ; Changes value within cup array to not display cup
        inc GoAgain                                 ; Increments value of GoAgain counter, if counter reaches 2 player gets to go again
        call Clrscr
        call OutputCups
        mov dh, 23
        mov dl, 38
        call gotoxy
        mov eax, green
        call SetTextColor
        mov edx, OFFSET HitCupDisplay               ; Outputs text to inform user that they have hit a cup
        call WriteString
        inc WinCount2
        jmp Player2Throw                            ; jumps to top of outer loop
    .ENDIF


; SECOND ROW
Second:
    cmp PROWVAL, 2
    ja Third
    mov eax, 3
    call RandomRange
    .IF eax == 1                                     ; Repeats process of hitting a cup if random number equals 1
        .IF CupArray[5 * 1] == 0                    ; Checks if value of cup they hit is 0, if so the cup isnt there and it is actually a miss
            call Clrscr
            call OutputCups
            mov eax, green
            call SetTextColor
            mov dh, 23
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player2Throw                            ; Jumps to next shot (beginning of outer loop)   
        .ENDIF
        mov CupArray[5 * 1], 0
        inc GoAgain
        inc WinCount2
        call Clrscr
        call OutputCups
        mov eax, green
        call SetTextColor
        mov dh, 23
        mov dl, 38
        call gotoxy
        mov edx, OFFSET HitCupDisplay
        call WriteString
        jmp Player2Throw
    .ELSEIF eax == 0                                  ; Repeats process of hitting a cup if random number equals 0
        .IF CupArray[5 * 2] == 0                    ; Checks if value of cup they hit is 0, if so the cup isnt there and it is actually a miss
            call Clrscr
            call OutputCups
            mov eax, green
            call SetTextColor
            mov dh, 23
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player2Throw                            ; Jumps to next shot (beginning of outer loop)   
        .ENDIF
        mov CupArray[5 * 2], 0
        inc GoAgain
        call Clrscr
        call OutputCups
        mov eax, green
        call SetTextColor
        inc WinCount2
        mov dh, 23
        mov dl, 38
        call gotoxy
        mov edx, OFFSET HitCupDisplay
        call WriteString
        jmp Player2Throw
    .ELSE                                             ; Repeats process of missing a cup if random number is not 1 or 0
        call Clrscr
        call OutputCups 
        mov eax, green
        call SetTextColor   
        mov dh, 23
        mov dl, 38
        call gotoxy
        mov edx, OFFSET MissCupDisplay
        call WriteString
        jmp Player2Throw
    .ENDIF


; THIRD ROW
Third:
    cmp PROWVAL, 3
    ja Fourth
    mov eax, 4
    call RandomRange
    .IF eax == 0                                       ;Repeats process of hitting a cup if random number equals 0
        .IF CupArray[5 * 3] == 0
            call Clrscr
            call OutputCups
            mov eax, green
            call SetTextColor
            mov dh, 23
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player2Throw                            ; Jumps to next shot (beginning of outer loop)   
        .ENDIF
        mov CupArray[5 * 3], 0
        inc GoAgain
        inc WinCount2
        call Clrscr
        call OutputCups
        mov eax, green
        call SetTextColor
        mov dh, 23
        mov dl, 38
        call gotoxy
        mov edx, OFFSET HitCupDisplay
        call WriteString
        jmp Player2Throw
    .ELSEIF eax == 1                                   ;Repeats process of hitting a cup if random number equals 1
        .IF CupArray[5 * 4] == 0
            call Clrscr
            call OutputCups
            mov eax, green
            call SetTextColor
            mov dh, 23
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player2Throw                            ; Jumps to next shot (beginning of outer loop)           
        .ENDIF
        mov CupArray[5 * 4], 0
        inc GoAgain
        inc WinCount2
        call Clrscr
        call OutputCups
        mov eax, green
        call SetTextColor
        mov dh, 23
        mov dl, 38
        call gotoxy
        mov edx, OFFSET HitCupDisplay
        call WriteString
        jmp Player2Throw
    .ELSEIF eax == 2                                   ;Repeats process of hitting a cup if random number equals 2
        .IF CupArray[5 * 5] == 0
            call Clrscr
            call OutputCups
            mov eax, green
            call SetTextColor
            mov dh, 23
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player2Throw                            ; Jumps to next shot (beginning of outer loop)           
        .ENDIF
        mov CupArray[5 * 5], 0
        inc GoAgain
        inc WinCount2
        call Clrscr
        call OutputCups
        mov eax, green
        call SetTextColor
        mov dh, 23
        mov dl, 38
        call gotoxy
        mov edx, OFFSET HitCupDisplay
        call WriteString
        jmp Player2Throw
    .ELSE                                               ; Repeats process of missing a cup if random number is not 0, 1, or 2
        call Clrscr
        call OutputCups
        mov eax, green
        call SetTextColor
        mov dh, 23
        mov dl, 38
        call gotoxy
        mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
        call WriteString
        jmp Player2Throw                            ; Jumps to next shot (beginning of outer loop)           
    .ENDIF


Fourth:
    mov eax, 5
    call RandomRange
    .IF eax == 0                                        ;Repeats process of hitting a cup if random number equals 0
        .IF CupArray[5 * 6] == 0
            call Clrscr
            call OutputCups
            mov eax, green
            call SetTextColor
            mov dh, 23
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player2Throw                            ; Jumps to next shot (beginning of outer loop)   
        .ENDIF
        mov CupArray[5*6], 0
        inc GoAgain
        inc WinCount2
        call Clrscr
        call OutputCups
        mov eax, green
        call SetTextColor
        mov dh, 23
        mov dl, 38
        call gotoxy
        mov edx, OFFSET HitCupDisplay
        call WriteString
        jmp Player2Throw
    .ELSEIF eax == 1                                    ;Repeats process of hitting a cup if random number equals 1
        .IF CupArray[5 * 7] == 0
            call Clrscr
            call OutputCups
            mov eax, green
            call SetTextColor
            mov dh, 23
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player2Throw                            ; Jumps to next shot (beginning of outer loop)   
        .ENDIF
        mov CupArray[5*7], 0
        inc GoAgain
        inc WinCount2
        call Clrscr
        call OutputCups
        mov eax, green
        call SetTextColor
        mov dh, 23
        mov dl, 38
        call gotoxy
        mov edx, OFFSET HitCupDisplay
        call WriteString
        jmp Player2Throw
    .ELSEIF eax == 2                                    ;Repeats process of hitting a cup if random number equals 2
        .IF CupArray[5 * 8] == 0
            call Clrscr
            call OutputCups
            mov eax, green
            call SetTextColor
            mov dh, 23
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player2Throw                            ; Jumps to next shot (beginning of outer loop)   
        .ENDIF
        mov CupArray[5*8], 0
        inc GoAgain
        inc WinCount2
        call Clrscr
        call OutputCups
        mov eax, green
        call SetTextColor
        mov dh, 23
        mov dl, 38
        call gotoxy
        mov edx, OFFSET HitCupDisplay
        call WriteString
        jmp Player2Throw
    .ELSEIF eax == 3                                    ;Repeats process of hitting a cup if random number equals 3
        .IF CupArray[5 * 9] == 0
            call Clrscr
            call OutputCups
            mov eax, green
            call SetTextColor
            mov dh, 23
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player2Throw                            ; Jumps to next shot (beginning of outer loop)   
        .ENDIF
        mov CupArray[5*9], 0
        inc GoAgain
        inc WinCount2
        call Clrscr
        call OutputCups
        mov eax, green
        call SetTextColor
        mov dh, 23
        mov dl, 38
        call gotoxy
        mov edx, OFFSET HitCupDisplay
        call WriteString
        jmp Player2Throw
    .ELSE                                               ; Repeats process of missing a cup if random number is not 0, 1, 2, or 3
            call Clrscr
            call OutputCups
            mov eax, green
            call SetTextColor
            mov dh, 23
            mov dl, 38
            call gotoxy
            mov edx, OFFSET MissCupDisplay              ; Outputs text informing the user that they missed
            call WriteString
            jmp Player2Throw                            ; Jumps to next shot (beginning of outer loop)   
    .ENDIF



Player2Throw ENDP


EndGame PROC

    cmp WinCount1, 9                                    ; If the player one wincount is 9, jump to the player1 output
    ja P1Win

    cmp WinCount2, 9                                    ; If the player two wincount is 9, jump to the player two output
    ja P2Win

P1Win:
    call Clrscr                                         ; Clear the screen
    mov eax, red                                        ; Change text color to red
    call SetTextColor
    mov dh, 1
    mov dl, 1
    call gotoxy
    mov edx, OFFSET WinMsg1
    call WriteString

    mov eax, 1000                                       ; Call delay for 1 second
    call delay

    mov eax, red 
    call SetTextColor               
    mov dh, 12
    mov dl, 40
    call gotoxy
    mov edx, OFFSET WinMsg1
    call WriteString                                    ; Output another win message string in the middle of the screen

    mov eax, 1000
    call delay


    mov eax, red 
    call SetTextColor
    mov dh, 24
    mov dl, 79
    call gotoxy
    mov edx, OFFSET WinMsg1
    call WriteString

    mov eax, 1000                                       ; Output another win message string in the bottom right of the screen

    call delay

    jmp P1Win


P2Win:
    call Clrscr
    mov eax, green                                      ; Change text color to green
    call SetTextColor
    mov dh, 1
    mov dl, 1
    call gotoxy
    mov edx, OFFSET WinMsg2
    call WriteString

    mov eax, 1000                                      ; Call delay for one second
    call delay

    mov eax, green 
    call SetTextColor
    mov dh, 12
    mov dl, 40
    call gotoxy
    mov edx, OFFSET WinMsg2
    call WriteString

    mov eax, 1000
    call delay


    mov eax, green 
    call SetTextColor
    mov dh, 24
    mov dl, 79
    call gotoxy
    mov edx, OFFSET WinMsg2
    call WriteString

    mov eax, 1000

    call delay

    jmp P2Win


EndGame ENDP

END 

