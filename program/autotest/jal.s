# TAG = jal
    .text
    lui x31, 0x0
    jal x1, test_jal_lui # registre 1 = registre 31 suivant
    ori x31, x0, 0x01 # registre 31 = 00000004
    

    test_jal_lui:     
        lui x31, 0xfffff 
        lui x31, 0x12345
        ori x31, x1, 0x0 #On charge la valeur mise dans le registre 31 au moment du saut


    # max_cycle 50
    # pout_start
    # 00000000
    # FFFFF000
    # 12345000
    # 00000004
    # pout_end