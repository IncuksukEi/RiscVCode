.data
    arr:            .space 200        # Lưu tối đa 50 số nguyên (4 byte mỗi số)
    prompt_n:       .asciz "Nhap so luong phan tu (toi da 50): "
    prompt_val:     .asciz "Nhap phan tu: "
    space:          .asciz " "
    newline:        .asciz "\n"
    result:         .asciz "Cap phan tu lien ke co tong nho nhat la: "

.text
.globl main
main:
    # Nhap so luong phan tu
    li a7, 4
    la a0, prompt_n
    ecall

    li a7, 5
    ecall
    mv s0, a0            # s0 = n (so luong phan tu)

    li t0, 0             # i = 0
    la s1, arr           # s1 tro den arr

input_loop:
    bge t0, s0, input_done

    li a7, 4
    la a0, prompt_val
    ecall

    li a7, 5
    ecall
    sw a0, 0(s1)         # luu phan tu vao arr

    addi s1, s1, 4
    addi t0, t0, 1
    j input_loop

input_done:
    # Dat lai con tro mang
    la s1, arr
    addi s2, s1, 4        # s2 = arr + 4
    lw t1, 0(s1)          # t1 = arr[0]
    lw t2, 0(s2)          # t2 = arr[1]
    add s3, t1, t2        # s3 = tong min ban dau
    mv s4, s1             # s4 luu dia chi phan tu dau trong cap nho nhat

    li t0, 1              # i = 1
    addi s5, s0, -1       # gioi han lap = n-1

find_loop:
    bge t0, s5, print_result

    lw t1, 0(s2)              # t1 = arr[i]
    lw t2, 4(s2)              # t2 = arr[i+1]
    add t3, t1, t2            # t3 = tong hien tai

    blt t3, s3, update_min
    j skip_update

update_min:
    mv s3, t3                 # cap nhat tong min
    mv s4, s2                 # cap nhat vi tri bat dau cap min

skip_update:
    addi s2, s2, 4
    addi t0, t0, 1
    j find_loop

print_result:
    li a7, 4
    la a0, newline
    ecall

    li a7, 4
    la a0, result
    ecall

    lw a0, 0(s4)              # phan tu thu i
    li a7, 1
    ecall

    li a7, 4
    la a0, space
    ecall

    lw a0, 4(s4)              # phan tu thu i+1
    li a7, 1
    ecall

    li a7, 10
    ecall
