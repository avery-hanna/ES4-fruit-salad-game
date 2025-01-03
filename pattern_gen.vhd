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

type GAMESTATE is (START, MOVE_OFF, FRUIT_POS, FRUIT_FALLING, SWAP, GAME_OVER, FALL_LOOP);
signal game_state : GAMESTATE := START;

signal swap_fruit : integer;
signal falloop_counter: unsigned(4 downto 0);

signal startscreenRGB : std_logic_vector(5 downto 0);
signal flashstartscreenRGB : std_logic_vector(5 downto 0);

signal score: unsigned(5 downto 0);
signal score_tens_digit : std_logic_vector(3 downto 0);
signal score_ones_digit : std_logic_vector(3 downto 0);
signal score_row : std_logic_vector(9 downto 0);
signal score_col : std_logic_vector(9 downto 0);
signal score_color_tens : std_logic;
signal score_color_ones : std_logic;
signal score_col_RGB : std_logic_vector(5 downto 0);


signal active_fruit_tl_row : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal active_fruit_tl_col : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal active_fruit_type : unsigned(1 downto 0);
signal active_fruit_RGB : std_logic_vector(5 downto 0); -- we will get these values from all the different ROM and compare to decide what to render
signal active_fruit_relative_row : std_logic_vector (9 downto 0);
signal active_fruit_relative_col : std_logic_vector (9 downto 0);
signal active_fruit_rom_row : std_logic_vector (3 downto 0);
signal active_fruit_rom_col : std_logic_vector (3 downto 0);

signal reset_random : std_logic;

constant NUM_FRUITS : integer := 10;

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

signal gameplay_RGB : std_logic_vector(5 downto 0);


signal button_prev : std_logic_vector(7 downto 0);
signal counter : unsigned(16 downto 0);
signal output: std_logic_vector(7 downto 0);

signal startscreenrow: std_logic_vector(4 downto 0);
signal startscreencol: std_logic_vector(6 downto 0);

signal flash_startscreenrow: std_logic_vector(4 downto 0);
signal flash_startscreencol: std_logic_vector(6 downto 0);

signal startscreen_relativerow: std_logic_vector(9 downto 0);
signal startscreen_relativecol: std_logic_vector(9 downto 0);

signal startscreen_flashrow: std_logic_vector(9 downto 0);
signal startscreen_flashcol: std_logic_vector(9 downto 0);

--signal flashing_screen_RGB : std_logic_vector(5 downto 0);
signal flashing_counter : unsigned(23 downto 0);
signal flashingstart_counter : unsigned(23 downto 0);
signal randomoutput: unsigned(1 downto 0);

