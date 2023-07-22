# TAG = csrrsi
	.text

    csrrsi x0, mie, 0 
    csrrsi x31, mie, 1  
    csrrsi x31, mie, 2
    csrrsi x31, mstatus, 3
    csrrsi x31, mstatus, 4
    csrrsi x31, mtvec, 5
    csrrsi x31, mtvec, 6
    csrrsi x31, mepc, 7
    csrrsi x31, mepc, 8
    csrrsi x31, mcause, 9
    csrrsi x31, mcause, 10
    csrrsi x31, mip, 11
    csrrsi x31, mip, 12

	# max_cycle 100
	# pout_start
    # 00000000
    # 00000001  
    # 00000000
    # 00000003 
    # 00000000
    # 00000004 
    # 00000000
    # 00000004 
    # 00000000
    # 00000000 
    # 00000080
    # 00000080 
    # 00000003
    # 00000003 
	# pout_end