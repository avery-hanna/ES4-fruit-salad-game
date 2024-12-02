library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fruitROM is
  port(
	  row : in std_logic_vector(4 downto 0);
	  col : in std_logic_vector(4 downto 0);
	  fruit_type : in std_logic_vector(2 downto 0);
	  clk : in std_logic;
	  color : out std_logic_vector(5 downto 0)
  );
end fruitROM;

architecture synth of fruitROM is 

component blueberryROM is
  port(
	  row : in std_logic_vector(4 downto 0);
	  col : in std_logic_vector(4 downto 0);
	  clk : in std_logic;
	  color : out std_logic_vector(5 downto 0)
  );
end component;
component grapefruitROM is
  port(
	  row : in std_logic_vector(4 downto 0);
	  col : in std_logic_vector(4 downto 0);
	  clk : in std_logic;
	  color : out std_logic_vector(5 downto 0)
  );
end component;
signal blueberryRGB : std_logic_vector(5 downto 0);
signal grapefruitRGB : std_logic_vector(5 downto 0);

begin
	blueberry : blueberryROM port map(row , col, clk, blueberryRGB);
	grapefruit : grapefruitROM port map(row , col, clk, grapefruitRGB);
	
	process(clk) is
	begin
		if rising_edge(clk) then
			case fruit_type is 
				when "000" => 
					color <= blueberryRGB;
				when others =>
					color <= grapefruitRGB;
			end case;
		end if;
	end process;
end;