# TAG = add
	.text

    lui x30, 0x0000         #Chargement de la valeur 0
	add x31, x31, x30       
    lui x30, 0x0011         #Chargement de la valeur 17
	add x31, x31, x30       
    lui x30, 0x0001         #Chargement de la valeur -1
    add x31, x31, x30       

	# max_cycle 50
	# pout_start
	# 00000000
	# 00000000
    # 00110000
	# 00110000
    # 00010000
	# 00120000
	# pout_end