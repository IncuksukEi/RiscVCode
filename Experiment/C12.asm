.data
    input:      .space 100
    prompt:     .asciz "Nhap xau ky tu: "
    newline:    .asciz "\n"

.text
.globl main
main:
    # In lời nhắc nhập chuỗi
    li a7, 4
    la a0, prompt
    ecall

    # Nhập chuỗi từ bàn phím
    li a7, 8
    la a0, input
    li a1, 100
    ecall

    # Bắt đầu xử lý chuỗi
    la t0, input        # t0 trỏ tới từng ký tự trong chuỗi
    li t2, 1            # t2 là cờ: 1 nếu là đầu từ, 0 nếu là giữa từ

process_loop:
    lb t1, 0(t0)        # đọc ký tự hiện tại vào t1
    beqz t1, done       # nếu là null byte (kết thúc chuỗi) thì thoát

    li t3, 32           # ký tự khoảng trắng (dấu cách)

    beq t1, t3, space_char     # nếu là khoảng trắng
    # Nếu không phải khoảng trắng
    beqz t2, lower_char        # nếu không phải đầu từ, chuyển thường
    jal upper_char             # nếu là đầu từ, chuyển hoa
    li t2, 0                   # sau chữ đầu, cờ = 0
    j next_char

space_char:
    li t2, 1           # nếu gặp dấu cách, ký tự sau là đầu từ
    j next_char

lower_char:
    # Nếu là chữ hoa: chuyển sang thường
    li t4, 'A'
    li t5, 'Z'
    blt t1, t4, next_char
    bgt t1, t5, next_char
    li t6, 32          # khoảng cách giữa hoa và thường
    add t1, t1, t6
    sb t1, 0(t0)
    j next_char

upper_char:
    # Nếu là chữ thường: chuyển sang hoa
    li t4, 'a'
    li t5, 'z'
    blt t1, t4, ret_upper
    bgt t1, t5, ret_upper
    li t6, 32
    sub t1, t1, t6
    sb t1, 0(t0)
ret_upper:
    jr ra

next_char:
    addi t0, t0, 1     # sang ký tự tiếp theo
    j process_loop

done:
    # In dòng mới
    li a7, 4
    la a0, newline
    ecall

    # In kết quả đã xử lý
    li a7, 4
    la a0, input
    ecall

    # Kết thúc chương trình
    li a7, 10
    ecall
