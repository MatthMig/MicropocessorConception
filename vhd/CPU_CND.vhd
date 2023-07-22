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
    signal x, y, s: unsigned(32 downto 0);
    signal signe,z: std_logic;
begin
    signe <= ((not IR(12)) and (not IR(6))) or (IR(6) and (not IR(13)));
    x <= (signe and rs1(31)) & rs1;
    y <= (signe and alu_y(31)) & alu_y;

    s <= x - y;
    Z <= '1' when s = "000000000000000000000000000000000" else '0';

    slt <= s(32);
    jcond <= ((Z xor IR(12)) and (not IR(14))) or ((s(32) xor IR(12)) and IR(14));
end architecture;
