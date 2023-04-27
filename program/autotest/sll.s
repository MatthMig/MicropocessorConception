# TAG = sll
	.text
       
	lui x31, 0x00000 
    sll x31, x31, x0       # Décalage de 0
    lui x31, 0x00011     
    addi x30, x30, 0x00001      
	sll x31, x31, x30      # Décalage de 1 
	addi x30, x30, 0x00003 
    sll x31, x31, x30      # Décalage de 4 
	addi x30, x30, 0x00010 
    sll x31, x31, x30      # Décalage de 16 

	# max_cycle 50
	# pout_start
    # 00000000
	# 00000000
    # 00011000
    # 00022000
	# 00220000
    # 00000000
	# pout_end