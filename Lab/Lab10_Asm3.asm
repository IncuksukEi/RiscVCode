.eqv MONITOR_SCREEN 0x10010000  # Dia chi bat dau cua bo nho man hinh 
.eqv Trang	     0XFFFFFF
.eqv Xam	     0x808080
.text 
main:
	li  a0, MONITOR_SCREEN      
	# Nap dia chi bat dau cua man hinh 
	li t0, 0	# Khoi tao bien dem loop1
	li t1, 0	# Khoi tao bien dem loop2
	li t3, 8	# Do dai cua hang cot
	li t4, 2	# Khoi tao mat na bit so chan
LOOP1:
	beq t0, t3, ENDLOOP1
	li t1, 0
	LOOP2:
		beq t1, t3, ENDLOOP2
		add t5, t1, t0
		rem t5, t5, t4
	if:
		beq t5, zero, else
	then:
		li t2, Trang
		sw t2, 0(a0)
		addi a0, a0, 4
		j continue
	else:
		li t2, Xam
		sw t2, 0(a0)
		addi a0, a0, 4
	continue:
		addi t1, t1, 1
		j LOOP2
	ENDLOOP2:
	addi t0, t0, 1
	j LOOP1
ENDLOOP1:

end_main:
	li a7, 10
	ecall
