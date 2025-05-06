.eqv SEVENSEG_LEFT	0xFFFF0011
.eqv SEVENSEG_RIGHT 0xFFFF0010

.data
	# khoi tao cac ma cua led 7 thanh
SEG_TABLE:
	.byte 0x3F	# 0
	.byte 0x06	# 1
	.byte 0x5B	# 2
	.byte 0x4F	# 3	
	.byte 0x66	# 4
	.byte 0x6D	# 5
	.byte 0x7D	# 6
	.byte 0x07	# 7
	.byte 0x7F	# 8
	.byte 0x6F	# 9

.text
main:
	# Nhap ki tu
	li a7, 12	# read char
	ecall

	li t3, 100	# Tao tham so
	remu t0, a0, t3	# Lay 2 so cuoi cung

	li t4, 10
	divu t1, t0, t4	# Lay hang chuc (Led ben trai)
	remu t2, t0, t4	# Lay hang don vi (Led ben phai

	la t5, SEG_TABLE	# Lay dia chi cua mang
	add t6, t5, t1		# Lay dia chi cua so hang chuc
	lb a1, 0(t6)		# Lay ma cua so hang chuc

	add t6, t5, t2		# Lay dia chi cua so hang don vi
	lb a2, 0(t6)		# Lay ma cua so hang don vi
	
	# In ra man hinh
	li t0, SEVENSEG_LEFT
	sb a1, 0(t0)

	li t0, SEVENSEG_RIGHT
	sb a2, 0(t0)

	j main