signal startRGB1: std_logic_vector(5 downto 0);
signal startRGB2: std_logic_vector(5 downto 0);


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
	
	dddd_instance : dddd port map(score, score_tens_digit, score_ones_digit);
	
	score_row <= std_logic_vector(unsigned(row) - 10d"20");
	score_col <= std_logic_vector(unsigned(col) - 10d"10");
	
	ones_place_rom : digitROM port map(score_ones_digit, score_row(4 downto 2), score_col(4 downto 2), clk, score_color_ones);
	tens_place_rom : digitROM port map(score_tens_digit, score_row(4 downto 2), score_col(4 downto 2), clk, score_color_tens);
	
	score_col_RGB <= ("111111" when score_color_tens = '1' else "000000") when row >= 10d"20" and row < 10d"52" and col >= 10d"10" and col < 10d"42"
					  else ("111111" when score_color_ones = '1' else "000000") when row >= 10d"20" and row < 10d"52" and col >= 10d"42" and col < 10d"74"
					  else "000000";
	
	
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
	
	--process(clk)  begin
		--fruit_RGB <= active_fruit_RGB;
		--for i in NUM_FRUITS downto 1 loop
			--if fruit_rgb_vals(i) /= "000000" then
				--fruit_RGB <= fruit_rgb_vals(i);
				--exit;
			--end if;
		--end loop;
    --end process;
	
	startRGB1 <= fruit_rgb_vals(1) when fruit_rgb_vals(1)  /= "000000" else 
				fruit_rgb_vals(2) when fruit_rgb_vals(2)  /= "000000" else 
				fruit_rgb_vals(3) when fruit_rgb_vals(3)  /= "000000" else 
				fruit_rgb_vals(4) when fruit_rgb_vals(4)  /= "000000" else 
				fruit_rgb_vals(5) when fruit_rgb_vals(5)  /= "000000" else 
				fruit_rgb_vals(6) when fruit_rgb_vals(6)  /= "000000" else 
				flashstartscreenRGB;

	startRGB2 <= fruit_rgb_vals(1) when fruit_rgb_vals(1)  /= "000000" else 
				fruit_rgb_vals(2) when fruit_rgb_vals(2)  /= "000000" else 
				fruit_rgb_vals(3) when fruit_rgb_vals(3)  /= "000000" else 
				fruit_rgb_vals(4) when fruit_rgb_vals(4)  /= "000000" else 
				fruit_rgb_vals(5) when fruit_rgb_vals(5)  /= "000000" else 
				fruit_rgb_vals(6) when fruit_rgb_vals(6)  /= "000000" else 
				startscreenRGB;
	
	gameplay_RGB <= fruit_RGB when col >= 10d"74" else score_col_RGB;
	
	RGB <= "000000" when valid = '0' -- can be changed here and below
			else gameplay_RGB when game_state=FRUIT_FALLING
			else  startRGB1 when (flashingstart_counter(23)='0' and game_state=START) 
			else startRGB2 when (game_state = START and flashingstart_counter(23)='1')
			else ("000000" when flashing_counter(23) = '0' else gameplay_RGB) when game_state = GAME_OVER
			else gameplay_RGB;

		
	process(clk) begin
		if rising_edge(clk) then
			button_prev <= button;
			
			if game_state = START then
				-- Position active fruit in center of top row of screen
				active_fruit_tl_row <= 10d"0";
				active_fruit_tl_col <= 10d"307";
				
				flashingstart_counter <= flashingstart_counter + 1;
		
				reset_random <= '1';
				
				score <= 6d"0";

				active_fruit_type <= randomoutput;
				
				fruit_tl_row(1) <= 10d"400";
				fruit_tl_col(1) <= 10d"10";
				fruit_type(1) <= "00";
				
				fruit_tl_row(2) <= 10d"400";
				fruit_tl_col(2) <= 10d"80";
				fruit_type(2) <= "10";

				fruit_tl_row(3) <= 10d"400";
				fruit_tl_col(3) <= 10d"150";
				fruit_type(3) <= "01";
				
				fruit_tl_row(4) <= 10d"400";
				fruit_tl_col(4) <= 10d"300";
				fruit_type(4) <= "11";
				
				fruit_tl_row(5) <= 10d"400";
				fruit_tl_col(5) <= 10d"380";
				fruit_type(5) <= "10";
				
				fruit_tl_row(6) <= 10d"400";
				fruit_tl_col(6) <= 10d"500";
				fruit_type(6) <= "01";
				
				swap_fruit <= 1;
				
				-- move state forward when button = start and button_prev is off
				if button(4) = '0' and button_prev = "11111111" then
					game_state <= MOVE_OFF;
				end if;
			elsif game_state = MOVE_OFF then
				-- Position all other fruits off screen
				for i in 1 to NUM_FRUITS loop
					fruit_tl_row(i) <= 10d"700";
					fruit_tl_col(i) <= 10d"700";
				end loop;

				game_state <= FRUIT_POS;
			elsif game_state = FRUIT_POS then
				 --Left button pressed
				if button(1) = '0' then
					if button_prev(1) = '0' then
						counter <= counter + 1;
					else
						counter <= 17d"1";
					end if;
					
					if counter = 17d"100000" then
						if active_fruit_tl_col > 74 then
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
					
					if counter = 17d"100000" then
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
				if counter = 17d"011100" then
					active_fruit_tl_row <= active_fruit_tl_row + 1;
					counter <= 17d"0";
					
					
				end if;
				
				falloop_counter <= 5d"1";

				if active_fruit_tl_row > 417 then -- fruit has reached bottom row without collisions
					fruit_tl_row(swap_fruit) <= active_fruit_tl_row;
					fruit_tl_col(swap_fruit) <= active_fruit_tl_col;
					fruit_type(swap_fruit) <= active_fruit_type;
				
					game_state <= SWAP;
				else
					game_state <= FALL_LOOP;
				end if;
				
				
			elsif game_state = FALL_LOOP then
				
				falloop_counter <= falloop_counter + 5d"1";
				if falloop_counter > NUM_FRUITS then
					game_state <= FRUIT_FALLING;
				elsif fruit_rgb_vals(to_integer(falloop_counter)) /= "000000" and active_fruit_RGB /= "000000" then -- collision
					if fruit_type(to_integer(falloop_counter)) = active_fruit_type then
						-- fruit goes offscreen
						fruit_tl_row(to_integer(falloop_counter)) <= 10d"700";
						fruit_tl_col(to_integer(falloop_counter)) <= 10d"700";
						if active_fruit_type = "00" then
							score <= score + 6d"1";
						elsif active_fruit_type = "01" then
							score <= score + 6d"2";
						elsif active_fruit_type = "10" then
							score <= score + 6d"3";
						elsif active_fruit_type = "11" then
							score <= score + 6d"4";
						end if;
				
						-- active fruit gets fruit 1's position
						active_fruit_tl_row <= fruit_tl_row(to_integer(falloop_counter));
						active_fruit_tl_col <= fruit_tl_col(to_integer(falloop_counter));
						
						
						--active_fruit_tl_row <= 10d"200";
						--active_fruit_tl_col <= 10d"200";
						
							-- update active fruit type
						active_fruit_type <= active_fruit_type + 2d"1" when active_fruit_type /= 2d"3" else active_fruit_type;
						
						game_state <= FRUIT_FALLING;
					else
						fruit_tl_row(swap_fruit) <= active_fruit_tl_row;
						fruit_tl_col(swap_fruit) <= active_fruit_tl_col;
						fruit_type(swap_fruit) <= active_fruit_type;
						game_state <= SWAP;
					end if;
				else
					game_state <= FALL_LOOP;
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
			else
				game_state <= START;
			end if;
		end if;
	end process;

end;