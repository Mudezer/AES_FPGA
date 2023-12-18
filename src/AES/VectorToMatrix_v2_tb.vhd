library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity VectorToMatrix_tb is
end VectorToMatrix_tb;

architecture ben of VectorToMatrix_tb is 

component VectorToMatrix is port(
    input: in std_logic_vector(0 to 127);
    output : out matrix
); end component;


signal input : std_logic_vector(0 to 127);
signal output : matrix;

signal resultExa : std_logic_vector(0 to 127);
signal result : matrix;


begin
    VTM : VectorToMatrix port map(input => input, output => output);

    stim2 : process
    begin
        wait for 10 ns;
        input <= x"6BC1BEE22E409F96E93D7E117393172A";
        resultExa <= x"6BC1BEE22E409F96E93D7E117393172A";

        for i in 0 to 3 loop
            for j in 0 to 3 loop
                for l in 0 to 7 loop
                result(i)(j)(l) <= resultExa(j*32+i*8+l);
                end loop;
            end loop;
        end loop;

        wait for 10 ns;
    end process stim2;
end ben;