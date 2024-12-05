--
-- Synopsys
-- Vhdl wrapper for top level design, written on Thu Dec  5 11:43:38 2024
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity wrapper_for_vga_controller is
   port (
      external_osc : in std_logic;
      RGB : out std_logic_vector(5 downto 0);
      HSYNC : out std_logic;
      VSYNC : out std_logic;
      ext_osc_test : out std_logic;
      CTRLclk : out std_logic;
      NESclk : out std_logic;
      latch : out std_logic;
      data : in std_logic;
      buttonout : out std_logic_vector(7 downto 0);
      led : out std_logic
   );
end wrapper_for_vga_controller;

architecture synth of wrapper_for_vga_controller is

component vga_controller
 port (
   external_osc : in std_logic;
   RGB : out std_logic_vector (5 downto 0);
   HSYNC : out std_logic;
   VSYNC : out std_logic;
   ext_osc_test : out std_logic;
   CTRLclk : out std_logic;
   NESclk : out std_logic;
   latch : out std_logic;
   data : in std_logic;
   buttonout : out std_logic_vector (7 downto 0);
   led : out std_logic
 );
end component;

signal tmp_external_osc : std_logic;
signal tmp_RGB : std_logic_vector (5 downto 0);
signal tmp_HSYNC : std_logic;
signal tmp_VSYNC : std_logic;
signal tmp_ext_osc_test : std_logic;
signal tmp_CTRLclk : std_logic;
signal tmp_NESclk : std_logic;
signal tmp_latch : std_logic;
signal tmp_data : std_logic;
signal tmp_buttonout : std_logic_vector (7 downto 0);
signal tmp_led : std_logic;

begin

tmp_external_osc <= external_osc;

RGB <= tmp_RGB;

HSYNC <= tmp_HSYNC;

VSYNC <= tmp_VSYNC;

ext_osc_test <= tmp_ext_osc_test;

CTRLclk <= tmp_CTRLclk;

NESclk <= tmp_NESclk;

latch <= tmp_latch;

tmp_data <= data;

buttonout <= tmp_buttonout;

led <= tmp_led;



u1:   vga_controller port map (
		external_osc => tmp_external_osc,
		RGB => tmp_RGB,
		HSYNC => tmp_HSYNC,
		VSYNC => tmp_VSYNC,
		ext_osc_test => tmp_ext_osc_test,
		CTRLclk => tmp_CTRLclk,
		NESclk => tmp_NESclk,
		latch => tmp_latch,
		data => tmp_data,
		buttonout => tmp_buttonout,
		led => tmp_led
       );
end synth;
