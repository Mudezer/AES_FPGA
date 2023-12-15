library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library xil_defaultlib; 
use xil_defaultlib.matpack.all;


entity SubBytes is port(
    Clk : in std_logic;
    input : in matrix;
    output : out matrix
); end SubBytes;

architecture arch of SubBytes is 
component S_box is port(
    byte_in : in std_logic_vector(7 downto 0);
    byte_out : out std_logic_vector(7 downto 0)
); end component;

signal temp1 : std_logic_vector(7 downto 0);
signal temp2 : std_logic_vector(7 downto  0);

begin
    -- TODO: vérifier comment écrire le début de l'entité
uut : S_box port map(byte_in => temp1, byte_out => temp2);
proc : process(Clk) is begin
    if (rising_edge(Clk)) then
        -- première  soustraction
        temp1 <= input(0)(0);
        output(0)(0) <= temp2;

        temp1 <= input(0)(1);
        output(0)(1) <= temp2;

        temp1 <= input(0)(2);
        output(0)(2) <= temp2;

        temp1 <= input(0)(3);
        output(0)(3) <= temp2;

    
    end if;
end process;
end arch;


