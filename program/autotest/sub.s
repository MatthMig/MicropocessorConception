# TAG = sub
	.text

    lui x30, 0x0000         #Chargement de la valeur 0 dans le registre 30
	sub x31, x0, x30        # sub donne 00000000
    lui x30, 0x0001         # registre 30 : 00011000
    lui x31, 0x0011         # registre 31 : 00010000
    sub x31, x31, x30       # sub = 00001000
	
	# max_cycle 50
	# pout_start
	# 00000000
    # 00011000
	# 00010000
	# pout_end