; Counting Sort Algorithm Assembly Code on Visual Studion 2022 

.386                         ; Use 32-bit instructions
.model flat, stdcall          ; Flat memory model for 32-bit mode
.stack 4096                  ; Stack size

.data
    arr    dd 3, 1, 2, 5, 4  ; Define the array with 5 elements, 32-bit (DWORD)
    count  dd 6 dup(0)       ; Counter array for counting occurrences
    sorted dd 6 dup(0)       ; Array to store sorted elements

.code
main PROC
    ; Step 1: Count occurrences of each number in arr
    mov ecx, 6               ; Number of elements (Offset to 1 so the 1st value will be stored in the memory
    lea esi, arr             ; ESI points to arr
    lea edi, count           ; EDI points to count array

count_loop:
    mov eax, [esi]           ; Load arr[i] into EAX
    inc dword ptr [edi + eax*4] ; Increment the count of the corresponding value
    add esi, 4               ; Move to next element in arr (DWORD size = 4 bytes)
    loop count_loop          ; Repeat for all elements

    ; Step 2: Place the elements in sorted order based on counts
    lea esi, count           ; ESI points to count array
    lea edi, sorted          ; EDI points to sorted array
    mov ecx, 5               ; Number of possible values (0 to 4)

sort_loop:
    mov eax, [esi]           ; Load count[i] into EAX
    test eax, eax            ; Check if count[i] is zero
    jz skip                  ; If zero, skip to next count

    mov ebx, ecx             ; EBX = index (0 to 4)

    ; Store the sorted values in the sorted array
store_sorted:
    mov [edi], ebx           ; Store the index (sorted value) in sorted array
    add edi, 4               ; Move to the next element in sorted array
    dec eax                  ; Decrease the count
    test eax, eax            ; Check if count[i] is still greater than 0
    jnz store_sorted         ; If more occurrences of the same value, store again

skip:
    add esi, 4               ; Move to next count
    loop sort_loop           ; Repeat for the next value

    ; End program (use Visual Studio debugging to see the sorted array in 'sorted')
    ret
main ENDP
END main
