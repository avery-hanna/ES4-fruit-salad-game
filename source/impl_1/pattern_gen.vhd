library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity pattern_gen is
  port(
	button : in std_logic_vector(7 downto 0);
	valid : in std_logic;
	row : in std_logic_vector(9 downto 0); -- row of pixel we want to get color for
	col : in std_logic_vector(9 downto 0); -- col of pixel we want to get color for
	clk : in std_logic;
	RGB : out std_logic_vector(5 downto 0);
	led : out std_logic
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

component startscreenROM is
  port(
	  row : in std_logic_vector(7 downto 0);
	  col : in std_logic_vector(7 downto 0);
	  clk : in std_logic;
	  color : out std_logic_vector(5 downto 0)
  );
end component;



signal startscreenRGB : std_logic_vector(5 downto 0);
type GAMESTATE is (START, FRUIT_POS, FRUIT_FALLING, SWAP, RESET, HOLD, GAME_OVER); --SWAP: move offscreen foot to actives location RESET: move active fruit up top
signal game_state : GAMESTATE := START;

signal next_fruit_tl_row : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal next_fruit_tl_col : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal next_fruit_type : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 

signal active_fruit_tl_row : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal active_fruit_tl_col : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal active_fruit_type : unsigned(2 downto 0);
signal active_fruit_RGB : std_logic_vector(5 downto 0); -- we will get these values from all the different ROM and compare to decide what to render
signal active_fruit_row : std_logic_vector (9 downto 0);
signal active_fruit_col : std_logic_vector (9 downto 0);
signal get_row_active : std_logic_vector (4 downto 0) := "00000";
signal get_col_active : std_logic_vector (4 downto 0) := "00000";

signal fruit_1_tl_row : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal fruit_1_tl_col : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal fruit_1_type : unsigned(2 downto 0);
signal fruit_1_RGB : std_logic_vector(5 downto 0); -- we will get these values from all the different ROM and compare to decide what to render
signal fruit_1_row : std_logic_vector (9 downto 0);
signal fruit_1_col : std_logic_vector (9 downto 0);
signal get_row_1 : std_logic_vector (4 downto 0) := "00000";
signal get_col_1 : std_logic_vector (4 downto 0) := "00000";

signal fruit_2_tl_row : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal fruit_2_tl_col : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47  
signal fruit_2_type : unsigned(2 downto 0);
signal fruit_2_RGB : std_logic_vector(5 downto 0); -- we will get these values from all the different ROM and compare to decide what to render
signal fruit_2_row : std_logic_vector (9 downto 0);
signal fruit_2_col : std_logic_vector (9 downto 0);
signal get_row_2 : std_logic_vector (4 downto 0) := "00000";
signal get_col_2 : std_logic_vector (4 downto 0) := "00000";

signal fruit_3_tl_row : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal fruit_3_tl_col : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47  
signal fruit_3_type : unsigned(2 downto 0);
signal fruit_3_RGB : std_logic_vector(5 downto 0); -- we will get these values from all the different ROM and compare to decide what to render
signal fruit_3_row : std_logic_vector (9 downto 0);
signal fruit_3_col : std_logic_vector (9 downto 0);
signal get_row_3 : std_logic_vector (4 downto 0) := "00000";
signal get_col_3 : std_logic_vector (4 downto 0) := "00000";

signal fruit_RGB : std_logic_vector(5 downto 0);


signal button_prev : std_logic_vector(7 downto 0);
signal counter : unsigned(16 downto 0);
signal output: std_logic_vector(7 downto 0);


begin
	led <= '1' when game_state = START else '0';
	
	start_screen : startscreenROM port map(row(9 downto 2), col(9 downto 2), clk, startscreenRGB);
	
	active_fruit_row <= std_logic_vector(unsigned(row) - fruit_1_tl_row);
	active_fruit_col <= std_logic_vector(unsigned(col) - fruit_1_tl_col);
	
	get_row_active <= active_fruit_row(5 downto 1) when active_fruit_row(9 downto 6) = "0000" else "11111";
	get_col_active <= active_fruit_col(5 downto 1) when active_fruit_col(9 downto 6) = "0000" else "11111";
	
	active_fruit : fruitROM port map(get_row_active , get_col_active, std_logic_vector(active_fruit_type), clk, active_fruit_RGB);
	

	fruit_1_row <= std_logic_vector(unsigned(row) - fruit_1_tl_row);
	fruit_1_col <= std_logic_vector(unsigned(col) - fruit_1_tl_col);
	
	get_row_1 <= fruit_1_row(5 downto 1) when fruit_1_row(9 downto 6) = "0000" else "11111";
	get_col_1 <= fruit_1_col(5 downto 1) when fruit_1_col(9 downto 6) = "0000" else "11111";
	
	fruit_1 : fruitROM port map(get_row_1 , get_col_1, std_logic_vector(fruit_1_type), clk, fruit_1_RGB);
	
	fruit_2_row <= std_logic_vector(unsigned(row) - fruit_2_tl_row);
	fruit_2_col <= std_logic_vector(unsigned(col) - fruit_2_tl_col);
	
	get_row_2 <= fruit_2_row(5 downto 1) when fruit_2_row(9 downto 6) = "0000" else "11111";
	get_col_2 <= fruit_2_col(5 downto 1) when fruit_2_col(9 downto 6) = "0000" else "11111";
	
	fruit_2 : fruitROM port map(get_row_2 , get_col_2, std_logic_vector(fruit_2_type), clk, fruit_2_RGB);
	
	fruit_3_row <= std_logic_vector(unsigned(row) - fruit_3_tl_row);
	fruit_3_col <= std_logic_vector(unsigned(col) - fruit_3_tl_col);
	
	get_row_3 <= fruit_3_row(5 downto 1) when fruit_3_row(9 downto 6) = "0000" else "11111";
	get_col_3 <= fruit_3_col(5 downto 1) when fruit_3_col(9 downto 6) = "0000" else "11111";
	
	fruit_3 : fruitROM port map(get_row_3 , get_col_3, std_logic_vector(fruit_3_type), clk, fruit_3_RGB);
	
	
	fruit_RGB <= fruit_3_RGB when (fruit_3_RGB /= "000000") else fruit_2_RGB when (fruit_2_RGB /= "000000") else fruit_1_RGB;
	
	
	RGB <= "000000" when valid = '0' -- can be changed here and below
			else startscreenRGB when game_state = START
			else "110011" when game_state = GAME_OVER
			else fruit_RGB;
		
	process(clk) begin
		if rising_edge(clk) then
			button_prev <= button;
			
			if game_state = START then
				active_fruit_tl_row <= 10d"0";
				active_fruit_tl_col <= 10d"307";
				active_fruit_type <= "000";

				fruit_1_tl_row <= 10d"700";
				fruit_1_tl_col <= 10d"700";
				fruit_1_type <= "001";
				fruit_2_tl_row <= 10d"700";
				fruit_2_tl_col <= 10d"700";
				fruit_2_type <= "000";
				fruit_3_tl_row <= 10d"700";
				fruit_3_tl_col <= 10d"700";
				fruit_3_type <= "000";
				--put every fruit except 1 offscreen
				
				-- move state forward when button = start and button_prev is off
				if button = "11101111" and button_prev = "11111111" then
					game_state <= FRUIT_1_POS;
				end if;

			elsif game_state = FRUIT_POS then
				--Left button pressed
				if button = "11111101" then
					if button_prev = "11111101" then
						counter <= counter + 1;
					else
						counter <= 17d"1";
					end if;
					
					if counter = 17d"100000" then
						if fruit_1_tl_col > 0 then
							fruit_1_tl_col <= fruit_1_tl_col - 1;
						end if;
						counter <= 17d"0";
					end if;
				end if;
				
				 --Right button pressed
				if button = "11111110" then
					if button_prev = "11111110" then
						counter <= counter + 1;
					else
						counter <= 17d"1";
					end if;
					
					if counter = 17d"100000" then
						if fruit_1_tl_col < 576 then
							fruit_1_tl_col <= fruit_1_tl_col + 1;
						end if;
						counter <= 17d"0";
					end if;
				end if;
			
				-- button A pressed
				if button = "01111111" and button_prev = "11111111" then
					game_state <= FRUIT_1_FALLING;
				end if;
			
			elsif game_state = FRUIT_FALLING then
				falling_counter <= falling_counter + 1;
				if falling_counter = 17d"100000" then
					active_fruit_tl_row <= active_fruit_tl_row + 1;
					falling_counter <= 17d"0";
				end if;

				if fruit_1_RGB /= "000000" and active_fruit_RGB /= "000000" then -- collision with fruit 1
					if fruit_1_type = active_fruit_type then
						 -- fruit 1 goes offscreen
						fruit_1_tl_row <= 10d"700";
						fruit_1_tl_col <= 10d"700";
				
						-- active fruit gets fruit 1's position 
						active_fruit_tl_row <= fruit_1_tl_row;
						active_fruit_tl_col <= fruit_1_tl_col;
						
						 -- update active fruit type
						active_fruit_type <= active_fruit_type + 3d"1" when active_fruit_type /= 3d"4" else active_fruit_type;
					else
						game_state <= SWAP;
					end if;
				elsif fruit_2_RGB /= "000000" and active_fruit_RGB /= "000000" then
					if fruit_2_type = active_fruit_type then
						 -- fruit 2 goes offscreen
						fruit_2_tl_row <= 10d"700";
						fruit_2_tl_col <= 10d"700";
				
						-- active fruit gets fruit 2's position 
						active_fruit_tl_row <= fruit_2_tl_row;
						active_fruit_tl_col <= fruit_2_tl_col;
						
						 -- update active fruit type
						active_fruit_type <= active_fruit_type + 3d"1" when active_fruit_type /= 3d"4" else active_fruit_type;
					else
						game_state <= SWAP;
					end if;	
				elsif active_fruit_tl_row > 417 then
					game_state <= SWAP;
					--game_state <= GAME_OVER;
				
				end if;

			elsif game_state = SWAP then
					next_fruit_type <= active_fruit_type
					next_fruit_tl_col <= active_fruit_tl_row
					next_fruit_tl_row <= active_fruit_tl_row
					game_state <= RESET;
			elsif game_state = RESET then
				active_fruit_tl_row <= 10d"0";
				active_fruit_tl_col <= 10d"307";
				active_fruit_type <= "000"; -- TODO update to randomize new fruit type

				--TODO logic for updating next fruit
				game_state <= FRUIT_POS;
			
			elsif game_state = HOLD then
				game_state <= HOLD;
			elsif game_state = GAME_OVER then
				if button /= 8b"0" and button_prev = 8b"0" then
					game_state <= START;
				end if;
			else
				game_state <= START;
			end if;
		end if;
	end process;

end;


