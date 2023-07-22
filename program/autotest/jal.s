# TAG = jal
    .text
    jal x30, l1
    l2:
        addi x31, x31, 0x001
    l1:
        addi x31, x31, 0x00f
        jal x30, l2

    # max_cycle 50
    # pout_start
    # 0000000F
    # 00000010
    # pout_end