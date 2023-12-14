library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity ShiftRows is port(
    Clk : in std_logic;
    plain: in std_logic_vector(127 downto 0);
    output : out std_logic_vector(127 downto 0)
); end ShiftRows;

architecture arch of ShiftRows is
    signal subVector1 : std_logic_vector(31 downto 0);
    signal subVector2 : std_logic_vector(31 downto 0);
    signal subVector3 : std_logic_vector(31 downto 0);
    signal subVector4 : std_logic_vector(31 downto 0);

    begin
        subVector1 <= plain(31 downto 0);
        subVector2 <= plain(63 downto 32);
        subVector3 <= plain(95 downto 64);
        subVector4 <= plain(127 downto 96);

       process(Clk) is begin
            if (rising_edge(Clk)) then
                output <= subVector1 & subVector2 & subVector3 & subVector4;
            end if;
        end process;
end arch;