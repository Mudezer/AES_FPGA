library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity ShifRows_tb is 
end entity;

architecture ben of ShifRows_tb is
    component ShifRows is port(
        plain : in std_logic_vector(127 downto 0);
        output : out matrix
        --output : out std_logic_vector(127 downto 0)
); end component;

signal plain : std_logic_vector(127 downto 0) := x"090862BF6F28E3042C747FEEDA4A6A47";
signal output : matrix;


begin 
    uut : ShifRows port map(plain => plain, output => output);
    clock_process : process
    begin
        wait for 10 ns;

    end process;
end ben; 