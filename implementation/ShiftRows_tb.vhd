library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity ShifRows_tb is 
end entity;

architecture ben of ShifRows_tb is
    component ShifRows is port(
        Clk : in std_logic;
        plain : in std_logic_vector(127 downto 0);
        output : out std_logic_vector(127 downto 0)
); end component;

signal Clk : std_logic := '0';
signal plain : std_logic_vector(127 downto 0) := x"6BC1BEE22E409F96E93D7E117393172A";
signal output : std_logic_vector(127 downto 0);


begin 
    uut : ShifRows port map(Clk => Clk, plain => plain, output => output);
    clock_process : process
    begin
        wait for 10 ns;
        Clk <= not Clk;
        assert ((output = x"6BC1BEE22E409F96E93D7E117393172A" and Clk = '1')) 
        report "fusion failed" severity error;

    end process;
end ben; 