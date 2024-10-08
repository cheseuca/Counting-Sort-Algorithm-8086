; Counting Sort Algorithm Assembly Code on DOSBox

.8086                      ; Use 16-bit instructions
.model small               ; Small memory model for DOS
.stack 100h                ; Stack size

.data
arr     dw 3, 1, 2, 5, 4   ; Define the array with 5 elements, 16-bit (WORD)
count   dw 5 dup(0)        ; Counter array for counting occurrences 
sorted  dw 6 dup(0)        ; Array to store sorted elements (Offset to 1 so the 1st value will be stored in the memory)

.code
main PROC
    mov ax, @data          ; Initialize data segment
    mov ds, ax

    ; Step 1: Count occurrences of each number in arr
    mov cx, 6              ; Number of elements (Offset to 1 so the 1st value will be stored in the memory)
    lea si, arr            ; SI points to arr
    lea di, count          ; DI points to count array

count_loop:
    mov ax, [si]           ; Load arr[i] into AX
    mov bx, ax             ; Copy the value in arr[i] to BX
    shl bx, 1              ; Multiply BX (value) by 2 to get offset (because WORD = 2 bytes)
    inc word ptr [di + bx] ; Increment the count at offset [count + BX]
    add si, 2              ; Move to next element in arr (WORD size = 2 bytes)
    loop count_loop        ; Repeat for all elements

    ; Step 2: Place the elements in sorted order based on counts
    lea si, count          ; SI points to count array
    lea di, sorted         ; DI points to sorted array
    mov cx, 5              ; Number of possible values (0 to 4)

sort_loop:
    mov ax, [si]           ; Load count[i] into AX
    test ax, ax            ; Check if count[i] is zero
    jz skip                ; If zero, skip to next count

    mov bx, cx             ; BX = index (0 to 4)

    ; Store the sorted values in the sorted array
store_sorted:
    mov [di], bx           ; Store the index (sorted value) in sorted array
    add di, 2              ; Move to the next element in sorted array
    dec ax                 ; Decrease the count
    test ax, ax            ; Check if count[i] is still greater than 0
    jnz store_sorted       ; If more occurrences of the same value, store again

skip:
    add si, 2              ; Move to next count
    loop sort_loop         ; Repeat for the next value

    ; Step 3: End the program using DOS interrupt
    mov ah, 4Ch            ; DOS interrupt to terminate the program
    int 21h

main ENDP
END main
