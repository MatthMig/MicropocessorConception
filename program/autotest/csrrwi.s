# TAG = csrrwi
	.text

    csrrwi x0, mie, 0 
    csrrwi x31, mie, 1  
    csrrwi x31, mie, 2
    csrrwi x31, mstatus, 3
    csrrwi x31, mstatus, 4
    csrrwi x31, mtvec, 5
    csrrwi x31, mtvec, 6
    csrrwi x31, mepc, 7
    csrrwi x31, mepc, 8
    csrrwi x31, mcause, 9
    csrrwi x31, mcause, 10
    csrrwi x31, mip, 11
    csrrwi x31, mip, 12

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
    # 00000000
    # 00000001 
	# pout_end