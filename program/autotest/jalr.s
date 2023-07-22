# TAG = jalr
    .text
    lui x29, 0x00001            # 1000
    jalr x30, 0x00C(x29)                # 1004
    l2:
        addi x31, x31, 0x001    # 1008
    l1:
        addi x31, x31, 0x00f    # 100C
        jalr x30, 0x008(x29)     # 1010

    # max_cycle 50
    # pout_start
    # 0000000F
    # 00000010
    # pout_end