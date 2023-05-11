# TAG = sb
	.text

    lui x30, 0x0001         # Chargement de la valeur 1
    lui x31, 0x0FFF         # Chargement de la valeur 0xFFF
    sb x31, 0x234(x30)     # Ecriture à l'addresse 0x1234 de 0x0FFF
    lb x31, 0x234(x30)     # Lecture à l'addresse 0x1234

	# max_cycle 100
	# pout_start
    # 00FFF000
    # 00FFF000
	# pout_end