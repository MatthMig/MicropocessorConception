# TAG = and
	.text

    lui x30, 0x0000         #Chargement de la valeur 0
	and x31, x0, x30       
    lui x30, 0x0011         #Chargement de la valeur 17 dans le registre 30
	and x31, x31, x30       
    lui x31, 0x0011         #Chargement de la valeur 17 dans le registre 31
    and x31, x31, x30       # Et bit à bit entre 31 et 30 dans 31 (17 et 17)
	
	# max_cycle 50
	# pout_start
	# 00000000
    # 00000000
	# 00011000
	# 00011000
	# pout_end