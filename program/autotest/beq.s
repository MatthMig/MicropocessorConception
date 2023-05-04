
# TAG = beq
    .text

    lui x31, 1       # initialization of x31         1000
    auipc x31, 0     # lecture addresse pc           1004
    lui x30, 0
    label:
        addi x30, x30, 1      #                      1008
        beq x31, x30, label   #                      100C

    # max_cycle 100
    # pout_start
    # 00001000
    # 00001004
    # 00001000
    # 00001004
    # pout_end