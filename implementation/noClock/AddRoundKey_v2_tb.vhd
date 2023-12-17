library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;


entity AddRoundKey_tb is
end AddRoundKey_tb;

architecture ben of AddRoundKey_tb is

component AddRoundKey is port(
    input : in matrix;
    key : in std_logic_vector(0 to 127);
    output : out matrix
); end component;

signal input : matrix;
signal key : std_logic_vector(0 to 127);
signal output : matrix;

signal plaintext : std_logic_vector(0 to 127);
signal resultExa : std_logic_vector(0 to 127);
signal result : matrix;


begin
    ptd : AddRoundKey port map(input => input , key => key, output => output);

    stim : process
    begin
        wait for 10 ns;
        plaintext <= x"6BC1BEE22E409F96E93D7E117393172A";
        resultExa <= x"40BFABF406EE4D3042CA6B997A5C5816";
        for i in 0 to 3 loop
            for j in 0 to 3 loop
                for l in 0 to 7 loop
                input(i)(j)(l) <= plaintext(j*32+i*8+l);
                result(i)(j)(l) <= resultExa(j*32+i*8+l);
                end loop;
            end loop;
        end loop;
        key <= x"2B7E151628AED2A6ABF7158809CF4F3C";
        wait for 10 ns; 
    end process stim;
end ben;
