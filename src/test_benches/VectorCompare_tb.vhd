library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;


entity VectorCompare_tb is
end VectorCompare_tb;

architecture ben of VectorCompare_tb is

component VectorCompare is port(
    input : in std_logic_vector(0 to 127);
    expected : in std_logic_vector(0 to 127);
    output : out boolean
); end component;

signal input : std_logic_vector(0 to 127);
signal expected : std_logic_vector(0 to 127);
signal output : boolean;

begin
    comp : VectorCompare port map(input, expected, output);

    stim: process
    begin
        wait for 10 ns; 
        input <= x"3AD77BB40D7A3660A89ECAF32466EF97";
        expected <= x"3AD77BB40D7A3660A89ECAF32466EF97";

        wait for 20 ns ;

        --input <= x"6BC1BEE22E409F96E93D7E117393172A";
        --expected <= x"3AD77BB40D7A3660A89ECAF32466EF97";

        wait for 30 ns;
    end process;
end ben;
