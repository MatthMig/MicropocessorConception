library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.PKG.all;


entity CPU_PC is
    generic(
        mutant: integer := 0
    );
    Port (
        -- Clock/Reset
        clk    : in  std_logic ;
        rst    : in  std_logic ;

        -- Interface PC to PO
        cmd    : out PO_cmd ;
        status : in  PO_status
    );
end entity;

architecture RTL of CPU_PC is
    type State_type is (
        S_Error,
        S_Init,
        S_Pre_Fetch,
        S_Fetch,
        S_Decode,
        S_LUI,
        S_ADDI,
        S_ORI,
        S_ADD,
        S_SUB,
        S_XORI,
        S_ANDI,
        S_XOR,
        S_OR,
        S_AND,
        S_SLL,
        S_SRL,
        S_SRA,
        S_SRAI,
        S_SLLI,
        S_SRLI,
        S_AUIPC,
        S_SLT,
        S_BEQ
    );

    signal state_d, state_q : State_type;


begin

    FSM_synchrone : process(clk)
    begin
        if clk'event and clk='1' then
            if rst='1' then
                state_q <= S_Init;
            else
                state_q <= state_d;
            end if;
        end if;
    end process FSM_synchrone;

    FSM_comb : process (state_q, status)
    begin

        -- Valeurs par défaut de cmd à définir selon les préférences de chacun
        cmd.ALU_op            <= ALU_plus;
        cmd.LOGICAL_op        <= LOGICAL_and;
        cmd.ALU_Y_sel         <= ALU_Y_immI;

        cmd.SHIFTER_op        <= SHIFT_ra;
        cmd.SHIFTER_Y_sel     <= SHIFTER_Y_rs2;

        cmd.RF_we             <= '0';
        cmd.RF_SIZE_sel       <= RF_SIZE_byte;
        cmd.RF_SIGN_enable    <= '0';
        cmd.DATA_sel          <= DATA_from_pc;

        cmd.PC_we             <= '0';
        cmd.PC_sel            <= PC_from_pc;

        cmd.PC_X_sel          <= PC_X_cst_x00;
        cmd.PC_Y_sel          <= PC_Y_cst_x04;

        cmd.TO_PC_Y_sel       <= TO_PC_Y_cst_x04;

        cmd.AD_we             <= '0';
        cmd.AD_Y_sel          <= AD_Y_immI;

        cmd.IR_we             <= '0';

        cmd.ADDR_sel          <= ADDR_from_pc;
        cmd.mem_we            <= '0';
        cmd.mem_ce            <= '0';

        cmd.cs.CSR_we            <= CSR_none;

        cmd.cs.TO_CSR_sel        <= TO_CSR_from_imm;
        cmd.cs.CSR_sel           <= CSR_from_mcause;
        cmd.cs.MEPC_sel          <= MEPC_from_pc;

        cmd.cs.MSTATUS_mie_set   <= '0';
        cmd.cs.MSTATUS_mie_reset <= '0';

        cmd.cs.CSR_WRITE_mode    <= WRITE_mode_simple;

        state_d <= state_q;

        case state_q is
            when S_Error =>
                -- Etat transitoire en cas d'instruction non reconnue 
                -- Aucune action
                state_d <= S_Init;

            when S_Init =>
                -- PC <- RESET_VECTOR
                cmd.PC_we <= '1';
                cmd.PC_sel <= PC_rstvec;
                state_d <= S_Pre_Fetch;

            when S_Pre_Fetch =>
                -- mem[PC]
                cmd.mem_we   <= '0';
                cmd.mem_ce   <= '1';
                cmd.ADDR_sel <= ADDR_from_pc;
                state_d      <= S_Fetch;

            when S_Fetch =>
                -- IR <- mem_datain
                cmd.IR_we <= '1';
                state_d <= S_Decode;

            when S_Decode =>
                -- On peut aussi utiliser un case, ...
                -- et ne pas le faire juste pour les branchements et auipc
                case status.IR(6 downto 0) is 
                    when "0110111" => -- LUI
                        cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                        cmd.PC_sel <= PC_from_pc;
                        cmd.PC_we <= '1';
                        state_d <= S_LUI;

                    when "0010111" => -- AUIPC
                        state_d <= S_AUIPC;

                    when "0010011" => -- I
                        case status.IR(14 downto 12) is 
                            when "000" => -- ADDI
                                cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                                cmd.PC_sel <= PC_from_pc;
                                cmd.PC_we <= '1';
                                state_d <= S_ADDI;
                            when "001" => -- SLLI
                                cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                                cmd.PC_sel <= PC_from_pc;
                                cmd.PC_we <= '1';
                                state_d <= S_SLLI;
                            when "100" => -- XORI
                                cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                                cmd.PC_sel <= PC_from_pc;
                                cmd.PC_we <= '1';
                                state_d <= S_XORI;
                            when "101" => 
                                case status.IR(31 downto 25) is 
                                    when "0100000" => -- SRAI
                                        cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                                        cmd.PC_sel <= PC_from_pc;
                                        cmd.PC_we <= '1';
                                        state_d <= S_SRAI;
                                    when "0000000" => -- SRLI
                                        cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                                        cmd.PC_sel <= PC_from_pc;
                                        cmd.PC_we <= '1';
                                        state_d <= S_SRLI;
                                    when others => -- Erreur
                                        state_d <= S_Error; -- Pour d ́etecter les rat ́es du d ́ecodage
                                end case;
                            when "110" => -- ORI
                                cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                                cmd.PC_sel <= PC_from_pc;
                                cmd.PC_we <= '1';
                                state_d <= S_ORI;
                            when "111" => -- ANDI
                                cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                                cmd.PC_sel <= PC_from_pc;
                                cmd.PC_we <= '1';
                                state_d <= S_ANDI;
                            when others => -- Erreur
                                state_d <= S_Error; -- Pour d ́etecter les rat ́es du d ́ecodage
                        end case;

                    when "0110011" => -- R
                        case status.IR(14 downto 12) is 
                            when "000" => -- ADD and SUB
                                case status.IR(31 downto 25)is
                                    when "0000000"=> --ADD
                                        cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                                        cmd.PC_sel <= PC_from_pc;
                                        cmd.PC_we <= '1';
                                        state_d <= S_ADD;
                                    when "0100000" => -- SUB
                                        cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                                        cmd.PC_sel <= PC_from_pc;
                                        cmd.PC_we <= '1';
                                        state_d <= S_SUB;
                                    when others => -- Erreur
                                        state_d <= S_Error;
                                end case;
                            when "001" => -- SLL
                                cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                                cmd.PC_sel <= PC_from_pc;
                                cmd.PC_we <= '1';
                                state_d <= S_SLL;
                            when "010" => -- SLT
                                cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                                cmd.PC_sel <= PC_from_pc;
                                cmd.PC_we <= '1';
                                state_d <= S_SLT;
                            when "100" => --XOR
                                cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                                cmd.PC_sel <= PC_from_pc;
                                cmd.PC_we <= '1';
                                state_d <= S_XOR;
                            when "101" => 
                                case status.IR(31 downto 25) is 
                                    when "0000000" => -- SRL
                                        cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                                        cmd.PC_sel <= PC_from_pc;
                                        cmd.PC_we <= '1';
                                        state_d <= S_SRL;
                                    when "0100000" => -- SRA
                                        cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                                        cmd.PC_sel <= PC_from_pc;
                                        cmd.PC_we <= '1';
                                        state_d <= S_SRA;
                                    when others => -- Erreur
                                        state_d <= S_Error; -- Pour d ́etecter les rat ́es du d ́ecodage
                                end case;
                            when "110" => --OR
                                cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                                cmd.PC_sel <= PC_from_pc;
                                cmd.PC_we <= '1';
                                state_d <= S_OR;
                            when "111" => --AND
                                cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                                cmd.PC_sel <= PC_from_pc;
                                cmd.PC_we <= '1';
                                state_d <= S_AND;
                            when others => -- Erreur
                                state_d <= S_Error; -- Pour d ́etecter les rat ́es du d ́ecodage
                        end case;
                    
                    when "1100011" => --B
                        case status.IR(14 downto 12) is
                            when "000" => --beq
                                state_d <= S_BEQ;
                            when others => -- Erreur
                                state_d <= S_Error; -- Pour d ́etecter les rat ́es du d ́ecodage
                    end case;


                    when others => -- Erreur
                        state_d <= S_Error; -- Pour d ́etecter les rat ́es du d ́ecodage
                end case;
