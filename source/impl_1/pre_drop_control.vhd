---- update center horizontal value
--library IEEE;
--use IEEE.std_logic_1164.all;
--use IEEE.numeric_std.all;

--entity pre_drop_control is 
  --port(
        --curr_center: in unsigned(4 downto 0);
        --NES_controller: in std_logic_vector (7 downto 0);
        --new_center: out unsigned(4 downto 0)
    --);


--architecture synth of pre_drop_control is
--signal curr_center : unsigned(3 downto 0);

--begin
    --if NES_controller == "00000010": -- left
        --if curr_center > "00011" then
          --curr_center <= curr_center;
        --else curr_center <= curr_center - 2;
  
    --elsif NES_controller == "00000001": -- right
        --if curr_center <"101010" then
          --curr_center = curr_center + 2;
        --else curr_center <= curr_center;
--end;