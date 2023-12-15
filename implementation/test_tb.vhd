library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity test_tb is
end test_tb;

architecture test_tbArch of test_tb is

component test is port(
    input : in matrix;
    output : out matrix
); end component;

signal plaintext : std_logic_vector(127 downto 0);
signal output : matrix;
signal input : matrix;

signal resultExa : std_logic_vector(127 downto 0);
signal result : matrix;

begin
    uut : test port map( input => input, output => output );
    stim : process
    begin
        wait for 10ns;
        plaintext <= x"090862BF6F28E3042C747FEEDA4A6A47";
        resultExa <= x"09287F476F746ABF2C4A6204DA08E3EE";
        for i in 0 to 3 loop
            for j in 0 to 3 loop
                for l in 0 to 7 loop
                    input(i)(j)(l) <= plaintext(j*32+i*8+l);
                    result(i)(j)(l) <= resultExa(j*32+i*8+l);
                end loop;
            end loop;
        end loop;

        wait for 10ns;
    end process;
end test_tbArch;