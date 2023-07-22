# TAG = auipc
	.text

	lui x31, 1
	auipc x31, 0x00002      #Test pour 2
	auipc x31, 0x00007      #Test pour 7 
	auipc x31, 0xfffff      #Test pour 0xfffff

	# max_cycle 50
	# pout_start
	# 00001000
	# 00003004
	# 00008008
	# 0000000C
	# pout_end