library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity score_display is
  port(
    score : in unsigned(5 downto 0);
	row : in std_logic_vector(9 downto 0);
	col : in std_logic_vector(9 downto 0);
	clk : in std_logic;
	score_col_RGB : out std_logic_vector(5 downto 0)
  );
end score_display;

architecture synth of score_display is
component dddd is
  port(
    value : in unsigned(5 downto 0);    
    tensdigit : out std_logic_vector(3 downto 0);    
    onesdigit : out std_logic_vector(3 downto 0)
  );
end component;

component digitROM is
  port(
	  digit: in std_logic_vector(3 downto 0);
	  row : in std_logic_vector(2 downto 0);
	  col : in std_logic_vector(2 downto 0);
	  clk : in std_logic;
	  color : out std_logic
  );
end component;

signal score_tens_digit : std_logic_vector(3 downto 0);
signal score_ones_digit : std_logic_vector(3 downto 0);
signal score_row : std_logic_vector(9 downto 0);
signal score_col : std_logic_vector(9 downto 0);
signal score_color_tens : std_logic;
signal score_color_ones : std_logic;

begin
	dddd_instance : dddd port map(score, score_tens_digit, score_ones_digit);
	
	score_row <= std_logic_vector(unsigned(row) - 10d"20");
	score_col <= std_logic_vector(unsigned(col) - 10d"10");
	
	ones_place_rom : digitROM port map(score_ones_digit, score_row(4 downto 2), score_col(4 downto 2), clk, score_color_ones);
	tens_place_rom : digitROM port map(score_tens_digit, score_row(4 downto 2), score_col(4 downto 2), clk, score_color_tens);
	
	score_col_RGB <= ("111111" when score_color_tens = '1' else "000000") when row >= 10d"20" and row < 10d"52" and col >= 10d"10" and col < 10d"42"
					  else ("111111" when score_color_ones = '1' else "000000") when row >= 10d"20" and row < 10d"52" and col >= 10d"42" and col < 10d"74"
					  else "000000";
end;
