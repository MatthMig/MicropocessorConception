library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.PKG.all;

entity CPU_CND is
    generic (
        mutant      : integer := 0
    );
    port (
        rs1         : in w32;
        alu_y       : in w32;
        IR          : in w32;
        slt         : out std_logic;
        jcond       : out std_logic
    );
end entity;

architecture RTL of CPU_CND is
    signal x, y: unsigned(32 downto 0);
    signal side_val: std_logic;
    signal Z, S: std_logic;
begin
    -- Valeurs par défaut pour le passage sur carte, à remplacer
    jcond <= '0';
    slt <= '0';

    side_val <= (not(IR(12)) and not(IR(6))) or (IR(6) and not(IR(13)));
    x(31 downto 0) <= rs1(31 downto 0);
    x(32) <= side_val;

    y(31 downto 0) <= alu_y(31 downto 0);
    y(32) <= side_val;

    Z <= '1' when x=1 else '0';

    S <= '1' when x<y else '0';

    slt <= S;
    jcond <= ((Z xor IR(12)) and not(IR(14))) or ((S xor IR(12)) and IR(14));
end architecture;
