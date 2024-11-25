library IEEE;
use IEEE.std_logic_1164.all;

entity top is
  port(
      NESinput : in std_logic_vector(7 downto 0);
      clk : in std_logic;
      HSYNC : out std_logic;
      VSYNC : out std_logic
    );

  architecture toparch of top is
  type STATE is (START, PLAY, DROP, OVER);
  signal curr_state : STATE := START;
  signal center : unsigned(4 downto 0);
  signal new_center : unsigned(4 downto 0);
  signal new_color : std_logic;
  signal color : std_logic_vector(4 downto 0);
  begin
    component pre_drop_controller is (
      state: in std_logic_vector(1 downto 0);
      NES_controller: in std_logic_vector(6 downto 0)
      );

    center_update : pre_drop_controller port map(NES_controller, center, new_center);

    -- State machine logic
    process(clk) begin
      if rising_edge(clk) then
        begin case curr_state
          when START =>
              -- on any input switch to PLAY
              center <= 5d"24";
              if NES_controller /= 8b"0" then
                  curr_state <= PLAY;
              end if;
          when PLAY =>
              center <= new_center;
              if NES_controller == "00000100" then -- clicked to drop
                  curr_state <= DROP;
          when DROP =>
              center <= 5d"24";
              -- TODO input drop logic
              curr_state <= OVER;
          when OVER =>
              time.wait(3);
              curr_state <= START;
          when others =>
              curr_state <= START;         

        end case;
      end if;
    end process;
  end;