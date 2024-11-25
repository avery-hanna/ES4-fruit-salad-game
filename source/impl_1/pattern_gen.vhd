library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity pattern_gen is
  port(
	valid : in std_logic;
	row : in std_logic_vector(9 downto 0); -- row of pixel we want to get color for
	col : in std_logic_vector(9 downto 0); -- col of pixel we want to get color for
	clk : in std_logic;
	RGB : out std_logic_vector(5 downto 0) -- color for pixel (curr_row, curr_col)
);
end entity pattern_gen;


architecture synth of pattern_gen is
component fruitROM is
  port(
	  row : in std_logic_vector(4 downto 0);
	  col : in std_logic_vector(4 downto 0);
	  fruit_color : in std_logic_vector(5 downto 0);
	  clk : in std_logic;
	  color : out std_logic_vector(5 downto 0)
  );
end component;
signal fruit_1_tl_row : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal fruit_1_tl_col : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal fruit_1_RGB : std_logic_vector(5 downto 0); -- we will get these values from all the different ROM and compare to decide what to render


-- signal fruit : unsigned;
-- type COLOR is (BLUEBERRY, CHERRY, ORANGE, GRAPEFRUIT , WATERMELLON);
-- signal color : COLOR := BLUEBERRY;



signal fruit_row : std_logic_vector (9 downto 0);
signal fruit_col : std_logic_vector (9 downto 0);
signal get_row : std_logic_vector (4 downto 0) := "00000";
signal get_col : std_logic_vector (4 downto 0) := "00000";
signal valid_pos : std_logic;

begin
	fruit_1_tl_row <= 10d"300";
	fruit_1_tl_col <= 10d"500";

	fruit_row <= std_logic_vector(unsigned(row) - fruit_1_tl_row);
	fruit_col <= std_logic_vector(unsigned(col) - fruit_1_tl_col);
	
	get_row <= fruit_row(4 downto 0) when fruit_row(9 downto 5) = "00000" else "11111";
	get_col <= fruit_col(4 downto 0) when fruit_col(9 downto 5) = "00000" else "11111";

	
	fruit_1 : fruitROM port map(get_row , get_col, "100000", clk, fruit_1_RGB);
	
	
	RGB <= "000000" when valid = '0' -- can be changed here and below
		else fruit_1_RGB;
		--else "110000"; -- gives a random line

end;