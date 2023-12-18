library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;


entity AddRoundKey is port(
    Clk : in std_logic;
    input: in matrix;
    key : in std_logic_vector(0 to 127);
    output : out matrix
); end AddRoundKey;


architecture arch of AddRoundKey is begin
    proc : process(Clk) is begin
        if (rising_edge(Clk)) then
            for i in 0 to 3 loop
                for j in 0 to 3 loop
                    for l in 0 to 7 loop
                        output(i)(j)(l) <= input(i)(j)(l) xor key(j*32 + i*8 + l);
                    end loop;
                end loop;
            end loop;
        end if;
    end process;
end arch;
