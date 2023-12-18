library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity ShiftRows_tb is
end ShiftRows_tb;

architecture ben of ShiftRows_tb is

component ShiftRows is port(
    input : in matrix;
    output : out matrix
); end component;

signal input : matrix;
signal output : matrix;

signal plaintext : std_logic_vector(0 to 127);
signal resultExa : std_logic_vector(0 to 127);
signal result : matrix;

begin
    shift : ShiftRows port map(input => input, output => output);
    stim2 : process
    begin
        wait for 10 ns;
        plaintext <= x"090862BF6F28E3042C747FEEDA4A6A47";
        resultExa <= x"09287F476F746ABF2C4A6204DA08E3EE";

        for i in 0 to 3 loop
            for j in 0 to 3 loop
                for l in 0 to 7 loop
                    input(i)(j)(l) <= plaintext(32*j+8*i+l);
                    result(i)(j)(l) <= resultExa(32*j+8*i+l);
                end loop;
            end loop;
        end loop;
        wait for 10 ns;
    end process;
end ben;