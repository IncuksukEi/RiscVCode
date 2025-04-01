.data 
	msg1: .asciz "Nhap so phan tu cua mang: "
	msg2: .asciz "Nhap phan tu: "
	msg3: .asciz "Tong cac phan tu am trong mang la: "
	msg4: .asciz "Tong cac phan tu duong tron mang la: "
	msg5: .asciz "\n"
.text 
main:
	# Nhap so luong phan tu cua mang
	li a7, 4
	la a0, msg1
	ecall
	li a7, 5
	ecall
	addi s0, a0, 0	# Luu so phan tu trong mang
	
	# Nhap cac phan tu trong mang
	li t0, 0 	# Khoi tao bien dem
	li t1, 0	# Bien luu ket qua nhap
	li s1, 0	# Tong cac phan tu am
	li s2, 0	# Tong cac phan tu duong
Loop:
	beq t0, s0, end_Loop
	# Nhap phan tu thu A[i]
	li a7, 5
	ecall
	addi t1, a0, 0
if:
	blt  t1, zero, else
then:
	add s2, s2, t1
	j continue
else: 
	add s1, s1, t1
continue:
	addi t0, t0, 1
	j Loop
end_Loop:

print:
	# In chu tong cac phan tu am cua mang
	li a7, 4
	la a0, msg3
	ecall
	li a7, 1
	mv a0, s1
	ecall
	li a7, 4
	la a0, msg5
	ecall
	# In chu tong cac phan tu am cua mang
	li a7, 4
	la a0, msg4
	ecall
	li a7, 1
	mv a0, s2
	ecall
end_main:
	li a7, 10
	ecall