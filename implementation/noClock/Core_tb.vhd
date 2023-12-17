library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;


entity Core_tb is 
end Core_tb;

architecture ben of Core_tb is

component Core is port(
    Clk, EN : in std_logic;
    --Rst : in std_logic;
    input : in matrix;
    output : out matrix
); end component;

signal Clk, EN : std_logic := '0';
-- signal Rst : std_logic := '0';
signal input : matrix;
signal output : matrix;

signal plaintext: std_logic_vector(0 to 127);
signal resultExa : std_logic_vector(0 to 127);
signal result : matrix;

begin
    cor : Core port map(Clk => Clk, EN => EN, input => input, output => output);

    clock_process : process
    begin
        wait for 10 ns;
        plaintext <= x"40BFABF406EE4D3042CA6B997A5C5816";
        resultExa <= x"BB36C7EB88334D49A4E7112E74F182C4";
        
        for i in 0 to 3 loop
            for j in 0 to 3 loop
                for l in 0 to 7 loop
                input(i)(j)(l) <= plaintext(j*32+i*8+l);
                result(i)(j)(l) <= resultExa(j*32+i*8+l);
                end loop;
            end loop;
        end loop;

        Clk <= not Clk;
        wait for 10 ns;
    end process;

    EN_process : process
    begin
        EN <= not EN;
        wait for 10 ns;
    end process;

    --Rst_process : process
    --begin
     --   Rst <= '0';
       -- wait for 1 ns;
    --end process;
end ben;