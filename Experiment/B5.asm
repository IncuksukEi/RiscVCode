.data
arr:          .space 400      # Mảng đầu vào (tối đa 100 số nguyên)
pos_arr:      .space 400      # Mảng chứa các số dương để sắp xếp
prompt_n:     .asciz "Nhap so phan tu cua mang: "
prompt_i:     .asciz "Nhap phan tu thu "
prompt_is:    .asciz " la: "
error:	      .asciz "So phan tu cua mang khong hop le"
space:        .asciz " "
newline:      .asciz "\n"

.text

main:
    # Nhap so phan tu n
    li a7, 4
    la a0, prompt_n
    ecall

    li a7, 5
    ecall
    mv s0, a0        # s0 = n (so phan tu)

    li t0, 0         # i = 0
check:
    bge zero, s0, print_error
nhap_mang:
    bge t0, s0, tach_so_duong

    li a7, 4
    la a0, prompt_i
    ecall

    li a7, 1
    mv a0, t0
    ecall

    li a7, 4
    la a0, prompt_is
    ecall

    li a7, 5
    ecall
    mv t1, a0        # t1 = phan tu vua nhap
    
    la t2, arr
    slli t3, t0, 2
    add t2, t2, t3
    sw t1, 0(t2)

    addi t0, t0, 1
    j nhap_mang

# Tách các số dương vào mảng pos_arr[]
tach_so_duong:
    li t0, 0         # i = 0
    li s1, 0         # dem = 0 (số phần tử dương)

tach_loop:
    bge t0, s0, sort_pos
    la t1, arr
    slli t2, t0, 2
    add t3, t1, t2
    lw t4, 0(t3)     # t4 = arr[i]

    li a1, 0
    bgt t4, a1, save_pos   # nếu arr[i] > 0

    addi t0, t0, 1
    j tach_loop

save_pos:
    la t5, pos_arr
    slli t6, s1, 2
    add a2, t5, t6
    sw t4, 0(a2)

    addi s1, s1, 1     # tăng số phần tử dương
    addi t0, t0, 1
    j tach_loop

# Bubble Sort mảng pos_arr[]
sort_pos:
    addi t0, s1, -1     # n = s1 - 1
outer:
    blt t0, zero, gan_lai
    li t1, 0
inner:
    bge t1, t0, next_outer

    la t2, pos_arr
    slli t3, t1, 2
    add t4, t2, t3
    lw a0, 0(t4)
    lw a1, 4(t4)

    bgt a0, a1, swap
    j no_swap

swap:
    sw a1, 0(t4)
    sw a0, 4(t4)
no_swap:
    addi t1, t1, 1
    j inner

next_outer:
    addi t0, t0, -1
    j outer

# Gán lại số dương đã sắp xếp vào mảng arr
gan_lai:
    li t0, 0         # i = 0
    li t1, 0         # idx = 0 (vị trí trong pos_arr)

gan_loop:
    bge t0, s0, in_kq

    la t2, arr
    slli t3, t0, 2
    add t4, t2, t3
    lw t5, 0(t4)

    li a1, 0
    bgt t5, a1, doi_so

    addi t0, t0, 1
    j gan_loop

doi_so:
    la t6, pos_arr
    slli a2, t1, 2
    add a3, t6, a2
    lw a4, 0(a3)
    sw a4, 0(t4)

    addi t1, t1, 1
    addi t0, t0, 1
    j gan_loop

# In mảng kết quả
in_kq:
    li t0, 0
print_loop:
    bge t0, s0, end
    la t1, arr
    slli t2, t0, 2
    add t3, t1, t2
    lw a0, 0(t3)

    li a7, 1
    ecall

    li a7, 4
    la a0, space
    ecall

    addi t0, t0, 1
    j print_loop
    
    j end
print_error: 
    li a7, 4
    la a0, error
    ecall
end:
    li a7, 10
    ecall
