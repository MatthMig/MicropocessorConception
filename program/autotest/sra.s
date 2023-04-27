# TAG = sra
	.text
       
	lui x31, 0x00000 
    sra x31, x31, x0       # Décalage de 0
    lui x31, 0x00110     
    addi x30, x30, 0x00001      
	sra x31, x31, x30      # Décalage de 1 
	addi x30, x30, 0x00003 
    sra x31, x31, x30      # Décalage de 4 
    sra x31, x31, x30      # Décalage de 4 
	addi x30, x30, 0x00030 
    sra x31, x31, x30      # Décalage de 12 

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