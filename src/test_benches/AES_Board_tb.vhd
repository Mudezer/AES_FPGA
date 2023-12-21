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
    sauvezMoi : out std_logic_vector(0 to 127);

    -- Segment Display
    led0 : out std_logic;
    led3 : out std_logic;
    seg0 : out std_logic;
    seg1 : out std_logic;
    seg2 : out std_logic; 
    seg3 : out std_logic;
    seg4 : out std_logic;
    seg5 : out std_logic;
    seg6 : out std_logic;
    an0 : out std_logic;
    an1 : out std_logic;
    an2 : out std_logic;
    an3 : out std_logic
); end component;

signal clk : std_logic := '0';
signal btnR : std_logic := '0';
signal btnC : std_logic := '0';

signal sauvezMoi : std_logic_vector(0 to 127);

signal led0 : std_logic;
signal led3 : std_logic;
signal seg0 : std_logic;
signal seg1 : std_logic;
signal seg2 : std_logic;
signal seg3 : std_logic;
signal seg4 : std_logic;
signal seg5 : std_logic;
signal seg6 : std_logic;
signal an0 : std_logic;
signal an1 : std_logic;
signal an2 : std_logic;
signal an3 : std_logic;

signal resultExa : std_logic_vector(0 to 127);

signal expected : boolean;


begin
    board: AESBoard port map(
        clk => clk,
        btnR => btnR,
        btnC => btnC,
        sauvezMoi => sauvezMoi,
        led0 => led0,
        led3 => led3,
        seg0 => seg0,
        seg1 => seg1,
        seg2 => seg2,
        seg3 => seg3,
        seg4 => seg4,
        seg5 => seg5,
        seg6 => seg6,
        an0 => an0,
        an1 => an1,
        an2 => an2,
        an3 => an3
    );

    clock_process: process
    begin
        wait for 10 ns;

        resultExa <= x"3AD77BB40D7A3660A89ECAF32466EF97";

        clk <= not clk;

        wait for 10 ns;

        expected <= resultExa = sauvezMoi;

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

