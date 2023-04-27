# TAG = xori
	.text

	xori x31, x0, 0x0000      	# xori rend 00000000
	xori x31, x31, 0x0011       # xori rend 00000011
	xori x31, x31, 0x0111		# xori rend 00000011 xor 00000111 = 00000100

	# max_cycle 50
	# pout_start
	# 00000000
    # 00000011
	# 00000100
	# pout_end