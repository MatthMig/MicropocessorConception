# TAG = blt
    .text

    auipc x31, 0                # read of x31         1000
    addi x29, x29, 0x001
    addi x30, x30, 0x003
    auipc x31, 0                # new read of x31     100C

    l1:
        auipc x31, 0            #                     1010
        addi x29, x29, 0x001
        blt x29, x30, l1

        auipc x31, 0            #                     101C

    # max_cycle 100
    # pout_start
    # 00001000
    # 0000100C
    # 00001010
    # 00001010
    # 0000101C
    # pout_end