library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity VectorToMatrix is port(
    input : in std_logic_vector(0 to 127);
    output : out matrix
); end VectorToMatrix;

architecture arch of VectorToMatrix is begin
    andling : process(input) begin
        for i in 0 to 3 loop
            for j in 0 to 3 loop
                for l in 0 to 7 loop
                    output(i)(j)(l) <= input(j*32+i*8+ l);
                end loop;
            end loop;
        end loop;
    end process;
end arch;