---------- Instructions avec immediat de type U ----------
            when S_LUI =>
                -- rd <- ImmU + 0
                cmd.PC_X_sel <= PC_X_cst_x00;
                cmd.PC_Y_sel <= PC_Y_immU;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_pc;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_AUIPC =>
                -- rd <- ImmU + pc
                cmd.PC_X_sel <= PC_X_pc;
                cmd.PC_Y_sel <= PC_Y_immU;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_pc;
                -- PC = PC + 4
                cmd.PC_we <= '1';
                cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                cmd.PC_sel <= PC_from_pc;
                -- next state
                state_d <= S_Pre_Fetch;

---------- Instructions arithmétiques et logiques ----------
            when S_ADDI =>
                -- rd <- rs1 + ImmI
                cmd.ALU_Y_sel <= ALU_Y_immI;
                cmd.ALU_op <= ALU_plus;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_alu;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;
            
            when S_ADD =>
                -- rd <- rs1 + rs2
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.ALU_op <= ALU_plus;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_alu;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;
            
            when S_SUB =>
                -- rd <- rs1 - rs2
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.ALU_op <= ALU_minus;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_alu;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_XORI =>
                -- rd <- rs1 v non ImmI
                cmd.ALU_Y_sel <= ALU_Y_immI;
                cmd.LOGICAL_op <= LOGICAL_xor;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_logical;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_ORI =>
                -- rd <- rs1 v ImmI
                cmd.ALU_Y_sel <= ALU_Y_immI;
                cmd.LOGICAL_op <= LOGICAL_or;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_logical;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_ANDI =>
                -- rd <- rs1 ^ ImmI
                cmd.ALU_Y_sel <= ALU_Y_immI;
                cmd.LOGICAL_op <= LOGICAL_and;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_logical;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_XOR =>
                -- rd <- rs1 v non rs2
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.LOGICAL_op <= LOGICAL_xor;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_logical;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;
            
            when S_OR =>
                -- rd <- rs1 v rs2
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.LOGICAL_op <= LOGICAL_or;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_logical;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_AND =>
                -- rd <- rs1 ^ rs2
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.LOGICAL_op <= LOGICAL_and;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_logical;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_SLT =>
                -- rd <- rs1 comp rs2
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_slt;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_SLL =>
                -- rd <- rs1 shift de rs2
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_rs2;
                cmd.SHIFTER_op <= SHIFT_ll;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_shifter;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_SRL =>
                -- rd <- rs1 shift de rs2
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_rs2;
                cmd.SHIFTER_op <= SHIFT_rl;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_shifter;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_SRA =>
                -- rd <- rs1 shift de rs2
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_rs2;
                cmd.SHIFTER_op <= SHIFT_ra;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_shifter;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_SRAI =>
                -- rd <- rs1 shift de immI
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_ir_sh;
                cmd.SHIFTER_op <= SHIFT_ra;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_shifter;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_SLLI =>
                -- rd <- rs1 shift de rs2
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_ir_sh;
                cmd.SHIFTER_op <= SHIFT_ll;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_shifter;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;

            when S_SRLI =>
                -- rd <- rs1 shift de rs2
                cmd.SHIFTER_Y_sel <= SHIFTER_Y_ir_sh;
                cmd.SHIFTER_op <= SHIFT_rl;
                cmd.RF_we <= '1';
                cmd.DATA_sel <= DATA_from_shifter;
                -- lecture mem[PC]
                cmd.ADDR_sel <= ADDR_from_pc;
                cmd.mem_ce <= '1';
                cmd.mem_we <= '0';
                -- next state
                state_d <= S_Fetch;
                
---------- Instructions de saut ----------
            when S_BEQ =>
                -- rd <- slt(rs1,rs2)
                cmd.ALU_Y_sel <= ALU_Y_rf_rs2;
                cmd.DATA_sel <= DATA_from_slt;
                cmd.RF_we <= '1';
                -- vérification status.JCOND
                if status.JCOND then
                    cmd.TO_PC_Y_sel <= TO_PC_Y_immB;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                else 
                    cmd.TO_PC_Y_sel <= TO_PC_Y_cst_x04;
                    cmd.PC_sel <= PC_from_pc;
                    cmd.PC_we <= '1';
                end if;
                -- next state
                state_d <= S_Pre_Fetch;
                
---------- Instructions de chargement à partir de la mémoire ----------

---------- Instructions de sauvegarde en mémoire ----------

---------- Instructions d'accès aux CSR ----------

            when others => null;
        end case;

    end process FSM_comb;

end architecture;
