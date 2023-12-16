library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;


entity VectorToMatrix is port(
    Clk: in std_logic;
    plain : in std_logic_vector(0 to 127);
    output : out matrix
); end VectorToMatrix;


architecture arch of VectorToMatrix is begin
    proc : process(Clk) is begin
        if (rising_edge(Clk)) then
            
            for i in 0 to 3 loop
                for j in 0 to 3 loop 
                    for l in 0 to 7 loop
                        output(i)(j)(l) <= plain(j*32+i*8+l);
                    end loop;
                end loop;
            end loop;

        end if;
    end process proc;
end arch;
