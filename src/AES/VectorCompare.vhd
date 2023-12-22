library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity VectorCompare is port(
    input : in std_logic_vector(0 to 127);
    expected : in std_logic_vector(0 to 127);
    output : out boolean
); end VectorCompare;

architecture arch of VectorCompare is

signal result : boolean;

begin
    proc : process
    begin
        if (input = expected) then
            output <= true;
        else
            output <= false;
        end if;
    end process proc;
end arch;
