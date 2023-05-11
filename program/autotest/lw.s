# TAG = lw
	.text

	addi x31,x0,0
	addi x29,x0,0
	lw x31,0x0(x29)

	lui x1,1
	lw x31,4(x1)  

	# max_cycle 50
	# pout_start
	# 00000000
    # 00000000
    # 00000E93
	# pout_end