library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SegmentMaster is port(
    Clk_100MHz : in std_logic;
    SEG_OUT : out std_logic_vector(6 downto 0);
    ANODE_ACT : out std_logic_vector(3 downto 0)
); end SegmentMaster;

architecture arch of SegmentMaster is

component Anode is port(
    Clakos : in std_logic;
    ANODE_ACT : out std_logic_vector(3 downto 0);
    SEG_BCD : out std_logic_vector(1 downto 0)
); end component;

component Decoder is port(
    SEG_BCD : in std_logic_vector(1 downto 0);
    SEG_OUT : out std_logic_vector(6 downto 0)
); end component;

signal BCD_CODE : std_logic_vector(1 downto 0);

begin
    uu1 : Anode port map(Clakos => Clk_100MHz, ANODE_ACT => ANODE_ACT, SEG_BCD => BCD_CODE);
    uu2 : Decoder port map(SEG_BCD => BCD_CODE, SEG_OUT => SEG_OUT);
end arch;


