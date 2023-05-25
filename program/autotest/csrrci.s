# TAG = csrrci
	.text

    csrrci x0, mie, 0 
    csrrci x31, mie, 1  
    csrrci x31, mie, 2
    csrrci x31, mstatus, 3
    csrrci x31, mstatus, 4
    csrrci x31, mtvec, 5
    csrrci x31, mtvec, 6
    csrrci x31, mepc, 7
    csrrci x31, mepc, 8
    csrrci x31, mcause, 9
    csrrci x31, mcause, 10
    csrrci x31, mip, 11
    csrrci x31, mip, 12

	# max_cycle 100
	# pout_start
    # 00000000
    # 00000001  
    # 00000000
    # 00000003 
    # 00000000
    # 00000005 
    # 00000000
    # 0000101C 
    # 00000000
    # 00000000 
    # 00000080
    # 00000080 
    # 00000000
    # 00000001 
	# pout_end