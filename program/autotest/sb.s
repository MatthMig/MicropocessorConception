# TAG = sb
	.text

    lui x30, 0x0001         # Chargement de la valeur 1
    lui x31, 0xFF         # Chargement de la valeur 0xFF
    sb x31, 0x234(x30)     # Ecriture à l'addresse 0x1234 de 0x00FF
    lb x31, 0x234(x30)     # Lecture à l'addresse 0x1234

	# max_cycle 100
	# pout_start
    # 000FF000
    # 00000000
	# pout_end