library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity pattern_gen is
  port(
	valid : in std_logic;
	row : in std_logic_vector(9 downto 0); -- row of pixel we want to get color for
	col : in std_logic_vector(9 downto 0); -- col of pixel we want to get color for
	-- center : in unsigned (4 downto 0); -- 50 wide , 2 to 47
	clk : in std_logic;
	RGB : out std_logic_vector(5 downto 0) -- color for pixel (curr_row, curr_col)
);
end entity pattern_gen;


architecture synth of pattern_gen is
component fruitROM is
  port(
	  row : in unsigned(4 downto 0);
	  col : in unsigned(4 downto 0);
	  fruit_color : in std_logic_vector(5 downto 0);
	  clk : in std_logic;
	  color : out std_logic_vector(5 downto 0)
  );
end component;
signal fruit_1_tl_row : unsigned (4 downto 0) := "00000"; -- TODO update: 50 wide , 2 to 47 
signal fruit_1_tl_col : unsigned (4 downto 0) := "00000"; -- TODO update: 50 wide , 2 to 47 
signal fruit_1_RGB : unsigned (5 downto 0); -- we will get these values from all the different ROM and compare to decide what to render
-- signal fruit : unsigned;
-- type COLOR is (BLUEBERRY, CHERRY, ORANGE, GRAPEFRUIT , WATERMELLON);
-- signal color : COLOR := BLUEBERRY;

begin
	--center <= "00111";

	fruit_1 : fruitROM port map(row - fruit_1_tl_row , col - fruit_1_tl_col, "100000", clk, fruit_1_RGB);
	
	
	RGB <= "000000" when valid = '0' -- can be changed here and below
		else fruit_1_RGB;
	--	else "111111" when unsigned(col) = center and unsigned(row) < 100 else "000000"; -- gives a random line

end;


--rgb <= "000000" when valid = '0' -- can be changed here and below
	--else "111111" when unsigned(col)
	--< 320 and unsigned(row) < 100
	--else "000000";