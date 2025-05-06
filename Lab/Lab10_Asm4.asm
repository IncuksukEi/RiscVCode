.eqv KEY_CODE			0xFFFF0004
.eqv KEY_READY			0xFFFF0000
.eqv DISPLAY_CODE		0xFFFF000C
.eqv DISPLAY_READY		0xFFFF0008

.text
main:
	# Khoi tao cac dia chi cua keyboad and display
	li a0, KEY_CODE
	li a1, KEY_READY
	li s0, DISPLAY_CODE
	li s1, DISPLAY_READY

	# Khoi tao cac gia tri tham so de thuc hien so sanh
	li s6, 'a'
	li s7, 'z'
	li s8, 'A'
	li s9, 'Z'
	li s10, '0'
	li s11, '9'
	li t5, '*'
	
	# Khoi tao hang tro de luu cac bien nhap vao
	li s2, 0
	li s3, 0
	li s4, 0
	li s5, 0

loop:
waitforkey:
	lw t1, 0(a1)
	beq t1, zero, waitforkey

readkey:
	lw t0, 0(a0)
	
	mv s5, s4
	mv s4, s3
	mv s3, s2
	mv s2, t0

	# Kiem tra chuoi ki tu nhap co phai exit hay khong
	li t1, 'e'
	bne s5, t1, processchar
	li t1, 'x'
	bne s4, t1, processchar
	li t1, 'i'
	bne s3, t1, processchar
	li t1, 't'
	bne s2, t1, processchar
	j exitprogram

processchar:
	# Dua ki tu in hoa ve ki tu in thuong
	blt t0, s6, checkupper
	blt s7, t0, checkupper
	addi t0, t0, -32
	j displaychar

checkupper:
	# Dua ki tu in thuong ve in hoa
	blt t0, s8, checkdigit
	blt s9, t0, checkdigit
	addi t0, t0, 32
	j displaychar

checkdigit:
	# Kiem tra cac ki tu so
	blt t0, s10, setstar
	blt s11, t0, setstar
	j displaychar

setstar:
	# Dua cac ki tu con lai thanh sao
	mv t0, t5

displaychar:
waitfordis:
	lw t2, 0(s1)
	beq t2, zero, waitfordis

showkey:
	sw t0, 0(s0)
	j loop

exitprogram:
	# In ki tu T va ket thuc chuong trinh
   	li t0, 'T'
    	sw t0, 0(s0)
show_t:
    	lw t2, 0(s1)
    	beq t2, zero, show_t
end:
    	li a7, 10
    	ecall
