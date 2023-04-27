# TAG = add
	.text

    lui x30, 0x0000         #Chargement de la valeur 0
	add x31, x0, x30       
    lui x30, 0x0011         #Chargement de la valeur 17
	add x31, x31, x30       
	addi x30, x0, -1        #Chargement de la valeur -1
    add x31, x31, x30       

	# max_cycle 50
	# pout_start
	# 00000000
    # 00011000
	# 00010fff
	# pout_end