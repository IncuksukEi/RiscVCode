.data 
	String_s1: .space 5
	String_s2: .space 5
	msg1: .asciz "Nhap chuoi thu nhat: "
	msg2: .asciz "Nhap chuoi thu hai: "
	msg3: .asciz "Chuoi thu hai la xau con cua chuoi thu nhat!"
	msg4: .asciz "Chuoi thu hai khong phai xau con cua chuoi thu nhat!"
	
.text
main:
	# Nhap chuoi thu nhat
	li a7, 4
	la a0, msg1
	ecall
	li a7, 8
	li a1, 100
	la a0, String_s1
	ecall
	# Nhap chuoi thu hai
	li a7, 4
	la a0, msg2
	ecall
	li a7, 8
	li a1, 100
	la a0, String_s2
	ecall
# =============================== #
	li s1, 0	# Do dai cua string s1
	li s2, 0	# Do dai cua string s2
	la t1, String_s1
	la t2, String_s2 
	li t4, '\n'
while1:
	lb t3, 0(t1)
	beqz t3, end_white1  # Nếu gặp ký tự null ('\0'), kết thúc
	beq t3, t4, end_white1    # Nếu gặp '\n', cũng kết thúc
	addi s1, s1, 1            # Tăng biến đếm độ dài chuỗi
	addi t1, t1, 1            # Dịch con trỏ sang ký tự tiếp theo
	j while1
end_white1:
	
while2:
	lb t3, 0(t2)
	beq t3, zero, end_white2  # Nếu gặp ký tự null ('\0'), kết thúc
	beq t3, t4, end_white2    # Nếu gặp '\n', cũng kết thúc
	addi s2, s2, 1            # Tăng biến đếm độ dài chuỗi
	addi t2, t2, 1            # Dịch con trỏ sang ký tự tiếp theo
	j while2
end_white2:
	addi s1, s1, -1
	addi s2, s2, -1
# ===============================#
#Check xau con 
	# Khoi tao bien
	li t0, 0	# Bien dem cua vong lap ngoai
	li t1, 0	# Bien dem cua vong lap trong
	li t5, -1	# Bien check 
loop1:
	la a1, String_s1	# Dia chi cua s1
	la a2, String_s2	# Dia chi cua s2
	beq t0, s1, end_Loop1
	add a1, a1, t0		# Lấy vị trí bắt đầu của chuỗi con trong s1
	li t1, 0
loop2:
	add a3, a2, t1	# Vi tri phan tu s2[i]
	add a4, a1, t1 	# Vi tri phan tu s1[i]
	lb t2, 0(a3)	# Giá trị của s2[i]
	lb t3, 0(a4)	# GIá trị của s1[i]
	beqz t3, print	# Kiểm tra nếu s2 bằng chuỗi con của s1 thì in ra màn hình
	addi t1, t1, 4	# Tăng biến đếm 
	beq t2, t3, loop2	# Kiểm tra nếu s1[i] = s2[i] thì kiểm tra biến tiếp theo
end_loop2:
	addi t0, t0, 1	# Tăng biến đếm
	j loop1	
end_Loop1:
	li t5, 1	# Thay đổi gíá trị của check nếu không tồn tại s2 trong s1
print:
if:
	blt t5, zero, else
then:
	li a7, 4
	la a0, msg4
	ecall
	j end_main
else:
	li a7, 4
	la a0, msg3
	ecall
end_main:
	li a7, 10
	ecall