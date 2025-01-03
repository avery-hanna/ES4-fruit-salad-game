library IEEE;
use IEEE.std_logic_1164.all;

entity shift8 is
	port(
		clkshift: in std_logic;
		input: in std_logic;
		result: out std_logic_vector(7 downto 0)
	);
	end shift8;
	
	architecture synth of shift8 is
		signal in0: std_logic;
		signal in1: std_logic;
		signal in2: std_logic;
		signal in3: std_logic;
		signal in4: std_logic;
		signal in5: std_logic;
		signal in6: std_logic;
		signal in7: std_logic;
		
		begin
			process(clkshift) begin
				if rising_edge(clkshift) then
					in0 <= input;
					in1 <= in0;
					in2 <= in1;
					in3 <= in2;
					in4 <= in3;
					in5 <= in4;
					in6 <= in5;
					in7 <= in6;
				end if;
			end process;
			result(0) <= in0;
			result(1) <= in1;
			result(2) <= in2;
			result(3) <= in3;
			result(4) <= in4;
			result(5) <= in5;
			result(6) <= in6;
			result(7) <= in7;
		end;