.eqv MONITOR_SCREEN 0x10010000
.eqv YELLOW         0x00FFFF00 
.eqv RED            0x00FF0000 


.text
main:
	li t0, 128
	


end_main:
	li a7, 10
	ecall
