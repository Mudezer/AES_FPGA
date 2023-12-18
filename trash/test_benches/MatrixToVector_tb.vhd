library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity MatrixToVector_tb is 
end MatrixToVector_tb;

architecture MatrixToVector_tbArch of MatrixToVector_tb is

component MatrixToVector is port(
    Clk: in std_logic;
    input : in matrix;
    cipher : out std_logic_vector(0 to 127)
); end component;

signal Clk : std_logic := '0';
signal input : matrix;
signal cipher : std_logic_vector(0 to 127);

signal plain : std_logic_vector(0 to 127);
signal result : std_logic_vector(0 to 127);

begin
    uut : MatrixToVector port map(Clk => Clk, input => input, cipher => cipher);

    clock_process : process
    begin
        wait for 10 ns;
        plain <= x"09287F476F746ABF2C4A6204DA08E3EE";
        result <= x"09287F476F746ABF2C4A6204DA08E3EE";
        for i in 0 to 3 loop
            for j in 0 to 3 loop
                for l in 0 to 7 loop
                    input(i)(j)(l) <= plain(j*32+i*8+l);
                end loop;
            end loop;
        end loop;
        wait for 10 ns;
        Clk <= not Clk;
    end process clock_process;
end MatrixToVector_tbArch;