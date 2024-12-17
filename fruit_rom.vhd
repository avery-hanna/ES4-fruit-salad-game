library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fruitROM is
  port(
	  row : in std_logic_vector(3 downto 0);
	  col : in std_logic_vector(3 downto 0);
	  fruit_type : in std_logic_vector(1 downto 0);
	  clk : in std_logic;
	  color : out std_logic_vector(5 downto 0)
  );
end fruitROM;

architecture synth of fruitROM is 

component  maprgb is
	port(
		color3 : in std_logic_vector(2 downto 0);
		fruit_type: in std_logic_vector(1 downto 0);
		color : out std_logic_vector(5 downto 0)
	);
  end component;

signal address: std_logic_vector(9 downto 0);
signal color3: std_logic_vector(2 downto 0);

begin
	process(clk) is
	begin
		if rising_edge(clk) then
			case address is
				--blueberry
				when "0000000101" => 
					color3 <= "001"; 
				when "0000000110" => 
					color3 <= "001"; 
				when "0000000111" => 
					color3 <= "001"; 
				when "0000001000" => 
					color3 <= "001"; 
				when "0000001001" => 
					color3 <= "001"; 
				when "0000001010" => 
					color3 <= "001"; 
				when "0000010011" => 
					color3 <= "001"; 
				when "0000010100" => 
					color3 <= "001"; 
				when "0000010101" => 
					color3 <= "001"; 
				when "0000010110" => 
					color3 <= "001"; 
				when "0000010111" => 
					color3 <= "001"; 
				when "0000011000" => 
					color3 <= "001"; 
				when "0000011001" => 
					color3 <= "001"; 
				when "0000011010" => 
					color3 <= "001"; 
				when "0000011011" => 
					color3 <= "001"; 
				when "0000100010" => 
					color3 <= "001"; 
				when "0000100011" => 
					color3 <= "001"; 
				when "0000100100" => 
					color3 <= "001"; 
				when "0000100101" => 
					color3 <= "001"; 
				when "0000100110" => 
					color3 <= "001"; 
				when "0000100111" => 
					color3 <= "001"; 
				when "0000101000" => 
					color3 <= "001"; 
				when "0000101001" => 
					color3 <= "001"; 
				when "0000101010" => 
					color3 <= "001"; 
				when "0000101011" => 
					color3 <= "001"; 
				when "0000101100" => 
					color3 <= "001"; 
				when "0000110001" => 
					color3 <= "001"; 
				when "0000110010" => 
					color3 <= "001"; 
				when "0000110011" => 
					color3 <= "001"; 
				when "0000110100" => 
					color3 <= "001"; 
				when "0000110101" => 
					color3 <= "001"; 
				when "0000110110" => 
					color3 <= "001"; 
				when "0000110111" => 
					color3 <= "001"; 
				when "0000111000" => 
					color3 <= "001"; 
				when "0000111001" => 
					color3 <= "001"; 
				when "0000111010" => 
					color3 <= "001"; 
				when "0000111011" => 
					color3 <= "001"; 
				when "0000111100" => 
					color3 <= "001"; 
				when "0000111101" => 
					color3 <= "001"; 
				when "0001000001" => 
					color3 <= "001"; 
				when "0001000010" => 
					color3 <= "010"; 
				when "0001000011" => 
					color3 <= "001"; 
				when "0001000100" => 
					color3 <= "010"; 
				when "0001000101" => 
					color3 <= "001"; 
				when "0001000110" => 
					color3 <= "001"; 
				when "0001000111" => 
					color3 <= "001"; 
				when "0001001000" => 
					color3 <= "001"; 
				when "0001001001" => 
					color3 <= "001"; 
				when "0001001010" => 
					color3 <= "001"; 
				when "0001001011" => 
					color3 <= "001"; 
				when "0001001100" => 
					color3 <= "001"; 
				when "0001001101" => 
					color3 <= "001"; 
				when "0001010000" => 
					color3 <= "001"; 
				when "0001010001" => 
					color3 <= "001"; 
				when "0001010010" => 
					color3 <= "010"; 
				when "0001010011" => 
					color3 <= "001"; 
				when "0001010100" => 
					color3 <= "010"; 
				when "0001010101" => 
					color3 <= "001"; 
				when "0001010110" => 
					color3 <= "001"; 
				when "0001010111" => 
					color3 <= "001"; 
				when "0001011000" => 
					color3 <= "001"; 
				when "0001011001" => 
					color3 <= "001"; 
				when "0001011010" => 
					color3 <= "001"; 
				when "0001011011" => 
					color3 <= "001"; 
				when "0001011100" => 
					color3 <= "001"; 
				when "0001011101" => 
					color3 <= "001"; 
				when "0001011110" => 
					color3 <= "001"; 
				when "0001100000" => 
					color3 <= "001"; 
				when "0001100001" => 
					color3 <= "001"; 
				when "0001100010" => 
					color3 <= "010"; 
				when "0001100011" => 
					color3 <= "010"; 
				when "0001100100" => 
					color3 <= "001"; 
				when "0001100101" => 
					color3 <= "001"; 
				when "0001100110" => 
					color3 <= "001"; 
				when "0001100111" => 
					color3 <= "001"; 
				when "0001101000" => 
					color3 <= "001"; 
				when "0001101001" => 
					color3 <= "001"; 
				when "0001101010" => 
					color3 <= "001"; 
				when "0001101011" => 
					color3 <= "001"; 
				when "0001101100" => 
					color3 <= "001"; 
				when "0001101101" => 
					color3 <= "001"; 
				when "0001101110" => 
					color3 <= "001"; 
				when "0001110000" => 
					color3 <= "001"; 
				when "0001110001" => 
					color3 <= "010"; 
				when "0001110010" => 
					color3 <= "010"; 
				when "0001110011" => 
					color3 <= "010"; 
				when "0001110100" => 
					color3 <= "001"; 
				when "0001110101" => 
					color3 <= "001"; 
				when "0001110110" => 
					color3 <= "001"; 
				when "0001110111" => 
					color3 <= "001"; 
				when "0001111000" => 
					color3 <= "001"; 
				when "0001111001" => 
					color3 <= "001"; 
				when "0001111010" => 
					color3 <= "001"; 
				when "0001111011" => 
					color3 <= "001"; 
				when "0001111100" => 
					color3 <= "001"; 
				when "0001111101" => 
					color3 <= "001"; 
				when "0001111110" => 
					color3 <= "001"; 
				when "0010000000" => 
					color3 <= "001"; 
				when "0010000001" => 
					color3 <= "001"; 
				when "0010000010" => 
					color3 <= "010"; 
				when "0010000011" => 
					color3 <= "010"; 
				when "0010000100" => 
					color3 <= "001"; 
				when "0010000101" => 
					color3 <= "001"; 
				when "0010000110" => 
					color3 <= "001"; 
				when "0010000111" => 
					color3 <= "001"; 
				when "0010001000" => 
					color3 <= "001"; 
				when "0010001001" => 
					color3 <= "001"; 
				when "0010001010" => 
					color3 <= "001"; 
				when "0010001011" => 
					color3 <= "001"; 
				when "0010001100" => 
					color3 <= "001"; 
				when "0010001101" => 
					color3 <= "001"; 
				when "0010001110" => 
					color3 <= "001"; 
				when "0010010000" => 
					color3 <= "001"; 
				when "0010010001" => 
					color3 <= "001"; 
				when "0010010010" => 
					color3 <= "010"; 
				when "0010010011" => 
					color3 <= "001"; 
				when "0010010100" => 
					color3 <= "010"; 
				when "0010010101" => 
					color3 <= "001"; 
				when "0010010110" => 
					color3 <= "001"; 
				when "0010010111" => 
					color3 <= "001"; 
				when "0010011000" => 
					color3 <= "001"; 
				when "0010011001" => 
					color3 <= "001"; 
				when "0010011010" => 
					color3 <= "001"; 
				when "0010011011" => 
					color3 <= "001"; 
				when "0010011100" => 
					color3 <= "001"; 
				when "0010011101" => 
					color3 <= "001"; 
				when "0010011110" => 
					color3 <= "001"; 
				when "0010100001" => 
					color3 <= "001"; 
				when "0010100010" => 
					color3 <= "001"; 
				when "0010100011" => 
					color3 <= "001"; 
				when "0010100100" => 
					color3 <= "010"; 
				when "0010100101" => 
					color3 <= "001"; 
				when "0010100110" => 
					color3 <= "001"; 
				when "0010100111" => 
					color3 <= "001"; 
				when "0010101000" => 
					color3 <= "001"; 
				when "0010101001" => 
					color3 <= "001"; 
				when "0010101010" => 
					color3 <= "001"; 
				when "0010101011" => 
					color3 <= "001"; 
				when "0010101100" => 
					color3 <= "001"; 
				when "0010101101" => 
					color3 <= "001"; 
				when "0010101110" => 
					color3 <= "001"; 
				when "0010110001" => 
					color3 <= "001"; 
				when "0010110010" => 
					color3 <= "001"; 
				when "0010110011" => 
					color3 <= "001"; 
				when "0010110100" => 
					color3 <= "001"; 
				when "0010110101" => 
					color3 <= "001"; 
				when "0010110110" => 
					color3 <= "001"; 
				when "0010110111" => 
					color3 <= "001"; 
				when "0010111000" => 
					color3 <= "001"; 
				when "0010111001" => 
					color3 <= "001"; 
				when "0010111010" => 
					color3 <= "001"; 
				when "0010111011" => 
					color3 <= "001"; 
				when "0010111100" => 
					color3 <= "001"; 
				when "0010111101" => 
					color3 <= "001"; 
				when "0011000010" => 
					color3 <= "001"; 
				when "0011000011" => 
					color3 <= "001"; 
				when "0011000100" => 
					color3 <= "001"; 
				when "0011000101" => 
					color3 <= "001"; 
				when "0011000110" => 
					color3 <= "001"; 
				when "0011000111" => 
					color3 <= "001"; 
				when "0011001000" => 
					color3 <= "001"; 
				when "0011001001" => 
					color3 <= "001"; 
				when "0011001010" => 
					color3 <= "001"; 
				when "0011001011" => 
					color3 <= "001"; 
				when "0011001100" => 
					color3 <= "001"; 
				when "0011001101" => 
					color3 <= "001"; 
				when "0011010011" => 
					color3 <= "001"; 
				when "0011010100" => 
					color3 <= "001"; 
				when "0011010101" => 
					color3 <= "001"; 
				when "0011010110" => 
					color3 <= "001"; 
				when "0011010111" => 
					color3 <= "001"; 
				when "0011011000" => 
					color3 <= "001"; 
				when "0011011001" => 
					color3 <= "001"; 
				when "0011011010" => 
					color3 <= "001"; 
				when "0011011011" => 
					color3 <= "001"; 
				when "0011011100" => 
					color3 <= "001"; 
				when "0011100101" => 
					color3 <= "001"; 
				when "0011100110" => 
					color3 <= "001"; 
				when "0011100111" => 
					color3 <= "001"; 
				when "0011101000" => 
					color3 <= "001"; 
				when "0011101001" => 
					color3 <= "001"; 
				when "0011101010" => 
					color3 <= "001"; 
 
 
 
				--cherry 
				when "0100000101" => 
					color3 <= "001"; 
				when "0100000110" => 
					color3 <= "001"; 
				when "0100000111" => 
					color3 <= "001"; 
				when "0100001000" => 
					color3 <= "001"; 
				when "0100001001" => 
					color3 <= "001"; 
				when "0100010011" => 
					color3 <= "001"; 
				when "0100010100" => 
					color3 <= "001"; 
				when "0100010101" => 
					color3 <= "001"; 
				when "0100010110" => 
					color3 <= "001"; 
				when "0100010111" => 
					color3 <= "001"; 
				when "0100011000" => 
					color3 <= "001"; 
				when "0100011001" => 
					color3 <= "001"; 
				when "0100011010" => 
					color3 <= "001"; 
				when "0100011011" => 
					color3 <= "001"; 
				when "0100100010" => 
					color3 <= "001"; 
				when "0100100011" => 
					color3 <= "001"; 
				when "0100100100" => 
					color3 <= "001"; 
				when "0100100101" => 
					color3 <= "001"; 
				when "0100100110" => 
					color3 <= "001"; 
				when "0100100111" => 
					color3 <= "001"; 
				when "0100101000" => 
					color3 <= "001"; 
				when "0100101001" => 
					color3 <= "001"; 
				when "0100101010" => 
					color3 <= "001"; 
				when "0100101011" => 
					color3 <= "001"; 
				when "0100101100" => 
					color3 <= "001"; 
				when "0100110001" => 
					color3 <= "001"; 
				when "0100110010" => 
					color3 <= "001"; 
				when "0100110011" => 
					color3 <= "001"; 
				when "0100110100" => 
					color3 <= "001"; 
				when "0100110101" => 
					color3 <= "001"; 
				when "0100110110" => 
					color3 <= "001"; 
				when "0100110111" => 
					color3 <= "001"; 
				when "0100111000" => 
					color3 <= "001"; 
				when "0100111001" => 
					color3 <= "001"; 
				when "0100111010" => 
					color3 <= "001"; 
				when "0100111011" => 
					color3 <= "001"; 
				when "0100111100" => 
					color3 <= "001"; 
				when "0100111101" => 
					color3 <= "001"; 
				when "0101000001" => 
					color3 <= "001"; 
				when "0101000010" => 
					color3 <= "010"; 
				when "0101000011" => 
					color3 <= "001"; 
				when "0101000100" => 
					color3 <= "001"; 
				when "0101000101" => 
					color3 <= "001"; 
				when "0101000110" => 
					color3 <= "001"; 
				when "0101000111" => 
					color3 <= "001"; 
				when "0101001000" => 
					color3 <= "001"; 
				when "0101001001" => 
					color3 <= "001"; 
				when "0101001010" => 
					color3 <= "001"; 
				when "0101001011" => 
					color3 <= "001"; 
				when "0101001100" => 
					color3 <= "001"; 
				when "0101001101" => 
					color3 <= "001"; 
				when "0101010001" => 
					color3 <= "010"; 
				when "0101010010" => 
					color3 <= "011"; 
				when "0101010011" => 
					color3 <= "001"; 
				when "0101010100" => 
					color3 <= "001"; 
				when "0101010101" => 
					color3 <= "001"; 
				when "0101010110" => 
					color3 <= "001"; 
				when "0101010111" => 
					color3 <= "001"; 
				when "0101011000" => 
					color3 <= "001"; 
				when "0101011001" => 
					color3 <= "001"; 
				when "0101011010" => 
					color3 <= "001"; 
				when "0101011011" => 
					color3 <= "001"; 
				when "0101011100" => 
					color3 <= "001"; 
				when "0101011101" => 
					color3 <= "001"; 
				when "0101011110" => 
					color3 <= "001"; 
				when "0101100000" => 
					color3 <= "001"; 
				when "0101100001" => 
					color3 <= "001"; 
				when "0101100010" => 
					color3 <= "010"; 
				when "0101100011" => 
					color3 <= "010"; 
				when "0101100100" => 
					color3 <= "001"; 
				when "0101100101" => 
					color3 <= "001"; 
				when "0101100110" => 
					color3 <= "001"; 
				when "0101100111" => 
					color3 <= "001"; 
				when "0101101000" => 
					color3 <= "001"; 
				when "0101101001" => 
					color3 <= "001"; 
				when "0101101010" => 
					color3 <= "001"; 
				when "0101101011" => 
					color3 <= "001"; 
				when "0101101100" => 
					color3 <= "001"; 
				when "0101101101" => 
					color3 <= "001"; 
				when "0101101110" => 
					color3 <= "001"; 
				when "0101110000" => 
					color3 <= "001"; 
				when "0101110001" => 
					color3 <= "001"; 
				when "0101110010" => 
					color3 <= "100"; 
				when "0101110011" => 
					color3 <= "010"; 
				when "0101110100" => 
					color3 <= "001"; 
				when "0101110101" => 
					color3 <= "001"; 
				when "0101110110" => 
					color3 <= "001"; 
				when "0101110111" => 
					color3 <= "001"; 
				when "0101111000" => 
					color3 <= "001"; 
				when "0101111001" => 
					color3 <= "001"; 
				when "0101111010" => 
					color3 <= "001"; 
				when "0101111011" => 
					color3 <= "001"; 
				when "0101111100" => 
					color3 <= "001"; 
				when "0101111101" => 
					color3 <= "001"; 
				when "0101111110" => 
					color3 <= "001"; 
				when "0110000000" => 
					color3 <= "101"; 
				when "0110000001" => 
					color3 <= "100"; 
				when "0110000010" => 
					color3 <= "110"; 
				when "0110000011" => 
					color3 <= "010"; 
				when "0110000100" => 
					color3 <= "001"; 
				when "0110000101" => 
					color3 <= "001"; 
				when "0110000110" => 
					color3 <= "001"; 
				when "0110000111" => 
					color3 <= "001"; 
				when "0110001000" => 
					color3 <= "001"; 
				when "0110001001" => 
					color3 <= "001"; 
				when "0110001010" => 
					color3 <= "001"; 
				when "0110001011" => 
					color3 <= "001"; 
				when "0110001100" => 
					color3 <= "001"; 
				when "0110001101" => 
					color3 <= "001"; 
				when "0110001110" => 
					color3 <= "001"; 
				when "0110010000" => 
					color3 <= "100"; 
				when "0110010001" => 
					color3 <= "001"; 
				when "0110010010" => 
					color3 <= "001"; 
				when "0110010011" => 
					color3 <= "010"; 
				when "0110010100" => 
					color3 <= "010"; 
				when "0110010101" => 
					color3 <= "011"; 
				when "0110010110" => 
					color3 <= "001"; 
				when "0110010111" => 
					color3 <= "001"; 
				when "0110011000" => 
					color3 <= "001"; 
				when "0110011001" => 
					color3 <= "001"; 
				when "0110011010" => 
					color3 <= "001"; 
				when "0110011011" => 
					color3 <= "001"; 
				when "0110011100" => 
					color3 <= "001"; 
				when "0110011101" => 
					color3 <= "001"; 
				when "0110011110" => 
					color3 <= "001"; 
				when "0110100001" => 
					color3 <= "001"; 
				when "0110100010" => 
					color3 <= "001"; 
				when "0110100011" => 
					color3 <= "001"; 
				when "0110100100" => 
					color3 <= "011"; 
				when "0110100101" => 
					color3 <= "011"; 
				when "0110100110" => 
					color3 <= "010"; 
				when "0110100111" => 
					color3 <= "001"; 
				when "0110101000" => 
					color3 <= "001"; 
				when "0110101001" => 
					color3 <= "001"; 
				when "0110101010" => 
					color3 <= "001"; 
				when "0110101011" => 
					color3 <= "001"; 
				when "0110101100" => 
					color3 <= "001"; 
				when "0110101101" => 
					color3 <= "001"; 
				when "0110101110" => 
					color3 <= "001"; 
				when "0110110001" => 
					color3 <= "001"; 
				when "0110110010" => 
					color3 <= "001"; 
				when "0110110011" => 
					color3 <= "010"; 
				when "0110110100" => 
					color3 <= "011"; 
				when "0110110101" => 
					color3 <= "011"; 
				when "0110110110" => 
					color3 <= "010"; 
				when "0110110111" => 
					color3 <= "001"; 
				when "0110111000" => 
					color3 <= "001"; 
				when "0110111001" => 
					color3 <= "001"; 
				when "0110111010" => 
					color3 <= "001"; 
				when "0110111011" => 
					color3 <= "001"; 
				when "0110111100" => 
					color3 <= "001"; 
				when "0110111101" => 
					color3 <= "001"; 
				when "0111000010" => 
					color3 <= "001"; 
				when "0111000011" => 
					color3 <= "010"; 
				when "0111000100" => 
					color3 <= "011"; 
				when "0111000101" => 
					color3 <= "010"; 
				when "0111000110" => 
					color3 <= "001"; 
				when "0111000111" => 
					color3 <= "001"; 
				when "0111001000" => 
					color3 <= "001"; 
				when "0111001001" => 
					color3 <= "001"; 
				when "0111001010" => 
					color3 <= "001"; 
				when "0111001011" => 
					color3 <= "001"; 
				when "0111001100" => 
					color3 <= "001"; 
				when "0111010011" => 
					color3 <= "001"; 
				when "0111010100" => 
					color3 <= "001"; 
				when "0111010101" => 
					color3 <= "001"; 
				when "0111010110" => 
					color3 <= "001"; 
				when "0111010111" => 
					color3 <= "001"; 
				when "0111011000" => 
					color3 <= "001"; 
				when "0111011001" => 
					color3 <= "001"; 
				when "0111011010" => 
					color3 <= "001"; 
				when "0111011011" => 
					color3 <= "001"; 
				when "0111100100" => 
					color3 <= "001"; 
				when "0111100101" => 
					color3 <= "001"; 
				when "0111100110" => 
					color3 <= "001"; 
				when "0111100111" => 
					color3 <= "001"; 
				when "0111101000" => 
					color3 <= "001"; 
				when "0111101001" => 
					color3 <= "001"; 
				when "0111101010" => 
					color3 <= "001"; 
 
				--watermelon
				when "1100000101" => 
					color3 <= "001"; 
				when "1100000110" => 
					color3 <= "001"; 
				when "1100000111" => 
					color3 <= "001"; 
				when "1100001000" => 
					color3 <= "001"; 
				when "1100001001" => 
					color3 <= "001"; 
				when "1100001010" => 
					color3 <= "001"; 
				when "1100010011" => 
					color3 <= "001"; 
				when "1100010100" => 
					color3 <= "001"; 
				when "1100010101" => 
					color3 <= "010"; 
				when "1100010110" => 
					color3 <= "010"; 
				when "1100010111" => 
					color3 <= "010"; 
				when "1100011000" => 
					color3 <= "010"; 
				when "1100011001" => 
					color3 <= "010"; 
				when "1100011010" => 
					color3 <= "010"; 
				when "1100011011" => 
					color3 <= "001"; 
				when "1100100010" => 
					color3 <= "001"; 
				when "1100100011" => 
					color3 <= "001"; 
				when "1100100100" => 
					color3 <= "010"; 
				when "1100100101" => 
					color3 <= "011"; 
				when "1100100110" => 
					color3 <= "100"; 
				when "1100100111" => 
					color3 <= "100"; 
				when "1100101000" => 
					color3 <= "011"; 
				when "1100101001" => 
					color3 <= "100"; 
				when "1100101010" => 
					color3 <= "100"; 
				when "1100101011" => 
					color3 <= "010"; 
				when "1100101100" => 
					color3 <= "001"; 
				when "1100110001" => 
					color3 <= "001"; 
				when "1100110010" => 
					color3 <= "001"; 
				when "1100110011" => 
					color3 <= "010"; 
				when "1100110100" => 
					color3 <= "100"; 
				when "1100110101" => 
					color3 <= "100"; 
				when "1100110110" => 
					color3 <= "100"; 
				when "1100110111" => 
					color3 <= "100"; 
				when "1100111000" => 
					color3 <= "100"; 
				when "1100111001" => 
					color3 <= "011"; 
				when "1100111010" => 
					color3 <= "100"; 
				when "1100111011" => 
					color3 <= "011"; 
				when "1100111100" => 
					color3 <= "010"; 
				when "1100111101" => 
					color3 <= "001"; 
				when "1101000001" => 
					color3 <= "001"; 
				when "1101000010" => 
					color3 <= "010"; 
				when "1101000011" => 
					color3 <= "100"; 
				when "1101000100" => 
					color3 <= "011"; 
				when "1101000101" => 
					color3 <= "100"; 
				when "1101000110" => 
					color3 <= "100"; 
				when "1101000111" => 
					color3 <= "011"; 
				when "1101001000" => 
					color3 <= "100"; 
				when "1101001001" => 
					color3 <= "100"; 
				when "1101001010" => 
					color3 <= "011"; 
				when "1101001011" => 
					color3 <= "100"; 
				when "1101001100" => 
					color3 <= "100"; 
				when "1101001101" => 
					color3 <= "001"; 
				when "1101001110" => 
					color3 <= "001"; 
				when "1101010000" => 
					color3 <= "001"; 
				when "1101010001" => 
					color3 <= "001"; 
				when "1101010010" => 
					color3 <= "010"; 
				when "1101010011" => 
					color3 <= "011"; 
				when "1101010100" => 
					color3 <= "100"; 
				when "1101010101" => 
					color3 <= "011"; 
				when "1101010110" => 
					color3 <= "100"; 
				when "1101010111" => 
					color3 <= "100"; 
				when "1101011000" => 
					color3 <= "100"; 
				when "1101011001" => 
					color3 <= "100"; 
				when "1101011010" => 
					color3 <= "100"; 
				when "1101011011" => 
					color3 <= "100"; 
				when "1101011100" => 
					color3 <= "100"; 
				when "1101011101" => 
					color3 <= "010"; 
				when "1101011110" => 
					color3 <= "001"; 
				when "1101100000" => 
					color3 <= "001"; 
				when "1101100001" => 
					color3 <= "010"; 
				when "1101100010" => 
					color3 <= "100"; 
				when "1101100011" => 
					color3 <= "100"; 
				when "1101100100" => 
					color3 <= "100"; 
				when "1101100101" => 
					color3 <= "100"; 
				when "1101100110" => 
					color3 <= "011"; 
				when "1101100111" => 
					color3 <= "100"; 
				when "1101101000" => 
					color3 <= "011"; 
				when "1101101001" => 
					color3 <= "100"; 
				when "1101101010" => 
					color3 <= "100"; 
				when "1101101011" => 
					color3 <= "011"; 
				when "1101101100" => 
					color3 <= "100"; 
				when "1101101101" => 
					color3 <= "010"; 
				when "1101101110" => 
					color3 <= "001"; 
				when "1101110000" => 
					color3 <= "001"; 
				when "1101110001" => 
					color3 <= "010"; 
				when "1101110010" => 
					color3 <= "100"; 
				when "1101110011" => 
					color3 <= "011"; 
				when "1101110100" => 
					color3 <= "100"; 
				when "1101110101" => 
					color3 <= "100"; 
				when "1101110110" => 
					color3 <= "100"; 
				when "1101110111" => 
					color3 <= "100"; 
				when "1101111000" => 
					color3 <= "100"; 
				when "1101111001" => 
					color3 <= "100"; 
				when "1101111010" => 
					color3 <= "011"; 
				when "1101111011" => 
					color3 <= "100"; 
				when "1101111100" => 
					color3 <= "011"; 
				when "1101111101" => 
					color3 <= "010"; 
				when "1101111110" => 
					color3 <= "001"; 
				when "1110000000" => 
					color3 <= "001"; 
				when "1110000001" => 
					color3 <= "010"; 
				when "1110000010" => 
					color3 <= "011"; 
				when "1110000011" => 
					color3 <= "100"; 
				when "1110000100" => 
					color3 <= "100"; 
				when "1110000101" => 
					color3 <= "100"; 
				when "1110000110" => 
					color3 <= "011"; 
				when "1110000111" => 
					color3 <= "100"; 
				when "1110001000" => 
					color3 <= "011"; 
				when "1110001001" => 
					color3 <= "100"; 
				when "1110001010" => 
					color3 <= "100"; 
				when "1110001011" => 
					color3 <= "100"; 
				when "1110001100" => 
					color3 <= "100"; 
				when "1110001101" => 
					color3 <= "010"; 
				when "1110001110" => 
					color3 <= "001"; 
				when "1110010000" => 
					color3 <= "001"; 
				when "1110010001" => 
					color3 <= "001"; 
				when "1110010010" => 
					color3 <= "010"; 
				when "1110010011" => 
					color3 <= "100"; 
				when "1110010100" => 
					color3 <= "011"; 
				when "1110010101" => 
					color3 <= "100"; 
				when "1110010110" => 
					color3 <= "100"; 
				when "1110010111" => 
					color3 <= "100"; 
				when "1110011000" => 
					color3 <= "100"; 
				when "1110011001" => 
					color3 <= "100"; 
				when "1110011010" => 
					color3 <= "100"; 
				when "1110011011" => 
					color3 <= "011"; 
				when "1110011100" => 
					color3 <= "100"; 
				when "1110011101" => 
					color3 <= "010"; 
				when "1110011110" => 
					color3 <= "001"; 
				when "1110100001" => 
					color3 <= "001"; 
				when "1110100010" => 
					color3 <= "010"; 
				when "1110100011" => 
					color3 <= "100"; 
				when "1110100100" => 
					color3 <= "100"; 
				when "1110100101" => 
					color3 <= "100"; 
				when "1110100110" => 
					color3 <= "100"; 
				when "1110100111" => 
					color3 <= "100"; 
				when "1110101000" => 
					color3 <= "011"; 
				when "1110101001" => 
					color3 <= "100"; 
				when "1110101010" => 
					color3 <= "011"; 
				when "1110101011" => 
					color3 <= "100"; 
				when "1110101100" => 
					color3 <= "010"; 
				when "1110101101" => 
					color3 <= "001"; 
				when "1110101110" => 
					color3 <= "001"; 
				when "1110110001" => 
					color3 <= "001"; 
				when "1110110010" => 
					color3 <= "001"; 
				when "1110110011" => 
					color3 <= "010"; 
				when "1110110100" => 
					color3 <= "011"; 
				when "1110110101" => 
					color3 <= "011"; 
				when "1110110110" => 
					color3 <= "100"; 
				when "1110110111" => 
					color3 <= "100"; 
				when "1110111000" => 
					color3 <= "100"; 
				when "1110111001" => 
					color3 <= "100"; 
				when "1110111010" => 
					color3 <= "100"; 
				when "1110111011" => 
					color3 <= "011"; 
				when "1110111100" => 
					color3 <= "010"; 
				when "1110111101" => 
					color3 <= "001"; 
				when "1111000010" => 
					color3 <= "001"; 
				when "1111000011" => 
					color3 <= "001"; 
				when "1111000100" => 
					color3 <= "010"; 
				when "1111000101" => 
					color3 <= "100"; 
				when "1111000110" => 
					color3 <= "100"; 
				when "1111000111" => 
					color3 <= "011"; 
				when "1111001000" => 
					color3 <= "100"; 
				when "1111001001" => 
					color3 <= "011"; 
				when "1111001010" => 
					color3 <= "010"; 
				when "1111001011" => 
					color3 <= "010"; 
				when "1111001100" => 
					color3 <= "001"; 
				when "1111010011" => 
					color3 <= "001"; 
				when "1111010100" => 
					color3 <= "001"; 
				when "1111010101" => 
					color3 <= "010"; 
				when "1111010110" => 
					color3 <= "010"; 
				when "1111010111" => 
					color3 <= "010"; 
				when "1111011000" => 
					color3 <= "010"; 
				when "1111011001" => 
					color3 <= "010"; 
				when "1111011010" => 
					color3 <= "001"; 
				when "1111011011" => 
					color3 <= "001"; 
				when "1111100101" => 
					color3 <= "001"; 
				when "1111100110" => 
					color3 <= "001"; 
				when "1111100111" => 
					color3 <= "001"; 
				when "1111101000" => 
					color3 <= "001"; 
				when "1111101001" => 
					color3 <= "001"; 

				--grapefruit
				when "1000000101" => 
					color3 <= "001"; 
				when "1000000110" => 
					color3 <= "001"; 
				when "1000000111" => 
					color3 <= "001"; 
				when "1000001000" => 
					color3 <= "001"; 
				when "1000001001" => 
					color3 <= "001"; 
				when "1000010011" => 
					color3 <= "001"; 
				when "1000010100" => 
					color3 <= "001"; 
				when "1000010101" => 
					color3 <= "010"; 
				when "1000010110" => 
					color3 <= "010"; 
				when "1000010111" => 
					color3 <= "010"; 
				when "1000011000" => 
					color3 <= "011"; 
				when "1000011001" => 
					color3 <= "010"; 
				when "1000011010" => 
					color3 <= "001"; 
				when "1000011011" => 
					color3 <= "001"; 
				when "1000100010" => 
					color3 <= "001"; 
				when "1000100011" => 
					color3 <= "010"; 
				when "1000100100" => 
					color3 <= "011"; 
				when "1000100101" => 
					color3 <= "010"; 
				when "1000100110" => 
					color3 <= "010"; 
				when "1000100111" => 
					color3 <= "010"; 
				when "1000101000" => 
					color3 <= "011"; 
				when "1000101001" => 
					color3 <= "010"; 
				when "1000101010" => 
					color3 <= "010"; 
				when "1000101011" => 
					color3 <= "011"; 
				when "1000101100" => 
					color3 <= "001"; 
				when "1000110001" => 
					color3 <= "001"; 
				when "1000110010" => 
					color3 <= "010"; 
				when "1000110011" => 
					color3 <= "010"; 
				when "1000110100" => 
					color3 <= "010"; 
				when "1000110101" => 
					color3 <= "011"; 
				when "1000110110" => 
					color3 <= "010"; 
				when "1000110111" => 
					color3 <= "011"; 
				when "1000111000" => 
					color3 <= "010"; 
				when "1000111001" => 
					color3 <= "010"; 
				when "1000111010" => 
					color3 <= "011"; 
				when "1000111011" => 
					color3 <= "010"; 
				when "1000111100" => 
					color3 <= "010"; 
				when "1000111101" => 
					color3 <= "001"; 
				when "1001000000" => 
					color3 <= "001"; 
				when "1001000001" => 
					color3 <= "001"; 
				when "1001000010" => 
					color3 <= "010"; 
				when "1001000011" => 
					color3 <= "010"; 
				when "1001000100" => 
					color3 <= "010"; 
				when "1001000101" => 
					color3 <= "011"; 
				when "1001000110" => 
					color3 <= "010"; 
				when "1001000111" => 
					color3 <= "011"; 
				when "1001001000" => 
					color3 <= "010"; 
				when "1001001001" => 
					color3 <= "011"; 
				when "1001001010" => 
					color3 <= "011"; 
				when "1001001011" => 
					color3 <= "010"; 
				when "1001001100" => 
					color3 <= "010"; 
				when "1001001101" => 
					color3 <= "010"; 
				when "1001010000" => 
					color3 <= "001"; 
				when "1001010001" => 
					color3 <= "011"; 
				when "1001010010" => 
					color3 <= "011"; 
				when "1001010011" => 
					color3 <= "011"; 
				when "1001010100" => 
					color3 <= "011"; 
				when "1001010101" => 
					color3 <= "010"; 
				when "1001010110" => 
					color3 <= "011"; 
				when "1001010111" => 
					color3 <= "011"; 
				when "1001011000" => 
					color3 <= "010"; 
				when "1001011001" => 
					color3 <= "011"; 
				when "1001011010" => 
					color3 <= "010"; 
				when "1001011011" => 
					color3 <= "010"; 
				when "1001011100" => 
					color3 <= "010"; 
				when "1001011101" => 
					color3 <= "011"; 
				when "1001011110" => 
					color3 <= "001"; 
				when "1001100000" => 
					color3 <= "001"; 
				when "1001100001" => 
					color3 <= "010"; 
				when "1001100010" => 
					color3 <= "010"; 
				when "1001100011" => 
					color3 <= "010"; 
				when "1001100100" => 
					color3 <= "011"; 
				when "1001100101" => 
					color3 <= "011"; 
				when "1001100110" => 
					color3 <= "011"; 
				when "1001100111" => 
					color3 <= "011"; 
				when "1001101000" => 
					color3 <= "011"; 
				when "1001101001" => 
					color3 <= "011"; 
				when "1001101010" => 
					color3 <= "011"; 
				when "1001101011" => 
					color3 <= "011"; 
				when "1001101100" => 
					color3 <= "011"; 
				when "1001101101" => 
					color3 <= "011"; 
				when "1001101110" => 
					color3 <= "001"; 
				when "1001110000" => 
					color3 <= "001"; 
				when "1001110001" => 
					color3 <= "010"; 
				when "1001110010" => 
					color3 <= "010"; 
				when "1001110011" => 
					color3 <= "010"; 
				when "1001110100" => 
					color3 <= "010"; 
				when "1001110101" => 
					color3 <= "011"; 
				when "1001110110" => 
					color3 <= "011"; 
				when "1001110111" => 
					color3 <= "011"; 
				when "1001111000" => 
					color3 <= "011"; 
				when "1001111001" => 
					color3 <= "010"; 
				when "1001111010" => 
					color3 <= "010"; 
				when "1001111011" => 
					color3 <= "010"; 
				when "1001111100" => 
					color3 <= "010"; 
				when "1001111101" => 
					color3 <= "010"; 
				when "1001111110" => 
					color3 <= "001"; 
				when "1010000000" => 
					color3 <= "001"; 
				when "1010000001" => 
					color3 <= "011"; 
				when "1010000010" => 
					color3 <= "011"; 
				when "1010000011" => 
					color3 <= "011"; 
				when "1010000100" => 
					color3 <= "011"; 
				when "1010000101" => 
					color3 <= "010"; 
				when "1010000110" => 
					color3 <= "011"; 
				when "1010000111" => 
					color3 <= "011"; 
				when "1010001000" => 
					color3 <= "011"; 
				when "1010001001" => 
					color3 <= "011"; 
				when "1010001010" => 
					color3 <= "011"; 
				when "1010001011" => 
					color3 <= "011"; 
				when "1010001100" => 
					color3 <= "010"; 
				when "1010001101" => 
					color3 <= "010"; 
				when "1010001110" => 
					color3 <= "001"; 
				when "1010010000" => 
					color3 <= "001"; 
				when "1010010001" => 
					color3 <= "011"; 
				when "1010010010" => 
					color3 <= "010"; 
				when "1010010011" => 
					color3 <= "010"; 
				when "1010010100" => 
					color3 <= "010"; 
				when "1010010101" => 
					color3 <= "011"; 
				when "1010010110" => 
					color3 <= "011"; 
				when "1010010111" => 
					color3 <= "011"; 
				when "1010011000" => 
					color3 <= "011"; 
				when "1010011001" => 
					color3 <= "010"; 
				when "1010011010" => 
					color3 <= "010"; 
				when "1010011011" => 
					color3 <= "011"; 
				when "1010011100" => 
					color3 <= "011"; 
				when "1010011101" => 
					color3 <= "011"; 
				when "1010011110" => 
					color3 <= "001"; 
				when "1010100000" => 
					color3 <= "001"; 
				when "1010100001" => 
					color3 <= "001"; 
				when "1010100010" => 
					color3 <= "010"; 
				when "1010100011" => 
					color3 <= "010"; 
				when "1010100100" => 
					color3 <= "011"; 
				when "1010100101" => 
					color3 <= "011"; 
				when "1010100110" => 
					color3 <= "010"; 
				when "1010100111" => 
					color3 <= "011"; 
				when "1010101000" => 
					color3 <= "010"; 
				when "1010101001" => 
					color3 <= "011"; 
				when "1010101010" => 
					color3 <= "010"; 
				when "1010101011" => 
					color3 <= "010"; 
				when "1010101100" => 
					color3 <= "010"; 
				when "1010101101" => 
					color3 <= "010"; 
				when "1010110001" => 
					color3 <= "001"; 
				when "1010110010" => 
					color3 <= "010"; 
				when "1010110011" => 
					color3 <= "011"; 
				when "1010110100" => 
					color3 <= "011"; 
				when "1010110101" => 
					color3 <= "010"; 
				when "1010110110" => 
					color3 <= "010"; 
				when "1010110111" => 
					color3 <= "011"; 
				when "1010111000" => 
					color3 <= "010"; 
				when "1010111001" => 
					color3 <= "011"; 
				when "1010111010" => 
					color3 <= "011"; 
				when "1010111011" => 
					color3 <= "010"; 
				when "1010111100" => 
					color3 <= "010"; 
				when "1010111101" => 
					color3 <= "001"; 
				when "1011000010" => 
					color3 <= "001"; 
				when "1011000011" => 
					color3 <= "011"; 
				when "1011000100" => 
					color3 <= "010"; 
				when "1011000101" => 
					color3 <= "010"; 
				when "1011000110" => 
					color3 <= "011"; 
				when "1011000111" => 
					color3 <= "011"; 
				when "1011001000" => 
					color3 <= "010"; 
				when "1011001001" => 
					color3 <= "010"; 
				when "1011001010" => 
					color3 <= "011"; 
				when "1011001011" => 
					color3 <= "011"; 
				when "1011001100" => 
					color3 <= "001"; 
				when "1011010011" => 
					color3 <= "001"; 
				when "1011010100" => 
					color3 <= "001"; 
				when "1011010101" => 
					color3 <= "010"; 
				when "1011010110" => 
					color3 <= "011"; 
				when "1011010111" => 
					color3 <= "010"; 
				when "1011011000" => 
					color3 <= "010"; 
				when "1011011001" => 
					color3 <= "010"; 
				when "1011011010" => 
					color3 <= "010"; 
				when "1011011011" => 
					color3 <= "001"; 
				when "1011100101" => 
					color3 <= "001"; 
				when "1011100110" => 
					color3 <= "001"; 
				when "1011100111" => 
					color3 <= "001"; 
				when "1011101000" => 
					color3 <= "001"; 
				when "1011101001" => 
					color3 <= "001"; 
				
	 when others => color3 <= "000";
 
				end case;
			end if;
	end process;

	address <= fruit_type & col & row;

	mappingrgb: maprgb
	port map(
		color3 => color3, fruit_type => fruit_type, color=>color
	);

	-- --blueberry
	-- color <= "000001" when (fruit_type="00" and color3="001")
	-- else "010110" when (fruit_type="00" and color3="010")
	-- else "000101" when (fruit_type="00" and color3="011")
	-- else "000110" when (fruit_type="00" and color3="100")
	-- else "010101" when (fruit_type="00" and color3="101")
	-- --cherry
	-- else "010000" when (fruit_type="01" and color3="001")
	-- else "100000" when (fruit_type="01" and color3 = "010")
	-- else "100100" when (fruit_type="01" and color3 = "011")
	-- else "110101" when (fruit_type="01" and color3 = "100")
	-- else "010101" when (fruit_type="01" and color3 = "101")
	-- else "111010" when (fruit_type="01" and color3 = "110")
	-- else "111111" when (fruit_type="01" and color3 = "111")
	-- --watermelon
	-- else "110001" when (fruit_type="10" and color3="001")
	-- else "100000" when (fruit_type="10" and color3 = "010")
	-- else "111001" when (fruit_type="10" and color3 = "011")
	-- else "010100" when (fruit_type="10" and color3 = "100")
	-- else "101001" when (fruit_type="10" and color3 = "101")
	-- else "011000" when (fruit_type="10" and color3 = "110")
	-- else "000100" when (fruit_type="10" and color3 = "111")

	-- --grapefruit
	-- else "111010" when (fruit_type="11" and color3="001")
	-- else "100100" when (fruit_type="11" and color3 = "010")
	-- else "111001" when (fruit_type="11" and color3 = "011")
	-- else "010101" when (fruit_type="11" and color3 = "100")
	-- else "111110" when (fruit_type="11" and color3 = "101")
	-- else "111001" when (fruit_type="11" and color3 = "110")
	-- else "010000" when (fruit_type="11" and color3 = "111")
	-- else "000000"; 

end;