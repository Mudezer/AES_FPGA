library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity AddRoundKey is port(
    Clk : in std_logic;
--    Reset : in std_logic;
--    LOAD : in std_logic;
    plain : in std_logic_vector(127 downto 0);
    key : in std_logic_vector(127 downto 0);
    output : out std_logic_vector(127 downto 0)
); end AddRoundKey;


architecture arch of AddRoundKey is begin
    proc : process(Clk) is begin
        if (rising_edge(Clk)) then
            output <= plain xor key;
        end if;
    end process;
end arch;

    