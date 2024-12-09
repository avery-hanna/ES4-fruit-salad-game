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
	gameclock: in std_logic;
	RGB : out std_logic_vector(5 downto 0);
	led : out std_logic
);
end entity pattern_gen;


architecture synth of pattern_gen is
component fruitROM is
  port(
	  row : in std_logic_vector(3 downto 0);
	  col : in std_logic_vector(3 downto 0);
	  fruit_type : in std_logic_vector(1 downto 0);
	  clk : in std_logic;
	  color : out std_logic_vector(5 downto 0)
  );
end component;

component getRandomFruit is
	port(
		clk: in std_logic;
		fruitout: out unsigned(1 downto 0);
		reset: in std_logic
	);
end component;
	
	

component startscreenROM is
  port(
	  row : in std_logic_vector(4 downto 0);
	  col : in std_logic_vector(6 downto 0);
	  clk : in std_logic;
	  color : out std_logic_vector(5 downto 0)
  );
end component;

type GAMESTATE is (START, FRUIT_POS, FRUIT_FALLING, SWAP, GAME_OVER, FALL_LOOP, START_FRUIT);
signal game_state : GAMESTATE := START;

signal swap_fruit : integer;
signal falloop_counter: unsigned(4 downto 0);

signal startscreenRGB : std_logic_vector(5 downto 0);
signal flashstartscreenRGB : std_logic_vector(5 downto 0);

signal active_fruit_tl_row : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal active_fruit_tl_col : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal active_fruit_type : unsigned(1 downto 0);
signal active_fruit_RGB : std_logic_vector(5 downto 0); -- we will get these values from all the different ROM and compare to decide what to render
signal active_fruit_relative_row : std_logic_vector (9 downto 0);
signal active_fruit_relative_col : std_logic_vector (9 downto 0);
signal active_fruit_rom_row : std_logic_vector (3 downto 0);
signal active_fruit_rom_col : std_logic_vector (3 downto 0);

signal clock_counter: unsigned (1 downto 0);
signal score: unsigned(5 downto 0);

signal reset_random : std_logic;

constant NUM_FRUITS : integer := 15;

type unsigned_coord_array is array(1 to NUM_FRUITS) of unsigned(9 downto 0);
type type_array is array(1 to NUM_FRUITS) of unsigned(1 downto 0);
type rgb_array is array(1 to NUM_FRUITS) of std_logic_vector(5 downto 0);
type vector_coord_array is array(1 to NUM_FRUITS) of std_logic_vector(9 downto 0);
type rom_coord_array is array(1 to NUM_FRUITS) of std_logic_vector(3 downto 0);

signal fruit_tl_row : unsigned_coord_array;
signal fruit_tl_col : unsigned_coord_array;
signal fruit_type : type_array;
signal fruit_rgb_vals : rgb_array;
signal fruit_relative_row : vector_coord_array;
signal fruit_relative_col : vector_coord_array;
signal fruit_rom_row : rom_coord_array;
signal fruit_rom_col : rom_coord_array;

signal fruit_RGB : std_logic_vector(5 downto 0);


signal button_prev : std_logic_vector(7 downto 0);
signal counter : unsigned(16 downto 0);
signal output: std_logic_vector(7 downto 0);


signal startscreenrow: std_logic_vector(4 downto 0);
signal startscreencol: std_logic_vector(6 downto 0);

signal flash_startscreenrow: std_logic_vector(4 downto 0);
signal flash_startscreencol: std_logic_vector(6 downto 0);

signal startscreen_relativerow: std_logic_vector(9 downto 0);
signal startscreen_relativecol: std_logic_vector(9 downto 0);
signal startloop_counter: unsigned(4 downto 0);

signal startscreen_flashrow: std_logic_vector(9 downto 0);
signal startscreen_flashcol: std_logic_vector(9 downto 0);

--signal flashing_screen_RGB : std_logic_vector(5 downto 0);
signal flashingstart_counter : unsigned(23 downto 0);
signal randomoutput: unsigned(1 downto 0);

--signal flashing_screen_RGB : std_logic_vector(5 downto 0);
signal flashing_counter : unsigned(23 downto 0);

