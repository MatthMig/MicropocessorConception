# TAG = addi
	.text

	addi x31, x31,  0       #Ajout d'une valeur nulle
	addi x31, x31, 0x00011  #Ajout d'une valeur positive de 17
    addi x31, x31, -1       #Ajout d'une valeur négative -1

	# max_cycle 50
	# pout_start
	# 00000000
	# 00000011
	# 00000010
	# pout_end