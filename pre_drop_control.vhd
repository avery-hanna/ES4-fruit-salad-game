-- update center horizontal value
library IEEE;
use IEEE.std_logic_1164.all;

entity pre_drop_control is 
  port(
        curr_center: in std_logic_vector(6 downto 0);
        NES_controller: in std_logic_vector (7 downto 0);
        new_center: out std_logic_vector(7 downto 0)
    );


architecture synth of pre_drop_control is
signal curr_center : unsigned(3 downto 0);
  curr_center = default_value;

  
  if state == "01":

    -- read curr_center
    -- TODO don't update if at extreme
    if NES_controller == "00000010": -- left
        if curr_center <= "0000010" then
          curr_center <= curr_center;
        else curr_center <= curr_center - 2;
  
    elsif NES_controller == "00000001": -- right
        if curr_
        curr_center = curr_center + 2;
  
    -- else don't update
  
    -- write curr_center
