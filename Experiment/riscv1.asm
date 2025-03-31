.data 
	A: .word -10, 25, -40, 30, -50, 15, 5 
	n: .word 7 
	max_abs: .word 0 
.text 
	la a0, A       
	lw a1, n     
	li a2, 0 	# index i = 0       
	li a3, 0        # max_abs = 0 
loop: 
	bge a2, a1, endloop  	# If i >= n, exit loop 
	slli t0, a2, 2   	# t0 = i * 4 (each .word is 4 bytes) 
	add t0, a0, t0   	# t0 = &A[i] 
	lw t1, 0(t0)     	# t1 = A[i] 
	blt t1, zero, rev  	# if A[i] < 0, take -A[i] 
	j comp 
rev: 
	sub t1, zero, t1   	# abs(A[i]) 
comp: 
	bge t1, a3, upd_max  	# if abs(A[i]) >= max_abs, upd  
	j next 
upd_max: 
	mv a3, t1  # max_abs = abs(A[i]) 
next: 
	addi a2, a2, 1  # i++ 
	j loop 
endloop: 
