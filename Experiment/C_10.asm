.data 
	String_s1: .space 500
	String_s2: .space 500
	msg1: .asciz "Nhap chuoi thu nhat: "
	msg2: .asciz "Nhap chuoi thu hai: "
	msg3: .asciz "Hai xau ki tu giong nhau!"
	msg4: .asciz "Hai xau ki tu khac nhau!"
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
# Kiem tra su giong nhau
check:
	bne s1, s2, false_print		# So sanh do dai
	# So sánh từng ký tự
	li t0, 0		# index
	la t1, String_s1
	la t2, String_s2
compare_loop:
	beq t0, s1, true_print

	lb t3, 0(t1)		# kí tự s1
	lb t4, 0(t2)		# kí tự s2

	# Chuyen t3 ve dang in thuong neu A < t3 < Z
	li t5, 'A'
	li t6, 'Z'
	blt t3, t5, skip_lower1
	bgt t3, t6, skip_lower1
	addi t3, t3, 32
skip_lower1:

	# Chuyen t4 ve dang in thuong neu A < t4 < Z
	li t5, 'A'
	li t6, 'Z'
	blt t4, t5, skip_lower2
	bgt t4, t6, skip_lower2
	addi t4, t4, 32
skip_lower2:
	bne t3, t4, false_print
	addi t0, t0, 1 
	addi t1, t1, 1
	addi t2, t2, 1
	j compare_loop
true_print:
	li a7, 4
	la a0, msg3
	ecall
	j end_main
false_print:
	li a7, 4
	la a0, msg4
	ecall
end_main:
	li a7, 10
	ecall

