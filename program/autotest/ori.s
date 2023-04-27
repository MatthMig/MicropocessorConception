# TAG = ori
	.text

	ori x31, x0, 0x0000      	# ori rend 00000000
	ori x31, x31, 0x0011        # ori rend 00000011
    ori x31, x31, 0x0101        ## (00000011) ou (00000101 ) ori rend (00000111)

	# max_cycle 50
	# pout_start
	# 00000000
    # 00000011
	# 00000111
	# pout_end