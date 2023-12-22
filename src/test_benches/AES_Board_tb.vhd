library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity AESBoard_tb is
end AESBoard_tb;

architecture ben of AESBoard_tb is

component AESBoard is port(
    -- inputs
    clk : in std_logic;
    btnR : in std_logic;
    btnC : in std_logic;

    -- Segment Display
    led0 : out std_logic;
    led3 : out std_logic;
    seg : out std_logic_vector(0 to 6);
    an : out std_logic_vector(0 to 3)

); end component;

signal clk : std_logic := '0';
signal btnR : std_logic := '0';
signal btnC : std_logic := '0';


signal led0 : std_logic;
signal led3 : std_logic;
signal seg : std_logic_vector(0 to 6);
signal an : std_logic_vector(0 to 3);



begin
    board: AESBoard port map(
        clk => clk,
        btnR => btnR,
        btnC => btnC,
        led0 => led0,
        led3 => led3,
        seg => seg,
        an => an
    );

    clock_process: process
    begin
        wait for 10 ns;

        clk <= not clk;

        wait for 10 ns;

    end process;

    btnR_process: process
    begin
        wait for 10 ns;
        btnR <= not btnR;
        wait for 1 ns;
        btnR <= not btnR;
        wait for 130 ns;
    end process;

    btnC_process: process
    begin
        wait for 10 ns;
        btnC <= not btnC;
        wait for 130 ns;
    end process;
end ben;

