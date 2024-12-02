library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity pattern_gen is
  port(
	button : in std_logic;
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
	  fruit_type : in std_logic_vector(2 downto 0);
	  clk : in std_logic;
	  color : out std_logic_vector(5 downto 0)
  );
end component;

type GAMESTATE is (START, FRUIT_1_POS, FRUIT_1_FALLING, FRUIT_2_POS, FRUIT_2_FALLING, HOLD, GAME_OVER);
signal game_state : GAMESTATE := START;

signal fruit_1_tl_row : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal fruit_1_tl_col : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal fruit_1_RGB : std_logic_vector(5 downto 0); -- we will get these values from all the different ROM and compare to decide what to render

signal fruit_2_tl_row : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal fruit_2_tl_col : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal fruit_2_RGB : std_logic_vector(5 downto 0); -- we will get these values from all the different ROM and compare to decide what to render

signal fruit_RGB : std_logic_vector(5 downto 0);


signal fruit_1_row : std_logic_vector (9 downto 0);
signal fruit_1_col : std_logic_vector (9 downto 0);
signal get_row_1 : std_logic_vector (4 downto 0) := "00000";
signal get_col_1 : std_logic_vector (4 downto 0) := "00000";

signal fruit_2_row : std_logic_vector (9 downto 0);
signal fruit_2_col : std_logic_vector (9 downto 0);
signal get_row_2 : std_logic_vector (4 downto 0) := "00000";
signal get_col_2 : std_logic_vector (4 downto 0) := "00000";


signal button_prev : std_logic;
signal falling_counter : unsigned(16 downto 0);

begin
	fruit_1_row <= std_logic_vector(unsigned(row) - fruit_1_tl_row);
	fruit_1_col <= std_logic_vector(unsigned(col) - fruit_1_tl_col);
	
	get_row_1 <= fruit_1_row(4 downto 0) when fruit_1_row(9 downto 5) = "00000" else "11111";
	get_col_1 <= fruit_1_col(4 downto 0) when fruit_1_col(9 downto 5) = "00000" else "11111";
	
	fruit_1 : fruitROM port map(get_row_1 , get_col_1, "000", clk, fruit_1_RGB);
	
	fruit_2_row <= std_logic_vector(unsigned(row) - fruit_2_tl_row);
	fruit_2_col <= std_logic_vector(unsigned(col) - fruit_2_tl_col);
	
	get_row_2 <= fruit_2_row(4 downto 0) when fruit_2_row(9 downto 5) = "00000" else "11111";
	get_col_2 <= fruit_2_col(4 downto 0) when fruit_2_col(9 downto 5) = "00000" else "11111";
	
	fruit_2 : fruitROM port map(get_row_2 , get_col_2, "001", clk, fruit_2_RGB);
	
	fruit_RGB <= fruit_2_RGB when not (fruit_2_RGB = "000000") else fruit_1_RGB;
	
	
	RGB <= "000000" when valid = '0' -- can be changed here and below
			else "001100" when game_state = START
			else "110011" when game_state = GAME_OVER
			else fruit_RGB;
		
	process(clk) begin
		if rising_edge(clk) then
			--if button = '0' and fruit_1_tl_col < 10d"615" then
				--fruit_1_tl_col <= fruit_1_tl_col + 10d"1";
			--end if;
			button_prev <= button;
			
			if game_state = START then
				fruit_1_tl_row <= 10d"0";
				fruit_1_tl_col <= 10d"307";
				fruit_2_tl_row <= 10d"700";
				fruit_2_tl_col <= 10d"700";
				--put every fruit except 1 offscreen
				if button = '0' and button_prev = '1' then
					game_state <= FRUIT_1_POS;
				end if;
			elsif game_state = FRUIT_1_POS then
				if button = '0' and button_prev = '1' then
					game_state <= FRUIT_1_FALLING;
				end if;
			elsif game_state = FRUIT_1_FALLING then
				falling_counter <= falling_counter + 1;
				if falling_counter = 17d"100000" then
					fruit_1_tl_row <= fruit_1_tl_row + 1;
					falling_counter <= 17d"0";
				end if;
				if fruit_1_tl_row > 449 then
					game_state <= FRUIT_2_POS;
					fruit_2_tl_row <= 10d"0";
					fruit_2_tl_col <= 10d"307";
				end if;
			elsif game_state = FRUIT_2_POS then
				if button = '0' and button_prev = '1' then
					game_state <= FRUIT_2_FALLING;
				end if;
			elsif game_state = FRUIT_2_FALLING then
				falling_counter <= falling_counter + 1;
				if falling_counter = 17d"100000" then
					fruit_2_tl_row <= fruit_2_tl_row + 1;
					falling_counter <= 17d"0";
				end if;
				if fruit_2_tl_row > 449 or (fruit_1_RGB /= "000000" and fruit_2_RGB /= "000000") then
					--game_state <= GAME_OVER;
					game_state <= HOLD;
				end if;
			elsif game_state = HOLD then
				game_state <= HOLD;
			elsif game_state = GAME_OVER then
				if button = '0' and button_prev = '1' then
					game_state <= START;
				end if;
			else
				game_state <= START;
			end if;
		end if;
	end process;

end;