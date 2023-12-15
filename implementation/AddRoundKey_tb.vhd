library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;


entity AddRoundKey_tb is
end entity;

architecture ben of AddRoundKey_tb is
component AddRoundKey is port (
    Clk : in std_logic;
    plain : in std_logic_vector(127 downto 0);
    key : in std_logic_vector(127 downto 0);
    output : out std_logic_vector(127 downto 0)
); end component;

signal Clk : std_logic := '0';
signal plain : std_logic_vector(127 downto 0) := x"6BC1BEE22E409F96E93D7E117393172A";
signal key : std_logic_vector(127 downto 0) := x"2b7e151628aed2a6abf7158809cf4f3c";
signal output : std_logic_vector(127 downto 0);
signal resultExa : std_logic_vector(127 downto 0) := x"40BFABF406EE4D3042CA6B997A5C5816";


begin
    uut : AddRoundKey port map( Clk => Clk, plain => plain, key => key, output => output);
    clock_process : process
    begin
        wait for 10ns;
        Clk <= not Clk;
    end process;
end ben;
