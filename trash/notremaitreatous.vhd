library ieee;
use ieee.std_logic_1164.all;

entity notremaitreatous is port(
    -- input
    clk : in std_logic;
    btnC : in std_logic;
    -- output
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

); end notremaitreatous;

architecture arch of notremaitreatous is

component SegmentMaster is port(
    CLK_100MHZ : in std_logic;
    SEG_OUT : out std_logic_vector(6 downto 0);
    ANODE_ACT : out std_logic_vector(3 downto 0)
); end component;

signal segment_out : std_logic_vector(6 downto 0);
signal anode_active : std_logic_vector(3 downto 0);


begin
    segment : SegmentMaster port map( Clk_100MHz => clk, SEG_OUT => segment_out, ANODE_ACT => anode_active);

    process(clk) is begin
        if rising_edge(clk) then
            if btnC  = '1' then
                seg0 <= segment_out(0);
                seg1 <= segment_out(1);
                seg2 <= segment_out(2);
                seg3 <= segment_out(3);
                seg4 <= segment_out(4);
                seg5 <= segment_out(5);
                seg6 <= segment_out(6);
                an0 <= anode_active(0);
                an1 <= anode_active(1);
                an2 <= anode_active(2);
                an3 <= anode_active(3);
            end if;
        end if;
    end process;
end arch;

