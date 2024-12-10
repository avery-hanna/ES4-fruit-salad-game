library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity getRandomFruit is
	port(
		clk: in std_logic;
		fruitout: out unsigned(1 downto 0);
		reset: in std_logic
	);
	end getRandomFruit;
	
	architecture synth of getRandomFruit is
	signal randgenerator: std_logic_vector(3 downto 0);
		begin
			process(clk, reset) begin
			if rising_edge(clk) then
				if reset='1' then
					randgenerator <= "0001";
				else
					randgenerator <= randgenerator(0) & (randgenerator(0) xor randgenerator(3)) & randgenerator(2 downto 1);
				end if;
			end if;
		end process;
		fruitout <= unsigned(randgenerator(3 downto 2)) when unsigned(randgenerator(3 downto 2)) /= "11" else "00";
		end;
				
					
					