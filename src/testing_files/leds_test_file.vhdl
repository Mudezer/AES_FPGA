library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LED_0_controller is
    Port ( 
    clk: in STD_LOGIC; 
    btnR : in STD_LOGIC;
    btnL: in STD_LOGIC;
    btnC: in std_logic;
    led0 : out STD_LOGIC;
    led1 : out STD_LOGIC;
    led2 : out std_logic
    );
end LED_0_controller;

architecture Behavioral of LED_0_controller is
begin
process(clk) is
begin
    if rising_edge(clk) then
       led0 <= btnR;
       led1 <= btnC;
        led2 <= btnL;
    end if;
end process;

end Behavioral;