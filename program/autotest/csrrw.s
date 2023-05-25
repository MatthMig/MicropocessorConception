# TAG = csrrw
	.text

    csrrw x0, mie, x0 
    lui x30, 0x00001
    csrrw x31, mie, x30  
    addi x30, x30, 1        # 1001
    csrrw x31, mie, x30
    addi x30, x30, 1        # 1002
    csrrw x31, mstatus, x30
    csrrw x31, mstatus, x30
    addi x30, x30, 1        # 1003
    csrrw x31, mtvec, x30
    csrrw x31, mtvec, x30
    addi x30, x30, 1        # 1004
    csrrw x31, mepc, x30
    csrrw x31, mepc, x30
    addi x30, x30, 1        # 1005
    csrrw x31, mcause, x30
    csrrw x31, mcause, x30
    addi x30, x30, 1        # 1006
    csrrw x31, mip, x30
    csrrw x31, mip, x30

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