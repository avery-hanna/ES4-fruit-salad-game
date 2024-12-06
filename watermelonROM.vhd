library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM is
  port(
	  row : in std_logic_vector(4 downto 0);
	  col : in std_logic_vector(4 downto 0);
	  fruit_color : in std_logic_vector(5 downto 0);
	  clk : in std_logic;
	  color : out std_logic_vector(5 downto 0)
  );
end ROM;

architecture synth of ROM is 
signal address : std_logic_vector(9 downto 0);
begin
	process(clk) is
	begin
		if rising_edge(clk) then
			case address is 

 	 	 	when "00000101" => 
 	 	 	 	 color <= "000100";
 	 	 	when "00000110" => 
 	 	 	 	 color <= "011000";
 	 	 	when "00000111" => 
 	 	 	 	 color <= "011001";
 	 	 	when "00001000" => 
 	 	 	 	 color <= "011000";
 	 	 	when "00001001" => 
 	 	 	 	 color <= "010100";
 	 	 	when "00010011" => 
 	 	 	 	 color <= "010100";
 	 	 	when "00010100" => 
 	 	 	 	 color <= "101001";
 	 	 	when "00010101" => 
 	 	 	 	 color <= "111001";
 	 	 	when "00010110" => 
 	 	 	 	 color <= "111001";
 	 	 	when "00010111" => 
 	 	 	 	 color <= "110101";
 	 	 	when "00011000" => 
 	 	 	 	 color <= "111001";
 	 	 	when "00011001" => 
 	 	 	 	 color <= "111001";
 	 	 	when "00011010" => 
 	 	 	 	 color <= "101001";
 	 	 	when "00011011" => 
 	 	 	 	 color <= "010100";
 	 	 	when "00100010" => 
 	 	 	 	 color <= "011000";
 	 	 	when "00100011" => 
 	 	 	 	 color <= "111010";
 	 	 	when "00100100" => 
 	 	 	 	 color <= "110101";
 	 	 	when "00100101" => 
 	 	 	 	 color <= "100000";
 	 	 	when "00100110" => 
 	 	 	 	 color <= "110001";
 	 	 	when "00100111" => 
 	 	 	 	 color <= "110001";
 	 	 	when "00101000" => 
 	 	 	 	 color <= "100000";
 	 	 	when "00101001" => 
 	 	 	 	 color <= "110001";
 	 	 	when "00101010" => 
 	 	 	 	 color <= "110101";
 	 	 	when "00101011" => 
 	 	 	 	 color <= "111010";
 	 	 	when "00101100" => 
 	 	 	 	 color <= "011001";
 	 	 	when "00110001" => 
 	 	 	 	 color <= "010100";
 	 	 	when "00110010" => 
 	 	 	 	 color <= "111010";
 	 	 	when "00110011" => 
 	 	 	 	 color <= "110001";
 	 	 	when "00110100" => 
 	 	 	 	 color <= "110000";
 	 	 	when "00110101" => 
 	 	 	 	 color <= "110001";
 	 	 	when "00110110" => 
 	 	 	 	 color <= "110001";
 	 	 	when "00110111" => 
 	 	 	 	 color <= "110001";
 	 	 	when "00111000" => 
 	 	 	 	 color <= "110001";
 	 	 	when "00111001" => 
 	 	 	 	 color <= "110001";
 	 	 	when "00111010" => 
 	 	 	 	 color <= "110000";
 	 	 	when "00111011" => 
 	 	 	 	 color <= "100000";
 	 	 	when "00111100" => 
 	 	 	 	 color <= "111010";
 	 	 	when "00111101" => 
 	 	 	 	 color <= "011000";
 	 	 	when "00111110" => 
 	 	 	 	 color <= "000001";
 	 	 	when "01000001" => 
 	 	 	 	 color <= "101001";
 	 	 	when "01000010" => 
 	 	 	 	 color <= "110101";
 	 	 	when "01000011" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01000100" => 
 	 	 	 	 color <= "100000";
 	 	 	when "01000101" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01000110" => 
 	 	 	 	 color <= "100000";
 	 	 	when "01000111" => 
 	 	 	 	 color <= "110000";
 	 	 	when "01001000" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01001001" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01001010" => 
 	 	 	 	 color <= "100000";
 	 	 	when "01001011" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01001100" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01001101" => 
 	 	 	 	 color <= "101001";
 	 	 	when "01001110" => 
 	 	 	 	 color <= "000100";
 	 	 	when "01010000" => 
 	 	 	 	 color <= "000100";
 	 	 	when "01010001" => 
 	 	 	 	 color <= "111001";
 	 	 	when "01010010" => 
 	 	 	 	 color <= "100000";
 	 	 	when "01010011" => 
 	 	 	 	 color <= "110000";
 	 	 	when "01010100" => 
 	 	 	 	 color <= "110000";
 	 	 	when "01010101" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01010110" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01010111" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01011000" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01011001" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01011010" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01011011" => 
 	 	 	 	 color <= "100000";
 	 	 	when "01011100" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01011101" => 
 	 	 	 	 color <= "111001";
 	 	 	when "01011110" => 
 	 	 	 	 color <= "011000";
 	 	 	when "01100000" => 
 	 	 	 	 color <= "010100";
 	 	 	when "01100001" => 
 	 	 	 	 color <= "111001";
 	 	 	when "01100010" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01100011" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01100100" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01100101" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01100110" => 
 	 	 	 	 color <= "100000";
 	 	 	when "01100111" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01101000" => 
 	 	 	 	 color <= "100000";
 	 	 	when "01101001" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01101010" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01101011" => 
 	 	 	 	 color <= "110000";
 	 	 	when "01101100" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01101101" => 
 	 	 	 	 color <= "110101";
 	 	 	when "01101110" => 
 	 	 	 	 color <= "011001";
 	 	 	when "01110000" => 
 	 	 	 	 color <= "011000";
 	 	 	when "01110001" => 
 	 	 	 	 color <= "110101";
 	 	 	when "01110010" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01110011" => 
 	 	 	 	 color <= "100000";
 	 	 	when "01110100" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01110101" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01110110" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01110111" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01111000" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01111001" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01111010" => 
 	 	 	 	 color <= "100000";
 	 	 	when "01111011" => 
 	 	 	 	 color <= "110001";
 	 	 	when "01111100" => 
 	 	 	 	 color <= "100000";
 	 	 	when "01111101" => 
 	 	 	 	 color <= "110101";
 	 	 	when "01111110" => 
 	 	 	 	 color <= "101001";
 	 	 	when "10000000" => 
 	 	 	 	 color <= "011000";
 	 	 	when "10000001" => 
 	 	 	 	 color <= "111001";
 	 	 	when "10000010" => 
 	 	 	 	 color <= "100000";
 	 	 	when "10000011" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10000100" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10000101" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10000110" => 
 	 	 	 	 color <= "100000";
 	 	 	when "10000111" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10001000" => 
 	 	 	 	 color <= "100000";
 	 	 	when "10001001" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10001010" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10001011" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10001100" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10001101" => 
 	 	 	 	 color <= "110101";
 	 	 	when "10001110" => 
 	 	 	 	 color <= "101001";
 	 	 	when "10010000" => 
 	 	 	 	 color <= "000100";
 	 	 	when "10010001" => 
 	 	 	 	 color <= "111001";
 	 	 	when "10010010" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10010011" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10010100" => 
 	 	 	 	 color <= "100000";
 	 	 	when "10010101" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10010110" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10010111" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10011000" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10011001" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10011010" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10011011" => 
 	 	 	 	 color <= "100000";
 	 	 	when "10011100" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10011101" => 
 	 	 	 	 color <= "111001";
 	 	 	when "10011110" => 
 	 	 	 	 color <= "011000";
 	 	 	when "10100001" => 
 	 	 	 	 color <= "101001";
 	 	 	when "10100010" => 
 	 	 	 	 color <= "110101";
 	 	 	when "10100011" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10100100" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10100101" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10100110" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10100111" => 
 	 	 	 	 color <= "110000";
 	 	 	when "10101000" => 
 	 	 	 	 color <= "100000";
 	 	 	when "10101001" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10101010" => 
 	 	 	 	 color <= "100000";
 	 	 	when "10101011" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10101100" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10101101" => 
 	 	 	 	 color <= "101001";
 	 	 	when "10101110" => 
 	 	 	 	 color <= "000100";
 	 	 	when "10110001" => 
 	 	 	 	 color <= "010100";
 	 	 	when "10110010" => 
 	 	 	 	 color <= "111010";
 	 	 	when "10110011" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10110100" => 
 	 	 	 	 color <= "100000";
 	 	 	when "10110101" => 
 	 	 	 	 color <= "100000";
 	 	 	when "10110110" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10110111" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10111000" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10111001" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10111010" => 
 	 	 	 	 color <= "110001";
 	 	 	when "10111011" => 
 	 	 	 	 color <= "100000";
 	 	 	when "10111100" => 
 	 	 	 	 color <= "111001";
 	 	 	when "10111101" => 
 	 	 	 	 color <= "011001";
 	 	 	when "10111110" => 
 	 	 	 	 color <= "000001";
 	 	 	when "11000010" => 
 	 	 	 	 color <= "011001";
 	 	 	when "11000011" => 
 	 	 	 	 color <= "111010";
 	 	 	when "11000100" => 
 	 	 	 	 color <= "110101";
 	 	 	when "11000101" => 
 	 	 	 	 color <= "110001";
 	 	 	when "11000110" => 
 	 	 	 	 color <= "110001";
 	 	 	when "11000111" => 
 	 	 	 	 color <= "100000";
 	 	 	when "11001000" => 
 	 	 	 	 color <= "110001";
 	 	 	when "11001001" => 
 	 	 	 	 color <= "100000";
 	 	 	when "11001010" => 
 	 	 	 	 color <= "110001";
 	 	 	when "11001011" => 
 	 	 	 	 color <= "111001";
 	 	 	when "11001100" => 
 	 	 	 	 color <= "011001";
 	 	 	when "11001101" => 
 	 	 	 	 color <= "000001";
 	 	 	when "11010011" => 
 	 	 	 	 color <= "011000";
 	 	 	when "11010100" => 
 	 	 	 	 color <= "101001";
 	 	 	when "11010101" => 
 	 	 	 	 color <= "111001";
 	 	 	when "11010110" => 
 	 	 	 	 color <= "110101";
 	 	 	when "11010111" => 
 	 	 	 	 color <= "110101";
 	 	 	when "11011000" => 
 	 	 	 	 color <= "110101";
 	 	 	when "11011001" => 
 	 	 	 	 color <= "111001";
 	 	 	when "11011010" => 
 	 	 	 	 color <= "101001";
 	 	 	when "11011011" => 
 	 	 	 	 color <= "011001";
 	 	 	when "11011100" => 
 	 	 	 	 color <= "000001";
 	 	 	when "11100011" => 
 	 	 	 	 color <= "000001";
 	 	 	when "11100100" => 
 	 	 	 	 color <= "000100";
 	 	 	when "11100101" => 
 	 	 	 	 color <= "010100";
 	 	 	when "11100110" => 
 	 	 	 	 color <= "011001";
 	 	 	when "11100111" => 
 	 	 	 	 color <= "101001";
 	 	 	when "11101000" => 
 	 	 	 	 color <= "011001";
 	 	 	when "11101001" => 
 	 	 	 	 color <= "011000";
 	 	 	when "11101010" => 
 	 	 	 	 color <= "000100";
 	 	 	when "11101011" => 
 	 	 	 	 color <= "000001"; 
 	 	 end case; 
     	 end if;  
     end process; 
 address <= row & col; 
 end;