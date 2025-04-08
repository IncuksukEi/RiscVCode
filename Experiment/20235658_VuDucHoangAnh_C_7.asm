.data 
	String_s1: .space 500
	String_s2: .space 500
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
	li a1, 500
	la a0, String_s1
	ecall

	# Nhap chuoi thu hai
	li a7, 4
	la a0, msg2
	ecall
	li a7, 8
	li a1, 500
	la a0, String_s2
	ecall

	# Tính độ dài chuỗi s1
	li s1, 0
	la t1, String_s1
	li t4, '\n'
while1:
	lb t3, 0(t1)
	beqz t3, end_white1
	beq t3, t4, end_white1
	addi s1, s1, 1
	addi t1, t1, 1
	j while1
end_white1:

	# Tính độ dài chuỗi s2
	li s2, 0
	la t2, String_s2
while2:
	lb t3, 0(t2)
	beqz t3, end_white2
	beq t3, t4, end_white2
	addi s2, s2, 1
	addi t2, t2, 1
	j while2
end_white2:
	
# =============================== #
# Check xau con
	# s1 la do dai cua string 1
	# s2 la do dai cua string 2
	li t1, 0 # bien dem vong lap 1
	li t2, 0 # bien dem vong lap 2
	sub t0, s1, s2	# Gioi han bat dau kiem tra
	addi t0, t0, 1
check:
	blt s1, s2, false_Print # Neu s2 dai hon s1 thi False
	beq s2, zero, true_Print # Neu s2 rong thi True
end_Check:
	# addi s1, s1, -1		# Chuyen do dai ve thang do 0 den n
	# addi s2, s2, -1 	# Chuyen do dai ve thang do 0 den n
loop1:
	beq t1, t0, end_Loop1
	li t2, 0
	la a1, String_s1	# Lay dia chi string 1
	la a2, String_s2	# Lay dia chi String 2
	loop2:
		beq t2, s2, true_Print	
		add a3, a1, t1		# Dia chi s1[i]
		add a3, a3, t2		# Dia chi s1[i + j]
		add a4, a2, t2		# Dia chi s2[j]
		lb t3, 0(a3)		# s1[i+j]
		lb t4, 0(a4)		# s2[j]
		bne t3, t4, end_Loop2	# s1[i+j] != s2[j] dung vong lap	
		addi t2, t2, 1
		j loop2
	end_Loop2:
	addi t1, t1, 1
	j loop1
end_Loop1:

false_Print:
	li a7, 4
	la a0, msg4
	ecall
	j end_main
true_Print:
	li a7, 4
	la a0, msg3
	ecall

end_main:
	li a7, 10
	ecall
