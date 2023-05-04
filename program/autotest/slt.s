# TAG = slt
	.text
       
	lui x31, 0x00000 
    slt x31, x31, 0       # Décalage de 0
    lui x31, 0x00110          
	slt x31, x31, 1      # Décalage de 1 
    slt x31, x31, 4      # Décalage de 4 
    slt x31, x31, 16     # Décalage de 16

	# max_cycle 50
	# pout_start
    # 00000000
	# 00000000
    # 00110000
    # 00220000
	# 02200000
    # 00000000
	# pout_end