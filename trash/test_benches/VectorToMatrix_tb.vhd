library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity VectorToMatrix_tb is 
end VectorToMatrix_tb;

architecture VectorToMatrix_tbArch of VectorToMatrix_tb is

component VectorToMatrix is port(
    Clk : in std_logic;
    plain : in std_logic_vector(0 to 127);
    output : out matrix
); end component;


signal Clk : std_logic := '0';
signal plain : std_logic_vector(0 to 127);
signal output : matrix;

signal resultExa : std_logic_vector(0 to 127);
signal result : matrix;

begin
    uut: VectorToMatrix port map(Clk => Clk, plain => plain, output => output);

    clock_process :process
    begin
        wait for 10 ns;
        plain <= x"09287F476F746ABF2C4A6204DA08E3EE"; -- on donne le vecteur en entrée
        resultExa <= x"09287F476F746ABF2C4A6204DA08E3EE"; -- on donne le vecteur en entrée
        for i in 0 to 3 loop
            for j in 0 to 3 loop
                for l in 0 to 7 loop
                    result(i)(j)(l) <= resultExa(j*32+i*8+l);
                end loop;
            end loop;
        end loop;
        wait for 10 ns;
        Clk <= not Clk;
    end process clock_process;
end VectorToMatrix_tbArch;