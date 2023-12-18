library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library xil_defaultlib; 
use xil_defaultlib.matpack.all;

entity SubBytes_tb is 
end SubBytes_tb;

architecture SubBytes_tbArch of SubBytes_tb is

component SubBytes is port(
    Clk : in std_logic;
    input : in matrix;
    output : out matrix
); end component;

signal input : matrix;
signal output : matrix;
signal Clk : std_logic := '0';

signal result: matrix;
signal plaintext: std_logic_vector(0 to 127);
signal resultExa : std_logic_vector(0 to 127);

begin
    uut : SubBytes port map(Clk => Clk, input => input, output => output);
    clock_process: process
    begin
        plaintext <= x"40BFABF406EE4D3042CA6B997A5C5816";
        resultExa <= x"090862BF6F28E3042C747FEEDA4A6A47";
        for i in 0 to 3 loop
            for j in 0 to 3 loop
                for l in 0 to 7 loop
                    input(i)(j)(l) <= plaintext(j*32+i*8+l);
                    result(i)(j)(l) <= resultExa(j*32+i*8+l);
                end loop;
            end loop;
        end loop;
        wait for 200ns;
        Clk <= not Clk;
    end process clock_process;
end SubBytes_tbArch;