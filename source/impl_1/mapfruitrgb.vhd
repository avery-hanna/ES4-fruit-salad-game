library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity maprgb is
  port(
	  color3 : in std_logic_vector(2 downto 0);
	  fruit_type: in std_logic_vector(1 downto 0);
	  color : out std_logic_vector(5 downto 0)
  );
end maprgb;

architecture synth of maprgb is
begin

--blueberry
color <= "010110" when (fruit_type="00" and color3="001")
else "000001" when (fruit_type="00" and color3="010")
--cherry
else "100000" when (fruit_type="01" and color3="001")
else "110101" when (fruit_type="01" and color3 = "010")
else "111111" when (fruit_type="01" and color3 = "011")
else "011000" when (fruit_type="01" and color3 = "100")
else "010000" when (fruit_type="01" and color3 = "101")
else "100100" when (fruit_type="01" and color3 = "110")
--grapefruit
else "111001" when (fruit_type="10" and color3="001")
else "110101" when (fruit_type="10" and color3 = "010")
else "111110" when (fruit_type="10" and color3 = "011")
--watermelon
else "011001" when (fruit_type="11" and color3="001")
else "111111" when (fruit_type="11" and color3 = "010")
else "100000" when (fruit_type="11" and color3 = "011")
else "110001" when (fruit_type="11" and color3 = "100")
else "000000"; 

end;