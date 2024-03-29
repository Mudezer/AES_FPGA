library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity MatrixToVector is port(
    input : in matrix;
    output : out std_logic_vector(0 to 127)
); end MatrixToVector;

architecture arch of MatrixToVector is begin
    andling : process(input) begin
        for i in 0 to 3 loop
            for j in 0 to 3 loop
                for l in 0 to 7 loop
                    output(32*j+8*i+l) <= input(i)(j)(l);
                end loop;
            end loop;
        end loop;
    end process;
end arch;