library IEEE;
use IEEE.std_logic_1164.all;

entity lfsr4 is
  port(
	  clk : in std_logic;
	  color : out std_logic_vector(23 downto 0)
  );
end lfsr4;


architecture synth of lfsr4 is

signal count: std_logic_vector(2 downto 0);
signal R3: std_logic;
signal R2: std_logic;
signal R1: std_logic;
signal R0: std_logic;
begin
  process(clk, reset) begin
    if rising_edge(clk) then
        if (reset='1') then
        R3 <= '0';
        R2 <= '0';
        R1 <= '0';
        R0 <= '1';
    else
        R3 <= R0;
        R2 <= R3 xor R0;
        R1 <= R2;
        R0 <= R1;
    end if;
    end if;
  end process;
  count <= R3 & R2 & R1 & R0;
  color <= x"4F86F7" when count = "001" or count = "010" --blue
  else x"9A072D" when count = "011" or "110"--red
  else x"FFC0CB" when count = "100"--pink
  else x"F18D0B" when count = "101" --orange
  else x"46FD8F" when count = "111" --green;
end;