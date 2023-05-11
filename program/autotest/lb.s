# TAG = lb
	.text

	auipc x31, 0x0          # Lecture addresse           0x1000
    auipc x31, 0x0          # Lecture addresse           0x1004
    lui x30, 0x0001         # Chargement de la valeur 1
	lb x31, 0x004(x30)     # Lecture de la l'addresse 0x1004, return 0xFFFFFF97     

	# max_cycle 50
	# pout_start
	# 00001000
    # 00001004
    # FFFFFF97
	# pout_end