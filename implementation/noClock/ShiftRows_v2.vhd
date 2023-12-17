library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library xil_defaultlib; 
use xil_defaultlib.matpack.all;

entity ShiftRows is port(
    input : in matrix;
    output : out matrix
); end ShiftRows;


architecture arch of ShiftRows is begin
    proc : process(input) is begin
        -- first row
        output(0)(0) <= input(0)(0);
        output(0)(1) <= input(0)(1);
        output(0)(2) <= input(0)(2);
        output(0)(3) <= input(0)(3);
        -- second row
        output(1)(0) <= input(1)(1);
        output(1)(1) <= input(1)(2);
        output(1)(2) <= input(1)(3);
        output(1)(3) <= input(1)(0);
        -- third row
        output(2)(0) <=  input(2)(2);
        output(2)(1) <=  input(2)(3);
        output(2)(2) <=  input(2)(0);
        output(2)(3) <=  input(2)(1);
        -- fourth row
        output(3)(0) <= input(3)(3);
        output(3)(1) <= input(3)(0);
        output(3)(2) <= input(3)(1);
        output(3)(3) <= input(3)(2);
    end process proc;
end architecture arch;