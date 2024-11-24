library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM is
  port(
	  row : in std_logic_vector(4 downto 0);  
    col : in std_logic_vector(4 downto 0);  
    fruit_color : in std_logic_vector(23 downto 0);
	  clk : in std_logic;
	  color : out std_logic_vector(23 downto 0)
  );
end ROM;

architecture synth of ROM is 
signal address : std_logic_vector(18 downto 0);
begin
	process(clk) is
	begin
		if rising_edge(clk) then
			-- color <= 24d"0" when 
			case addr is 
				when "0000" => 
					char_1 <= "1111111"; 
					char_2 <= "1001000";
				when "0001" => 
					char_1 <= "1001000"; 
					char_2 <= "0110000";
				when "0010" => 
					char_1 <= "0110000";
					char_2 <= "1110001";
				when "0011" => 
					char_1 <= "1110001"; 
					char_2 <= "1110001";
				when "0100" => 
					char_1 <= "1110001";
					char_2 <= "0000001";
				when "0101" => 
					char_1 <= "0000001";
					char_2 <= "1111111";
				when "0110" => 
					char_1 <= "1111111";
					char_2 <= "0001000";
				when "0111" => 
					char_1 <= "0001000";
					char_2 <= "1000001";
				when "1000" => 
					char_1 <= "1000001";
					char_2 <= "0110000";
				when "1001" => 
					char_1 <= "0110000";
					char_2 <= "0111001";
				when "1010" => 
					char_1 <= "0111001";
					char_2 <= "1001100";
				when "1011" => 
					char_1 <= "1001100";
					char_2 <= "1111111";
				when "1100" => 
					char_1 <= "1111111";
					char_2 <= "1111111";
				when others => 
					char_1 <= "1111111"; 
					char_2 <= "1111111";
			end case;

		end if;
	end process;
end;
