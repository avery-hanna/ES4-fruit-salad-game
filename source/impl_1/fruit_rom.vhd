library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fruitROM is
  port(
	  row : in std_logic_vector(3 downto 0);
	  col : in std_logic_vector(3 downto 0);
	  fruit_type : in std_logic_vector(2 downto 0);
	  clk : in std_logic;
	  color : out std_logic_vector(5 downto 0)
  );
end fruitROM;

architecture synth of fruitROM is 

component blueberryCherryROM is
  port(
	  fruit_type : in std_logic;
	  row : in std_logic_vector(3 downto 0);
	  col : in std_logic_vector(3 downto 0);
	  clk : in std_logic;
	  color : out std_logic_vector(5 downto 0)
  );
end component;
--component grapefruitROM is
  --port(
	  --row : in std_logic_vector(4 downto 0);
	  --col : in std_logic_vector(4 downto 0);
	  --clk : in std_logic;
	  --color : out std_logic_vector(5 downto 0)
  --);
--end component;
--component orangeROM is
  --port(
	  --row : in std_logic_vector(4 downto 0);
	  --col : in std_logic_vector(4 downto 0);
	  --clk : in std_logic;
	  --color : out std_logic_vector(5 downto 0)
  --);
--end component;
component watermelonROM is
  port(
	  row : in std_logic_vector(3 downto 0);
	  col : in std_logic_vector(3 downto 0);
	  clk : in std_logic;
	  color : out std_logic_vector(5 downto 0)
  );
end component;


-- TODO intermediate signal for rom output which is 3 bits encoding of color
-- TODO intermediate rom address signal which is fruit type, row, col concatenated

signal blueberryRGB : std_logic_vector(5 downto 0);
signal cherryRGB : std_logic_vector(5 downto 0);
signal grapefruitRGB : std_logic_vector(5 downto 0);
signal orangeRGB : std_logic_vector(5 downto 0);
signal watermelonRGB : std_logic_vector(5 downto 0);

begin


	blueberryCherry : blueberryCherryROM port map('0' when fruit_type = "000" else '1', row , col, clk, blueberryRGB);
	--cherry : cherryROM port map(row , col, clk, cherryRGB);
	--grapefruit : grapefruitROM port map(row , col, clk, grapefruitRGB);
	--orange : orangeROM port map(row , col, clk, orangeRGB);
	watermelon : watermelonROM port map(row , col, clk, watermelonRGB);
	
	process(clk) is
	begin
		if rising_edge(clk) then
			-- TODO fruit rom with case statements and address
		end if;
	end process;
	
	-- TODO outside of process, combinational logic that translates from fruit_type signal and rom_output signal into 6 bit RGB output of final color output
end;