library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;


entity AddRoundKey_tb is
end entity;

architecture ben of AddRoundKey_tb is
component AddRoundKey is port (
    clk : in std_logic;
    plain : in std_logic_vector(128 downto 0);
    key : in std_logic_vector(128 downto 0);
    output : out std_logic_vector(128 downto 0)
); end component;

signal clk : std_logic := '0';
signal plain : std_logic_vector(128 downto 0) := x"6BC1BEE22E409F96E93D7E117393172A";
signal key : std_logic_vector(128 downto 0) := x"2b7e151628aed2a6abf7158809cf4f3c";
signal output : std_logic_vector(128 downto 0);

begin
    uut : AddRoundKey port map( clk => clk, plain => plain, key => key, output => output);
    clock_process : process
    begin
        Clk <- not clk after 10 ns;
        assert((output = x"2B7E151628AED2A6ABF7158809CF4F3C" and Clk = '1')) report "Test Failed" severity error;
        -- report "Plain: " & to_string(plain);
        -- report "Key: " & to_string(key);
        -- report "Output: " & to_string(output);
    end process;
end ben;
