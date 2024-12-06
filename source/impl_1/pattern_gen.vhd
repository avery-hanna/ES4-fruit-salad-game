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

type GAMESTATE is (START, FRUIT_POS, FRUIT_FALLING, SWAP, HOLD, GAME_OVER);
signal game_state : GAMESTATE := START;

-- state to track which fruit is next to swap in for the active fruit
type SWAPSTATE is (FRUIT1, FRUIT2, FRUIT3, FRUIT4, FRUIT5, FRUIT6, FRUIT7, FRUIT8, FRUIT9, FRUIT10);
signal swap_state : SWAPSTATE := FRUIT1;

signal swap_fruit : unsigned(2 downto 0);

signal startscreenRGB : std_logic_vector(5 downto 0);

signal active_fruit_tl_row : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal active_fruit_tl_col : unsigned (9 downto 0) := 10d"0"; -- TODO update: 50 wide , 2 to 47 
signal active_fruit_type : unsigned(2 downto 0);
signal active_fruit_RGB : std_logic_vector(5 downto 0); -- we will get these values from all the different ROM and compare to decide what to render
signal active_fruit_relative_row : std_logic_vector (9 downto 0);
signal active_fruit_relative_col : std_logic_vector (9 downto 0);
signal active_fruit_rom_row : std_logic_vector (4 downto 0) := "00000";
signal active_fruit_rom_col : std_logic_vector (4 downto 0) := "00000";

constant NUM_FRUITS : integer := 2;
type unsigned_coord_array is array(1 to NUM_FRUITS) of unsigned(9 downto 0);
type type_array is array(1 to NUM_FRUITS) of unsigned(2 downto 0);
type rgb_array is array(1 to NUM_FRUITS) of std_logic_vector(5 downto 0);
type vector_coord_array is array(1 to NUM_FRUITS) of std_logic_vector(9 downto 0);
type rom_coord_array is array(1 to NUM_FRUITS) of std_logic_vector(4 downto 0);

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


begin
	led <= '1' when game_state = START else '0';
	
	start_screen : startscreenROM port map(row(9 downto 2), col(9 downto 2), clk, startscreenRGB);
	
	active_fruit_relative_row <= std_logic_vector(unsigned(row) - active_fruit_tl_row);
	active_fruit_relative_col <= std_logic_vector(unsigned(col) - active_fruit_tl_col);
	
	active_fruit_rom_row <= active_fruit_relative_row(5 downto 1) when active_fruit_relative_row(9 downto 6) = "0000" else "11111";
	active_fruit_rom_col <= active_fruit_relative_col(5 downto 1) when active_fruit_relative_col(9 downto 6) = "0000" else "11111";
	
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


    process begin
        for i in 1 to NUM_FRUITS loop
            fruit_relative_row(i) <= std_logic_vector(unsigned(row) - fruit_tl_row(i));
            fruit_relative_col(i) <= std_logic_vector(unsigned(col) - fruit_tl_col(i));

            fruit_rom_row(i) <= fruit_relative_row(i)(5 downto 1) when fruit_relative_row(i)(9 downto 6) = "0000" else "11111";
            fruit_rom_col(i) <= fruit_relative_col(i)(5 downto 1) when fruit_relative_col(i)(9 downto 6) = "0000" else "11111";
        end loop;
    end process;	
	
	--fruit_RGB <= active_fruit_RGB when (active_fruit_RGB /= "000000") else fruit_3_RGB when (fruit_3_RGB /= "000000") else fruit_2_RGB when (fruit_2_RGB /= "000000") else fruit_1_RGB;
	
	process begin
        fruit_RGB <= active_fruit_RGB;
        for i in NUM_FRUITS downto 1 loop
            if fruit_rgb_vals(i) /= "000000" then
                fruit_RGB <= fruit_rgb_vals(i);
                exit;
            end if;
        end loop;
    end process;
	
	RGB <= "000000" when valid = '0' -- can be changed here and below
			else startscreenRGB when game_state = START
			else "110011" when game_state = GAME_OVER
			else fruit_RGB;

		
	process(clk) begin
		if rising_edge(clk) then
			button_prev <= button;
			
			if game_state = START then
				-- Position active fruit in center of top row of screen
				active_fruit_tl_row <= 10d"0";
				active_fruit_tl_col <= 10d"307";
				active_fruit_type <= "000";
		
				-- Position all other fruits off screen
				for i in 1 to NUM_FRUITS loop
					fruit_tl_row(i) <= 10d"700";
					fruit_tl_col(i) <= 10d"700";
				end loop;
				
				swap_state <= FRUIT1;
				swap_fruit <= "001";
				
				-- move state forward when button = start and button_prev is off
				if button(4) = '0' and button_prev = "11111111" then
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
					
					if counter = 17d"100000" then
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
				if counter = 17d"100000" then
					active_fruit_tl_row <= active_fruit_tl_row + 1;
					counter <= 17d"0";
				end if;
				
				for i in 1 to NUM_FRUITS loop
					if fruit_rgb_vals(i) /= "000000" and active_fruit_RGB /= "000000" then -- collision
						if fruit_type(i) = active_fruit_type then
							 -- fruit 1 goes offscreen
							fruit_tl_row(i) <= 10d"700";
							fruit_tl_col(i) <= 10d"700";
					
							-- active fruit gets fruit 1's position
							active_fruit_tl_row <= fruit_tl_row(i);
							active_fruit_tl_col <= fruit_tl_col(i);
							
							 -- update active fruit type
							active_fruit_type <= active_fruit_type + 3d"1" when active_fruit_type /= 3d"4" else active_fruit_type;
						else
							game_state <= SWAP;
						end if;
					end if;
				end loop;
				
				if active_fruit_tl_row > 417 then -- fruit has reached bottom row without collisions
					game_state <= SWAP;
				end if;
			elsif game_state = SWAP then
				for i in 1 to NUM_FRUITS loop
					if swap_fruit = i then
						fruit_tl_row(i) <= active_fruit_tl_row;
						fruit_tl_col(i) <= active_fruit_tl_col;
						fruit_type(i) <= active_fruit_type;
					end if;
				end loop;
				
				active_fruit_tl_row <= 10d"0";
				active_fruit_tl_col <= 10d"307";
				active_fruit_type <= "000"; -- TODO update to randomize new fruit type

				swap_fruit <= swap_fruit + "001"; -- increment swap_fruit state
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
