# TAG = srli
	.text
       
	lui x31, 0x00000 
    srai x31, x31, 0       # Décalage de 0
    lui x31, 0x00110          
	srai x31, x31, 1      # Décalage de 1 
    srai x31, x31, 4      # Décalage de 4 
    srai x31, x31, 4      # Décalage de 4 
    srai x31, x31, 12      # Décalage de 12 

	# max_cycle 50
	# pout_start
    # 00000000
	# 00000000
    # 00110000
    # 00088000
	# 00008800
	# 00000880
	# 00000000
	# pout_end