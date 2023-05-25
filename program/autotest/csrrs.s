# TAG = csrrs
	.text

    csrrs x0, mie, x0 
    lui x30, 0x00001
    csrrs x31, mie, x30  
    addi x30, x30, 1        # 1001
    csrrs x31, mie, x30
    addi x30, x30, 1        # 1002
    csrrs x31, mstatus, x30
    csrrs x31, mstatus, x30
    addi x30, x30, 1        # 1003
    csrrs x31, mtvec, x30
    csrrs x31, mtvec, x30
    addi x30, x30, 1        # 1004
    csrrs x31, mepc, x30
    csrrs x31, mepc, x30
    addi x30, x30, 1        # 1005
    csrrs x31, mcause, x30
    csrrs x31, mcause, x30
    addi x30, x30, 1        # 1006
    csrrs x31, mip, x30
    csrrs x31, mip, x30

	# max_cycle 100
	# pout_start
    # 00000000
    # 00001000  
    # 00000000
    # 00001002 
    # 00000000
    # 00001003 
    # 00000000
    # 00001030
    # 00000000
    # 00000000 
    # 00000080
    # 00000080  
	# pout_end