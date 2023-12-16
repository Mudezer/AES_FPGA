library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity MixColumns_tb is
end MixColumns_tb;

architecture MixColumns_tbArch of MixColumns_tb is


component MixColumns is port(
    input : in matrix;
    output : out matrix
); end component;

signal plaintext : std_logic_vector(0 to 127);
signal input : matrix;
signal output : matrix;

signal resultExa : std_logic_vector(0 to 127);
signal result : matrix;

begin
    uut : MixColumns port map(input => input, output => output);
    stim : process
    begin
        wait for 10ns;
        plaintext <= x"09287F476F746ABF2C4A6204DA08E3EE";
        resultExa <= x"529F16C2978615CAE01AAE54BA1A2659";
        for i in 0 to 3 loop
            for j in 0 to 3 loop
                for l in 0 to 7 loop
                    input(i)(j)(l) <= plaintext(j*32+i*8+l);
                    result(i)(j)(l) <= resultExa(j*32+i*8+l);
                end loop;
            end loop;
        end loop;
        wait for 10 ns;
    end process;
end MixColumns_tbArch;