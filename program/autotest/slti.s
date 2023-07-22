# TAG = slti
	.text
       
	lui x30, 0x00000 
    slti x31, x30, 1     # Comparaison entre 0 et 1, retourne 1    
	lui x30, 0x00001    
	slti x31, x30, 0       # Comparaison entre 1 et 0, retourne 0  
	lui x30, 0x00001 
    slti x31, x30, 1     # Comparaison entre 1 et 1, retourne 0  

	# max_cycle 50
	# pout_start
    # 00000001
	# 00000000
    # 00000000
	# pout_end