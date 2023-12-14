library ieee;
use ieee.std_logic_1164.all;



entity D_FF is port(
    D : in std_logic_vector(127 downto 0); -- 128 bit input
    Clk : in std_logic;
    Q : out std_logic_vector(127 downto 0) -- 128 bit output
); end D_FF;

architecture arch of D_FF is begin
    proc : process(Clk) begin
        if (rising_edge(Clk)) then
            Q <= D;
        end if;
    end process;
end arch;