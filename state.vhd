library IEEE;
use IEEE.std_logic_1164.all;

entity top is
  port(
      NESinput: in std_logic_vector(7 downto 0);
      clk: in std_logic
    );

  architecture toparch of top is
    signal statevect: std_logic_vector(1 downto 0);


    component predropcontroller is (
      state: in std_logic_vector(1 downto 0);
      NES_controller: in std_logic_vector(7 downto 0)
      );

    instance: predropcontroller
      port map predropcontroller(NESinput=> NES_controller, statevect => state);
    

  end;
