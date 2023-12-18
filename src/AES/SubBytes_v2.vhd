library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library xil_defaultlib; 
use xil_defaultlib.matpack.all;

entity SubBytes is port(
    input : in matrix;
    output : out matrix
); end SubBytes;

architecture arch of SubBytes is 


component S_box is port(
    byte_in : in std_logic_vector(0 to 7);
    byte_out : out std_logic_vector(0 to 7)
); end component S_box;


signal temp : matrix;


begin 
box_gen: for i in 0 to 16 generate
    begin

    -- first rowwww
    box_row_one: if i < 4 generate
        box1 : S_box port map(input(0)(i), temp(0)(i));
        output(0)(i) <= temp(0)(i);
    end generate box_row_one;

    -- second row
    box_row_two: if i >= 4 and i < 8 generate
        box2 : S_box port map(input(1)(i-4), temp(1)(i-4));
        output(1)(i-4) <= temp(1)(i-4);
    end generate box_row_two;

    -- third row
    box_row_three: if i >= 8 and i < 12 generate
        box3 : S_box port map(input(2)(i-8), temp(2)(i-8));
        output(2)(i-8) <= temp(2)(i-8);
    end generate box_row_three;

    -- fourth row
    box_row_four: if i >= 12 and i < 16 generate
        box4 : S_box port map(input(3)(i-12), temp(3)(i-12));
        output(3)(i-12) <= temp(3)(i-12);
    end generate box_row_four;

end generate box_gen;
end arch;