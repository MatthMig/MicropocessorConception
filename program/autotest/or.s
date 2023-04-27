# TAG = or
	.text

    lui x30, 0x0000         #Chargement de la valeur 0 dans 30
	or x31, x0, x30       	# or rend 00000000
    lui x30, 0x0011         #Chargement de la valeur 17 dans le registre 30 (00011000)
	or x31, x31, x30       	# or rend 00011000
    lui x30, 0x1001         #Chargement de la valeur 18 dans le registre 30 (01001000 ) 
    or x31, x31, x30        ## or rend (01011000)
	
	# max_cycle 50
	# pout_start
	# 00000000
    # 00011000
	# 01011000
	# pout_end