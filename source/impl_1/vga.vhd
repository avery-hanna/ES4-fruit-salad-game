library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga is
  port(
    clk : in std_logic;    
    HSYNC : out std_logic;    
    VSYNC : out std_logic;
	valid : out std_logic;
	row : out std_logic_vector(9 downto 0);
	col : out std_logic_vector(9 downto 0)
	
  );
end entity vga;

architecture synth of vga is

signal horizontal : unsigned (9 downto 0) := "0000000000";
signal vertical : unsigned (9 downto 0) := "0000000000";

begin

process (clk) is
begin
	if rising_edge(clk) then
		if vertical >= 525 then
			horizontal <= "0000000000";
			vertical <= "0000000000";
		
		elsif horizontal <= 799 then
			horizontal <= horizontal + 1;
		
		else
			vertical <= vertical + 1;			
			horizontal <= "0000000000";
		end if;
	end if;
end process;


row <= std_logic_vector(vertical);
col <= std_logic_vector(horizontal);

HSYNC <= '0' when ( horizontal >= 656 AND horizontal < 752) else '1';
VSYNC <= '0' when (vertical >= 490 AND vertical < 492) else '1';

valid <= '0' when ( horizontal >=640 AND horizontal < 800 AND vertical >= 480 AND vertical < 525) else '1';

end;