# TAG = andi
	.text

	andi x31, x0, 0x000      	# andi rend 00000000
	andi x31, x31, 0x011        # andi rend 00000000
	addi x31, x31, 0x00111		
	andi x31, x31, 0x100		# andi rend 00000111 xori 00000100 = 00000100

	
	# max_cycle 50
	# pout_start
	# 00000000
    # 00000000
	# 00000111
	# 00000100
	# pout_end