library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity vga_controller is
  port(
  external_osc : in std_logic;
  RGB: out std_logic_vector(5 downto 0);
  HSYNC : out std_logic;
  VSYNC : out std_logic;
  ext_osc_test : out std_logic;
  CTRLclk: out std_logic;
  NESclk: out std_logic;
  latch: out std_logic;
  data: in std_logic;
  buttonout: out std_logic_vector(7 downto 0);
  led : out std_logic
  );
  
  end entity vga_controller;
  
  architecture synth of vga_controller is
	
  component mypll is
    port(
        ref_clk_i: in std_logic; -- clock
        rst_n_i: in std_logic; -- reset (active low)
        outcore_o: out std_logic; -- Output to pins
        outglobal_o: out std_logic -- Output for clock network
    );
end component;


component nesclk_top is
  port(
		NESclk: out std_logic;
		latch: out std_logic;
		CTRLclk: out std_logic;
		output: out std_logic_vector(7 downto 0);
		data: in std_logic
  );
  end component;
	
	component vga is
	  port(
		clk : in std_logic;
	    HSYNC : out std_logic;
	    VSYNC : out std_logic;
		valid : out std_logic;
		row : out std_logic_vector(9 downto 0);
		col : out std_logic_vector(9 downto 0)
    );
end component;

component pattern_gen is
  port(
		valid : in std_logic;
		button: in std_logic_vector(7 downto 0);
		row : in std_logic_vector(9 downto 0); -- row of pixel we want to get color for
		col : in std_logic_vector(9 downto 0); -- col of pixel we want to get color for
		clk : in std_logic;
		RGB : out std_logic_vector(5 downto 0); -- color for pixel (curr_row, curr_col);
		led : out std_logic
);
end component;

	signal ref_clk_i : std_logic;
	signal rst_n_i: std_logic;
	signal outglobal_o : std_logic;
	signal clk : std_logic;
	signal outcore_o : std_logic;
	signal valid: std_logic;
	signal row : std_logic_vector(9 downto 0);
	signal col : std_logic_vector(9 downto 0); 
	signal patterndata:std_logic;
	signal output: std_logic_vector(7 downto 0);
	signal button: std_logic_vector(7 downto 0);
	signal counter: unsigned(2 downto 0);
begin
 


firstblock : mypll
	port map (
		ref_clk_i => external_osc,
		rst_n_i => '1',
		outglobal_o => clk,
		outcore_o => ext_osc_test
	);
	

secondblock : vga
	port map (
		clk => clk,
		HSYNC => HSYNC,
		VSYNC => VSYNC,
		valid => valid,
		row => row,
		col => col
	);

nesblock: nesclk_top
	port map(
		NESclk=>NESclk,
		latch=>latch,
		CTRLclk=>Ctrlclk,
		output=>output,
		data=>data
	);
	
	button <= output;
	buttonout <= not output;
	
	
thirdblock : pattern_gen
	port map (
		button => button,
		valid => valid,
		row => row,
		col => col,
		RGB => RGB,
		clk => clk,
		led => led
	);


end synth;