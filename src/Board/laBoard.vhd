library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity leBoard is port(
    Clk : in std_logic;
    Reset : in std_logic;
    btnR : in std_logic;
    btnC : in std_logic;
    SEG_OUT : out std_logic_vector(7 downto 0);
    an0
    an1
    an2
    an3
); end leBoard;

architecture arch of leBoard is 

