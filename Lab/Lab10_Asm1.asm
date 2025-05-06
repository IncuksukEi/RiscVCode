.eqv SEVENSEG_LEFT 0xFFFF0011 # Dia chi cua den led 7 doan trai
# vd gia tri cua byte tai 0xFFFF0011 la 0x12
# 0x12 = 0b 0001 0010
# 2 thanh      e   b  se nhan tin hieu
.eqv SEVENSEG_RIGHT 0xFFFF0010 # Dia chi cua den led 7 doan phai
.text
main:
	li a0, 0x6D	# 5 - 01101101
	jal SHOW_7SEG_LEFT 
	li a0, 0x7F	# 8 - 01111111
	jal SHOW_7SEG_RIGHT 
exit:
	li a7, 10
	ecall
end_main:
# ---------------------------------------------------------------
# Function SHOW_7SEG_LEFT : turn on/off the 7seg
# param[in] a0 value to shown
# remark t0 changed
# ---------------------------------------------------------------
SHOW_7SEG_LEFT:
	li t0, SEVENSEG_LEFT # assign port's address
	sb a0, 0(t0) # assign new value
	jr ra
# ---------------------------------------------------------------
# Function SHOW_7SEG_RIGHT : turn on/off the 7seg
# param[in] a0 value to shown
# remark t0 changed
# ---------------------------------------------------------------
SHOW_7SEG_RIGHT:
	li t0, SEVENSEG_RIGHT # assign port's address
	sb a0, 0(t0) # assign new value
	jr ra
