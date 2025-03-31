.data
	space: .space 100
	msg1: .asciz "Nhap chuoi ki tu: \0"
	msg2: .asciz "Chuoi ki tu tren la chuoi palindrome\0"
	msg3: .asciz  "Chuoi ki tu khong phai la chuoi palindrome\0"
.text
main:
	# Nhap chuoi ki tu
	li a7, 4
	la a0, msg1
	ecall
	li a7, 8
	li a1, 100
	la a0, space
	ecall
	# Chuan bi bien dem
	li t0, 0
	la t1, space
	li t2, '\n'
while:
	lb t3, 0(t1)
	beq t3, zero, end_white
	beq t3, t2, end_white
	addi t0, t0, 1
	addi t1, t1, 1
	j while
end_white:
	# Khởi tạo các biến đếm
	la t1, space 
	add t2, t1, t0
	addi t2, t2, -1
	li a2, 1
palindrome:
	lb a1, 0(t1)
	lb a2, 0(t2)
	bne a1, a2, endPalindrome
	bge t1, t2,  print
	addi t1, t1, 1
	addi t2, t2, -1
	j palindrome
endPalindrome:	
	li a2, 0
print:
	beq a2, zero, notPalindrome
	li a7, 4
	la a0, msg2
	ecall
	j end_main
notPalindrome:
	li a7, 4
	la a0, msg3
	ecall
end_main:
	li a7, 10
	ecall