--signal randomoutput: unsigned(1 downto 0);


begin
	led <= '1' when game_state = GAME_OVER else '0';
	
	startscreen_relativerow <= std_logic_vector(unsigned(row) - "001011000"); 
	startscreen_relativecol <= std_logic_vector(unsigned(col) - "001000100");
	
	startscreen_flashrow <= std_logic_vector(unsigned(row) - "001000000"); 
	startscreen_flashcol <= std_logic_vector(unsigned(col) - "000111000");

	startscreenrow <= startscreen_relativerow(7 downto 3) when startscreen_relativerow(9 downto 8)="00" 
	else "00000";
	
	startscreencol <= startscreen_relativecol(8 downto 2) when startscreen_relativecol(9)='0' 
	else "0000000";
	
	flash_startscreenrow <= startscreen_flashrow(7 downto 3) when startscreen_flashrow(9 downto 8)="00" 
	else "00000";
	
	flash_startscreencol <= startscreen_relativecol(8 downto 2) when startscreen_relativecol(9)='0' 
	else "0000000";
	
	start_screen : startscreenROM port map(startscreenrow, startscreencol, clk, startscreenRGB);
	flashstart_screen : startscreenROM port map(flash_startscreenrow,flash_startscreencol, clk, flashstartscreenRGB);
	
	active_fruit_relative_row <= std_logic_vector(unsigned(row) - active_fruit_tl_row);
	active_fruit_relative_col <= std_logic_vector(unsigned(col) - active_fruit_tl_col);
	
	active_fruit_rom_row <= active_fruit_relative_row(5 downto 2) when active_fruit_relative_row(9 downto 6) = "0000" else "1111";
	active_fruit_rom_col <= active_fruit_relative_col(5 downto 2) when active_fruit_relative_col(9 downto 6) = "0000" else "1111";
	
	active_fruit : fruitROM port map(active_fruit_rom_row , active_fruit_rom_col, std_logic_vector(active_fruit_type), clk, active_fruit_RGB);
	
						
	gen_fruit_roms: for i in 1 to NUM_FRUITS generate
        fruit_rom_instance: fruitROM port map (
            fruit_rom_row(i),
            fruit_rom_col(i),
            std_logic_vector(fruit_type(i)),
            clk,
            fruit_rgb_vals(i)
        );
    end generate gen_fruit_roms;

	randomfruit: getRandomFruit 
		port map
			( clk => clk, 
			fruitout => randomoutput, 
			reset => reset_random
		);
		


    process begin
			for i in 1 to NUM_FRUITS loop
				fruit_relative_row(i) <= std_logic_vector(unsigned(row) - fruit_tl_row(i));
				fruit_relative_col(i) <= std_logic_vector(unsigned(col) - fruit_tl_col(i));

				fruit_rom_row(i) <= fruit_relative_row(i)(5 downto 2) when fruit_relative_row(i)(9 downto 6) = "0000" else "1111";
				fruit_rom_col(i) <= fruit_relative_col(i)(5 downto 2) when fruit_relative_col(i)(9 downto 6) = "0000" else "1111";
			end loop;
    end process;
	
	--fruit_RGB <= active_fruit_RGB when (active_fruit_RGB /= "000000") else fruit_3_RGB when (fruit_3_RGB /= "000000") else fruit_2_RGB when (fruit_2_RGB /= "000000") else fruit_1_RGB;
	
	fruit_RGB <= active_fruit_RGB when (active_fruit_RGB /= "000000")
				 else fruit_rgb_vals(10) when (fruit_rgb_vals(10) /= "000000")
				 else fruit_rgb_vals(9) when (fruit_rgb_vals(9) /= "000000")
				 else fruit_rgb_vals(8) when (fruit_rgb_vals(8) /= "000000")
				 else fruit_rgb_vals(7) when (fruit_rgb_vals(7) /= "000000")
				 else fruit_rgb_vals(6) when (fruit_rgb_vals(6) /= "000000")
				 else fruit_rgb_vals(5) when (fruit_rgb_vals(5) /= "000000")
				 else fruit_rgb_vals(4) when (fruit_rgb_vals(4) /= "000000")
				 else fruit_rgb_vals(3) when (fruit_rgb_vals(3) /= "000000")
				 else fruit_rgb_vals(2) when (fruit_rgb_vals(2) /= "000000")
				 else fruit_rgb_vals(1);
	
	RGB <= "000000" when valid = '0' -- can be changed here and below
			else  flashstartscreenRGB when (flashingstart_counter(6)='0' and game_state=START) 
			else startscreenRGB when (game_state = START and flashingstart_counter(6)='1')
			else ("000000" when flashing_counter(23) = '0' else fruit_RGB) when game_state = GAME_OVER
			else fruit_RGB;

		
	process(gameclock) begin
		if rising_edge(gameclock) then
			--clock_counter <= clock_counter + 1;
			--if clock_counter = "01" then
				--clock_counter <= "00";
				button_prev <= button;
				
				if game_state = START then
					-- Position active fruit in center of top row of screen
					active_fruit_tl_row <= 10d"0";
					active_fruit_tl_col <= 10d"307";
					flashingstart_counter <= flashingstart_counter + 1;
					startloop_counter <= 5d"1";
			
					reset_random <= '1';
					
					score <= 5d"0";

					active_fruit_type <= randomoutput;
					
					-- Position other fruits at bottom of screen
					fruit_tl_row(1) <= 10d"400";
					fruit_tl_col(1) <= 10d"10";
					fruit_tl_row(2) <= 10d"400";
					fruit_tl_col(2) <= 10d"80";
					fruit_tl_row(3) <= 10d"400";
					fruit_tl_col(3) <= 10d"150";
					fruit_tl_row(4) <= 10d"400";
					fruit_tl_col(4) <= 10d"410";
					--for i in 1 to NUM_FRUITS loop
						--fruit_tl_row(i) <= 10d"700";
						--fruit_tl_col(i) <= 10d"700";
					--end loop;
					swap_fruit <= 1;
					
					-- move state forward when button = start and button_prev is off
					if button(4) = '0' and button_prev = "11111111" then
						--game_state <= FRUIT_POS;
						game_state <= START_FRUIT;
					end if;
				elsif game_state = START_FRUIT then
					fruit_tl_row(to_integer(startloop_counter)) <= 10d"700";
					fruit_tl_col(to_integer(startloop_counter)) <= 10d"700";
					startloop_counter <= startloop_counter + 5d"1";
					if startloop_counter = NUM_FRUITS then
						game_state <= FRUIT_POS;
					end if;
				elsif game_state = FRUIT_POS then
					 --Left button pressed
					if button(1) = '0' then
						if button_prev(1) = '0' then
							counter <= counter + 1;
						else
							counter <= 17d"1";
						end if;
						
						if counter = 17d"0" then
							if active_fruit_tl_col > 0 then
								active_fruit_tl_col <= active_fruit_tl_col - 1;
							end if;
							counter <= 17d"0";
						end if;
					end if;
					
					 --Right button pressed
					if button(0) = '0' then
						if button_prev(0) = '0' then
							counter <= counter + 1;
						else
							counter <= 17d"1";
						end if;
						
						if counter = 17d"0" then
							if active_fruit_tl_col < 576 then
								active_fruit_tl_col <= active_fruit_tl_col + 1;
							end if;
							counter <= 17d"0";
						end if;
					end if;
				
					-- button A pressed - drop
					if button(7) = '0' and button_prev = "11111111" then
						game_state <= FRUIT_FALLING;
					end if;
				elsif game_state = FRUIT_FALLING then
					-- Falling counter logic
					counter <= counter + 1;
					if counter = 17d"0" then
						active_fruit_tl_row <= active_fruit_tl_row + 2;
						counter <= 17d"0";
						
						
					end if;
					--game_state <= FALL_LOOP;
					falloop_counter <= 5d"1";

					if active_fruit_tl_row < 417 then
						game_state <= FALL_LOOP;
					elsif active_fruit_tl_row > 417 then -- fruit has reached bottom row without collisions
						fruit_tl_row(swap_fruit) <= active_fruit_tl_row;
						fruit_tl_col(swap_fruit) <= active_fruit_tl_col;
						fruit_type(swap_fruit) <= active_fruit_type;
						score <= score + 5d"1";
						game_state <= SWAP;
					--else game_state <= FALL_LOOP;
					end if;
					
					
				elsif game_state = FALL_LOOP then
					if fruit_rgb_vals(1) /= "000000" and active_fruit_RGB /= "000000" then -- collision
						if fruit_type(1) = active_fruit_type then
							-- fruit goes offscreen
							fruit_tl_row(1) <= 10d"700";
							fruit_tl_col(1) <= 10d"700";
					
							-- active fruit gets fruit 1's position
							active_fruit_tl_row <= fruit_tl_row(1);
							active_fruit_tl_col <= fruit_tl_col(1);
							
							
							--active_fruit_tl_row <= 10d"200";
							--active_fruit_tl_col <= 10d"200";
							
								-- update active fruit type
							active_fruit_type <= active_fruit_type + 2d"1" when active_fruit_type /= 2d"3" else active_fruit_type;
							game_state <= FRUIT_FALLING;
							else
							fruit_tl_row(swap_fruit) <= active_fruit_tl_row;
							fruit_tl_col(swap_fruit) <= active_fruit_tl_col;
							fruit_type(swap_fruit) <= active_fruit_type;
							score <= score + 5d"3";
							game_state <= SWAP;
						end if;
							
					elsif fruit_rgb_vals(2) /= "000000" and active_fruit_RGB /= "000000" then -- collision
						if fruit_type(2) = active_fruit_type then
							-- fruit goes offscreen
							fruit_tl_row(2) <= 10d"700";
							fruit_tl_col(2) <= 10d"700";
					
							-- active fruit gets fruit 1's position
							active_fruit_tl_row <= fruit_tl_row(2);
							active_fruit_tl_col <= fruit_tl_col(2);
							
							
							--active_fruit_tl_row <= 10d"200";
							--active_fruit_tl_col <= 10d"200";
							
								-- update active fruit type
							active_fruit_type <= active_fruit_type + 2d"1" when active_fruit_type /= 2d"3" else active_fruit_type;
							game_state <= FRUIT_FALLING;
						else
							fruit_tl_row(swap_fruit) <= active_fruit_tl_row;
							fruit_tl_col(swap_fruit) <= active_fruit_tl_col;
							fruit_type(swap_fruit) <= active_fruit_type;
							score <= score + 5d"3";
							game_state <= SWAP;
						end if;
						
						elsif fruit_rgb_vals(3) /= "000000" and active_fruit_RGB /= "000000" then -- collision
						if fruit_type(3) = active_fruit_type then
							-- fruit goes offscreen
							fruit_tl_row(3) <= 10d"700";
							fruit_tl_col(3) <= 10d"700";
					
							-- active fruit gets fruit 1's position
							active_fruit_tl_row <= fruit_tl_row(3);
							active_fruit_tl_col <= fruit_tl_col(3);
							
							
							--active_fruit_tl_row <= 10d"200";
							--active_fruit_tl_col <= 10d"200";
							
								-- update active fruit type
							active_fruit_type <= active_fruit_type + 2d"1" when active_fruit_type /= 2d"3" else active_fruit_type;
							game_state <= FRUIT_FALLING;
						else
							fruit_tl_row(swap_fruit) <= active_fruit_tl_row;
							fruit_tl_col(swap_fruit) <= active_fruit_tl_col;
							fruit_type(swap_fruit) <= active_fruit_type;
							score <= score + 5d"3";
							game_state <= SWAP;
						end if;
							elsif fruit_rgb_vals(4) /= "000000" and active_fruit_RGB /= "000000" then -- collision
						if fruit_type(4) = active_fruit_type then
							-- fruit goes offscreen
							fruit_tl_row(4) <= 10d"700";
							fruit_tl_col(4) <= 10d"700";
					
							-- active fruit gets fruit 1's position
							active_fruit_tl_row <= fruit_tl_row(4);
							active_fruit_tl_col <= fruit_tl_col(4);
							
							
							--active_fruit_tl_row <= 10d"200";
							--active_fruit_tl_col <= 10d"200";
							
								-- update active fruit type
							active_fruit_type <= active_fruit_type + 2d"1" when active_fruit_type /= 2d"3" else active_fruit_type;
							game_state <= FRUIT_FALLING;
						else
							fruit_tl_row(swap_fruit) <= active_fruit_tl_row;
							fruit_tl_col(swap_fruit) <= active_fruit_tl_col;
							fruit_type(swap_fruit) <= active_fruit_type;
							score <= score + 5d"3";
							game_state <= SWAP;
						end if;
							elsif fruit_rgb_vals(5) /= "000000" and active_fruit_RGB /= "000000" then -- collision
						if fruit_type(5) = active_fruit_type then
							-- fruit goes offscreen
							fruit_tl_row(5) <= 10d"700";
							fruit_tl_col(5) <= 10d"700";
					
							-- active fruit gets fruit 1's position
							active_fruit_tl_row <= fruit_tl_row(5);
							active_fruit_tl_col <= fruit_tl_col(5);
							
							
							--active_fruit_tl_row <= 10d"200";
							--active_fruit_tl_col <= 10d"200";
							
								-- update active fruit type
							active_fruit_type <= active_fruit_type + 2d"1" when active_fruit_type /= 2d"3" else active_fruit_type;
							game_state <= FRUIT_FALLING;
						else
							fruit_tl_row(swap_fruit) <= active_fruit_tl_row;
							fruit_tl_col(swap_fruit) <= active_fruit_tl_col;
							fruit_type(swap_fruit) <= active_fruit_type;
							score <= score + 5d"3";
							game_state <= SWAP;
						end if;
						
							elsif fruit_rgb_vals(6) /= "000000" and active_fruit_RGB /= "000000" then -- collision
						if fruit_type(6) = active_fruit_type then
							-- fruit goes offscreen
							fruit_tl_row(6) <= 10d"700";
							fruit_tl_col(6) <= 10d"700";
					
							-- active fruit gets fruit 1's position
							active_fruit_tl_row <= fruit_tl_row(6);
							active_fruit_tl_col <= fruit_tl_col(6);
							
							
							--active_fruit_tl_row <= 10d"200";
							--active_fruit_tl_col <= 10d"200";
							
								-- update active fruit type
							active_fruit_type <= active_fruit_type + 2d"1" when active_fruit_type /= 2d"3" else active_fruit_type;
							game_state <= FRUIT_FALLING;
						else
							fruit_tl_row(swap_fruit) <= active_fruit_tl_row;
							fruit_tl_col(swap_fruit) <= active_fruit_tl_col;
							fruit_type(swap_fruit) <= active_fruit_type;
							score <= score + 5d"3";
							game_state <= SWAP;
						end if;
							elsif fruit_rgb_vals(7) /= "000000" and active_fruit_RGB /= "000000" then -- collision
						if fruit_type(7) = active_fruit_type then
							-- fruit goes offscreen
							fruit_tl_row(7) <= 10d"700";
							fruit_tl_col(7) <= 10d"700";
					
							-- active fruit gets fruit 1's position
							active_fruit_tl_row <= fruit_tl_row(7);
							active_fruit_tl_col <= fruit_tl_col(7);
							
							
							--active_fruit_tl_row <= 10d"200";
							--active_fruit_tl_col <= 10d"200";
							
								-- update active fruit type
							active_fruit_type <= active_fruit_type + 2d"1" when active_fruit_type /= 2d"3" else active_fruit_type;
							game_state <= FRUIT_FALLING;
						else
							fruit_tl_row(swap_fruit) <= active_fruit_tl_row;
							fruit_tl_col(swap_fruit) <= active_fruit_tl_col;
							fruit_type(swap_fruit) <= active_fruit_type;
							score <= score + 5d"3";
							game_state <= SWAP;
						end if;
							elsif fruit_rgb_vals(9) /= "000000" and active_fruit_RGB /= "000000" then -- collision
						if fruit_type(9) = active_fruit_type then
							-- fruit goes offscreen
							fruit_tl_row(9) <= 10d"700";
							fruit_tl_col(9) <= 10d"700";
					
							-- active fruit gets fruit 1's position
							active_fruit_tl_row <= fruit_tl_row(9);
							active_fruit_tl_col <= fruit_tl_col(9);
							
							
							--active_fruit_tl_row <= 10d"200";
							--active_fruit_tl_col <= 10d"200";
							
								-- update active fruit type
							active_fruit_type <= active_fruit_type + 2d"1" when active_fruit_type /= 2d"3" else active_fruit_type;
							game_state <= FRUIT_FALLING;
						else
							fruit_tl_row(swap_fruit) <= active_fruit_tl_row;
							fruit_tl_col(swap_fruit) <= active_fruit_tl_col;
							fruit_type(swap_fruit) <= active_fruit_type;
							score <= score + 5d"3";
							game_state <= SWAP;
						end if;
							elsif fruit_rgb_vals(8) /= "000000" and active_fruit_RGB /= "000000" then -- collision
						if fruit_type(8) = active_fruit_type then
							-- fruit goes offscreen
							fruit_tl_row(8) <= 10d"700";
							fruit_tl_col(8) <= 10d"700";
					
							-- active fruit gets fruit 1's position
							active_fruit_tl_row <= fruit_tl_row(8);
							active_fruit_tl_col <= fruit_tl_col(8);
							
							
							--active_fruit_tl_row <= 10d"200";
							--active_fruit_tl_col <= 10d"200";
							
								-- update active fruit type
							active_fruit_type <= active_fruit_type + 2d"1" when active_fruit_type /= 2d"3" else active_fruit_type;
							game_state <= FRUIT_FALLING;
						else
							fruit_tl_row(swap_fruit) <= active_fruit_tl_row;
							fruit_tl_col(swap_fruit) <= active_fruit_tl_col;
							fruit_type(swap_fruit) <= active_fruit_type;
							score <= score + 5d"3";
							game_state <= SWAP;
						end if;
							elsif fruit_rgb_vals(10) /= "000000" and active_fruit_RGB /= "000000" then -- collision
						if fruit_type(10) = active_fruit_type then
							-- fruit goes offscreen
							fruit_tl_row(10) <= 10d"700";
							fruit_tl_col(10) <= 10d"700";
					
							-- active fruit gets fruit 1's position
							active_fruit_tl_row <= fruit_tl_row(10);
							active_fruit_tl_col <= fruit_tl_col(10);
							
							
							--active_fruit_tl_row <= 10d"200";
							--active_fruit_tl_col <= 10d"200";
							
								-- update active fruit type
							active_fruit_type <= active_fruit_type + 2d"1" when active_fruit_type /= 2d"3" else active_fruit_type;
							game_state <= FRUIT_FALLING;
						else
							fruit_tl_row(swap_fruit) <= active_fruit_tl_row;
							fruit_tl_col(swap_fruit) <= active_fruit_tl_col;
							fruit_type(swap_fruit) <= active_fruit_type;
							score <= score + 5d"3";
							game_state <= SWAP;
						end if;
					else
						game_state <= FRUIT_FALLING;
					end if;
				elsif game_state = SWAP then
					--fruit_tl_row(swap_fruit) <= active_fruit_tl_row;
					--fruit_tl_col(swap_fruit) <= active_fruit_tl_col;
					--fruit_type(swap_fruit) <= active_fruit_type;
					
					active_fruit_type <= randomoutput;
					--active_fruit_type <= "00";
				
					--falloop_counter <= 0;
				
							
					reset_random <= '0';

					swap_fruit <= swap_fruit + 1; -- increment swap_fruit state
					if swap_fruit = NUM_FRUITS then
						game_state <= GAME_OVER;
						active_fruit_tl_row <= 10d"700";
						active_fruit_tl_col <= 10d"700";
					else
						game_state <= FRUIT_POS;
						active_fruit_tl_row <= 10d"0";
						active_fruit_tl_col <= 10d"307";
					end if;
				elsif game_state = GAME_OVER then
					flashing_counter <= flashing_counter + 1;
					if button(4) = '0' and button_prev = "11111111" then
						game_state <= START;
					end if;
					--if button /= 8b"0" and button_prev = 8b"0" then
						--game_state <= START;
					--end if;
				else
					game_state <= START;
				end if;
			end if;
		--end if;
	end process;

end;
