library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM is
  port(
	  row : in std_logic_vector(4 downto 0);  
    col : in std_logic_vector(4 downto 0);  
    fruit_color : in std_logic_vector(23 downto 0);
	  clk : in std_logic;
	  color : out std_logic_vector(23 downto 0)
  );
end ROM;

architecture synth of ROM is 
signal address : std_logic_vector(18 downto 0);
begin
	process(clk) is
	begin
		if rising_edge(clk) then
			color <= 24d"0" when 
		end if;
	end process;
end;
