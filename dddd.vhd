library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dddd is
  port(
    value : in unsigned(5 downto 0);    
    tensdigit : out std_logic_vector(3 downto 0);    
    onesdigit : out std_logic_vector(3 downto 0)
  );
end dddd;

architecture sim of dddd is
signal tensplace_intermediate : std_logic_vector(12 downto 0);

begin
	onesdigit <= std_logic_vector(value mod 4d"10");

	tensplace_intermediate <= std_logic_vector(value * 7d"52");
	tensdigit <= tensplace_intermediate(12 downto 9);
end;
