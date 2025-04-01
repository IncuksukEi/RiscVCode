.data 
	msg1: .asciz "Nhap so nguyen duong N: \0"
	msg2: .asciz "So vua nhap khong hop le! \0"
	msg3: .asciz "Chu so nho nhat cua N la: \0"
.text
main:
	# Nhap so nguyen N
	li a7, 4
	la a0, msg1
	ecall
	li a7, 5
	ecall 
	addi a1, a0, 0	# Lưu giá trị của N vào a1 
	
	li t0, 10 	# Khoi tao gia tri thap phan
	li s0, 9	# Khoi tao gia tri cho chu so lon nhat
Check_N:
	blt a1, t0, print_error
While:
	beq a1, zero, end_While
	rem t1, a1, t0
	blt t1, s0, Swap_min
	continue:
	div a1, a1, t0
	j While
end_While:

print:
	li a7, 4
	la a0, msg3
	ecall
	li a7, 1
	mv a0, s0
	ecall
	j end_main
print_error:
	li a7, 4
	la a0, msg2
	ecall
end_main:
	li a7, 10
	ecall

Swap_min:
	addi s0, t1, 0
	j continue