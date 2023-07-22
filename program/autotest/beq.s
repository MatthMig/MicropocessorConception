# TAG = beq
    .text

    auipc x31, 0                # read of x31         1000
    lui x30, 0x00001
    lui x29, 0x00001
    addi x30, x30, 0x001
    auipc x31, 0                # new read of x31     1010

    l1:
        auipc x31, 0            #                     1014
        addi x29, x29, 0x001
        beq x30, x29, l1

    l2:
        auipc x31, 0            #                     1020                   
        addi x30, x30, 0x001
        beq x30, x29, l2

        auipc x31, 0            #                     102C

    # max_cycle 100
    # pout_start
    # 00001000
    # 00001010
    # 00001014
    # 00001014
    # 00001020
    # 00001020
    # 0000102C
    # pout_end