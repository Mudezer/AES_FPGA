library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity MatrixToVector_tb is
end MatrixToVector_tb;

architecture ben of MatrixToVector_tb is

component MatrixToVector is port(
    input : in matrix;
    output : out std_logic_vector(0 to 127)
); end component;

signal input : matrix;
signal output : std_logic_vector(0 to 127);

signal plaintext : std_logic_vector(0 to 127);
signal result : std_logic_vector(0 to 127);
-- signal result : matrix;

begin
    MTV : MatrixToVector port map(input => input, output => output);

    stim2 : process
    begin
        wait for 10 ns;
        plaintext <= x"6BC1BEE22E409F96E93D7E117393172A";
        result <= x"6BC1BEE22E409F96E93D7E117393172A";
        for i in 0 to 3 loop
            for j in 0 to 3 loop
                for l in 0 to 7 loop
                input(i)(j)(l) <= plaintext(j*32+i*8+l);
                end loop;
            end loop;
        end loop;
        wait for 10 ns;
    end process stim2;
end ben;

