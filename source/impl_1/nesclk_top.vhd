library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity nesclk_top is
  port(
		NESclk: out std_logic;
		latch: out std_logic;
		CTRLclk: out std_logic;
		output: out std_logic_vector(7 downto 0);
		data: in std_logic
		--clk: in std_logic
  );
end entity nesclk_top;

architecture synth of nesclk_top is
        component HSOSC is
        generic (
            CLKHF_DIV : String := "0b00");
        port (
            CLKHFPU : in std_logic := 'X';
            CLKHFEN : in std_logic := 'X';
            CLKHF : out std_logic := 'X');
        end component;
		
		component shift8 is
		port(
			clkshift: in std_logic;
			input: in std_logic;
			result: out std_logic_vector(7 downto 0)
		);
		end component;
        
        signal clk: std_logic;
        signal counter: unsigned(19 downto 0) := 20b"0";
        signal NEScount: unsigned(7 downto 0);
		signal result: std_logic_vector(7 downto 0);
		signal countshifts: unsigned(7 downto 0);
		--signal tocopy: unsigned(3 downto 0);

begin
        instanceosc: HSOSC
                generic map(CLKHF_DIV => "0b00")
                port map (CLKHFPU =>'1', CLKHFEN => '1', CLKHF => clk);
					
                
                process(clk) begin
                        if rising_edge(clk) then
                                counter <= counter + 1;
                        end if;
                end process;
                
                NESclk <= counter(8);
                NEScount<=counter(16 downto 9);
                latch <= '1' when (NEScount = "11111111")
                else '0';
                CTRLclk <= NESclk when (NEScount = "00000000")
					else NESclk when (NEScount = "00000001")
					else NESclk when (NEScount = "00000010")
					else NESclk when (NEScount = "00000011")
					else NESclk when (NEScount = "00000100")
					else NESclk when (NEScount = "00000101")
					else NESclk when (NEScount = "00000110")
					else NESclk when (NEScount = "00000111")
					else '0';
					
					
			
			
			--readdata <= data;
			instanceshift: shift8
			port map(clkshift => CTRLclk, input => data, result=>result);
		
			--port map(clkshift => NESclk, input => data, result=>result);
			countshifts <= unsigned(NEScount);
			--tocopy <= countshifts mod 4d"8";
			--output <= result when (tocopy="0000");
			--output <= result when (NEScount="00001000");
			
			
			output <= result when (NEScount="00001000");
			
end;