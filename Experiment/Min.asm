.data 
	Array: .space 320
	msg1:  .asciz "Nhap do dai cua mang: \0"
	msg2:  .asciz "Nhap cac phan tu: \0"
	msg3:  .asciz "So am nho nhat trong mang la: \0"
	msg4:  .asciz "Khong ton tai phan tu am trong mang \0"
	msg5:  .asciz "\n\0"
	
.text 
main:
	li a7, 4
	la a0, msg1
	ecall
	li a7, 5
	ecall
	add s0, a0, zero
	# Khoi tao cac gia tri truoc khi duyet
	li t0, 0	# Bien dem
	li s1, 0	# Gia tri min
	

loop:
	beq t0, s0, endLoop
	li a7, 4
	la a0, msg2
	ecall
	li a7, 5
	ecall
	addi t1, a0, 0
	sub t2, t1, s1
	blt t2, zero, swap_min
	countinue:
	addi t0, t0, 1
	j loop
endLoop:

print:
	beq zero, s1, error
	li a7, 4
	la a0, msg3
	ecall
	li a7, 1 
	mv a0, s1
	ecall
	j end_main
error:
	li a7, 4
	la a0, msg4
	ecall
end_main:
	li a7, 10
	ecall
	
	
swap_min:
	addi s1, t1, 0
	j countinue
