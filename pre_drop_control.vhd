-- update center horizontal value
library IEEE;
use IEEE.std_logic_1164.all;

entity pre_drop_control is 
  port(
        state: in std_logic_vector(1 downto 0);
        NES_controller: in std_logic_vector (7 downto 0);
    );


architecture synth of pre_drop_control is
  curr_center = default_value;

  
  if state == "01":

    -- read curr_center
    -- TODO don't update if at extreme
    if NES_controller == "00000010": -- left
        curr_center -= 2;
  
    else if NES_controller == "00000001": -- right
        curr_center += 2;
  
    -- else don't update
  
    -- write curr_center
