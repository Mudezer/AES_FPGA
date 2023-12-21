library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity AESBoard is port(
    -- inputs
    clk : in std_logic;
    btnR : in std_logic;
    btnC : in std_logic;

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
); end AESBoard;


architecture arch of AESBoard is 

component AddRoundKey is port(
    input : in matrix;
    key : in std_logic_vector(0 to 127);
    output : out matrix
); end component;

component SubBytes is port(
    input : in matrix;
    output : out matrix
); end component;

component ShiftRows is port(
    input : in matrix;
    output : out matrix
); end component;

component MixColumns is port(
    input : in matrix;
    output : out matrix
); end component;

component VectorToMatrix is port(
    input : in std_logic_vector(0 to 127);
    output : out matrix
); end component;

component MatrixToVector is port(
    input : in matrix;
    output : out std_logic_vector(0 to 127)
); end component;

component SegmentMaster is port(
    CLK_100MHZ : in std_logic;
    SEG_OUT : out std_logic_vector(6 downto 0);
    ANODE_ACT : out std_logic_vector(3 downto 0)
); end component;


type statetype is ( isInit, isAcquiring,isEncrypted, isDisplaying, -- board states
                    c0, -- vector to matrix
                    c1,c2, --1st AddRoundKey
                    c3,c4,c5,c6, -- 1st round
                    c7,c8,c9,c10, -- 2nd round 
                    c11,c12,c13,c14, -- 3rd round
                    c15,c16,c17,c18, -- 4th round
                    c19,c20,c21,c22, -- 5th round
                    c23,c24,c25,c26, -- 6th round
                    c27,c28,c29,c30, -- 7th round
                    c31,c32,c33,c34, -- 8th round
                    c35,c36,c37,c38, -- 9th round
                    c39,c40,c41); -- last AddRoundKey

signal currentState, nextState : statetype;

signal inputAdd, inputSub, inputShift, inputMix, inputMTV : matrix;
signal outputAdd, outputSub, outputShift, outputMix, outputVTM : matrix;

signal inputKey : std_logic_vector(0 to 127);
signal inputVTM : std_logic_vector(0 to 127);
signal outputMTV : std_logic_vector(0 to 127);
signal testOutput : std_logic_vector(0 to 127);
signal testVector : std_logic_vector(0 to 127);
signal result: boolean;

signal start : std_logic := '0';
signal Reset : std_logic := '0';
signal centralButton : std_logic := '0';
signal display : std_logic := '0';
signal EN : std_logic := '1';
signal displays: std_logic := '0';

signal segment_out : std_logic_vector(6 downto 0);
signal anode_active : std_logic_vector(3 downto 0);

begin
    vtm : VectorToMatrix port map(input => inputVTM, output => outputVTM);
    mtv : MatrixToVector port map(input => inputMTV, output => outputMTV);
    sub : SubBytes port map(input => inputSub, output => outputSub);
    shift : ShiftRows port map(input => inputShift, output => outputShift);
    mix : MixColumns port map(input => inputMix, output => outputMix);
    add : AddRoundKey port map(input => inputAdd, key => inputKey, output => outputAdd);
    segment : SegmentMaster port map(CLK_100MHZ => clk, SEG_OUT => segment_out, ANODE_ACT => anode_active);

    fsm1 : process(EN, currentState, start)
    begin
        case currentState is
            when isInit => led0 <= '1'; start <= centralButton;
            if start = '1' then
                nextState <= c0;
            else
                nextState <= isInit;
            end if;
            when c0 => start <='0'; inputVTM <= x"6BC1BEE22E409F96E93D7E117393172A";
            if EN = '1' then
                led0 <= '0';
                nextState <= c1;
            else
                nextState <= c0;
            end if;
            when c1 => inputKey <= x"2b7e151628aed2a6abf7158809cf4f3c"; inputAdd <= outputVTM;
            if EN = '1' then
                nextState <= c2;
            else
                nextState <= c1;
            end if;
            when c2 => inputSub <= outputAdd; -- AddRoundKey => SubBytes (0th round) (2)
            if EN = '1' then
                nextState <= c3;
            else
                nextState <= c2;
            end if;
            when c3 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c4;
            else
                nextState <= c3;
            end if;
            when c4 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c5;
            else
                nextState <= c4;
            end if;
            when c5 => inputKey <= x"a0fafe1788542cb123a339392a6c7605"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c6;
            else
                nextState <= c5;
            end if;
            when c6 => inputSub <= outputAdd; -- AddRoundKey => SubBytes (1st round) (6)
            if EN = '1' then
                nextState <= c7;
            else
                nextState <= c6;
            end if;
            when c7 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c8;
            else
                nextState <= c7;
            end if;
            when c8 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c9;
            else
                nextState <= c8;
            end if;
            when c9 => inputKey <= x"f2c295f27a96b9435935807a7359f67f"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c10;
            else
                nextState <= c9;
            end if;
            when c10 =>inputSub <= outputAdd; -- AddRoundKey => SubBytes (2nd round) (10)
            if EN = '1' then
                nextState <= c11;
            else
                nextState <= c10;
            end if;
            when c11 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c12;
            else
                nextState <= c11;
            end if;
            when c12 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c13;
            else
                nextState <= c12;
            end if;
            when c13 => inputKey <= x"3d80477d4716fe3e1e237e446d7a883b"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c14;
            else
                nextState <= c13;
            end if;
            when c14 => inputSub <= outputAdd; -- AddRoundKey => SubBytes (3rd round) (14)
            if EN = '1' then
                nextState <= c15;
            else
                nextState <= c14;
            end if;
            when c15 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c16;
            else
                nextState <= c15;
            end if;
            when c16 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c17;
            else
                nextState <= c16;
            end if;
            when c17 => inputKey <= x"ef44a541a8525b7fb671253bdb0bad00"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c18;
            else
                nextState <= c17;
            end if;
            when c18 => inputSub <= outputAdd; -- AddRoundKey => SubBytes (4th round) (18)
            if EN = '1' then
                nextState <= c19;
            else
                nextState <= c18;
            end if;
            when c19 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c20;
            else
                nextState <= c19;
            end if;
            when c20 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c21;
            else
                nextState <= c20;
            end if;
            when c21 => inputKey <= x"d4d1c6f87c839d87caf2b8bc11f915bc"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c22;
            else
                nextState <= c21;
            end if;
            when c22 => inputSub <= outputAdd; -- AddRoundKey => SubBytes (5th round) (22)
            if EN = '1' then
                nextState <= c23;
            else
                nextState <= c22;
            end if;
            when c23 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c24;
            else
                nextState <= c23;
            end if;
            when c24 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c25;
            else
                nextState <= c24;
            end if;
            when c25 => inputKey <= x"6d88a37a110b3efddbf98641ca0093fd"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c26;
            else
                nextState <= c25;
            end if;
            when c26 => inputSub <= outputAdd; -- AddRoundKey => SubBytes (6th round) (26)
            if EN = '1' then
                nextState <= c27;
            else
                nextState <= c26;
            end if;
            when c27 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c28;
            else
                nextState <= c27;
            end if;
            when c28 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c29;
            else
                nextState <= c28;
            end if;
            when c29 => inputKey <= x"4e54f70e5f5fc9f384a64fb24ea6dc4f"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c30;
            else
                nextState <= c29;
            end if;
            when c30 => inputSub <= outputAdd; -- AddRoundKey => SubBytes (7th round) (30)
            if EN = '1' then
                nextState <= c31;
            else
                nextState <= c30;
            end if;
            when c31 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c32;
            else
                nextState <= c31;
            end if;
            when c32 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c33;
            else
                nextState <= c32;
            end if;
            when c33 => inputKey <= x"ead27321b58dbad2312bf5607f8d292f"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c34;
            else
                nextState <= c33;
            end if;
            when c34 => inputSub <= outputAdd; -- AddRoundKey => SubBytes (8th round) (34)
            if EN = '1' then
                nextState <= c35;
            else
                nextState <= c34;
            end if;
            when c35 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c36;
            else
                nextState <= c35;
            end if;
            when c36 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c37;
            else
                nextState <= c36;
            end if;
            when c37 => inputKey <= x"ac7766f319fadc2128d12941575c006e"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c38;
            else
                nextState <= c37;
            end if;
            when c38 => inputSub <= outputAdd; -- AddRoundKey => SubBytes (9th round) (38)
            if EN = '1' then
                nextState <= c39;
            else
                nextState <= c38;
            end if;
            when c39 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c40;
            else
                nextState <= c39;
            end if;
            when c40 => inputKey <= x"d014f9a8c9ee2589e13f0cc8b6630ca6" ; inputAdd <= outputShift; 
            if EN = '1' then
                nextState <= c41;
            else
                nextState <= c40;
            end if;
            when c41 => inputMTV <= outputAdd; -- AddRoundKey => output (10th round) (42)
            if EN = '1' then
                nextState <= isAcquiring;
            else
                nextState <= c41;
            end if;
            When isAcquiring => testOutput <= outputMTV;
                                 testVector <= x"3AD77BB40D7A3660A89ECAF32466EF97";
            if EN = '1' then
                nextState <= isEncrypted;
            else
                nextState <= isAcquiring;
            end if;
            when isEncrypted => result <= testOutput = testVector; -- is encrypted?
            if result  then
                nextState <= isDisplaying;
            else
                led3 <= '1';
                nextState <= isEncrypted;
            end if;
            when isDisplaying => led3 <= '0'; start <= '0';
            if EN = '1' then
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
                nextState <= isDisplaying;
            else
                nextState <= isInit;
            end if;
        end case;
    end process fsm1;

    fsm2 : process(clk) is begin
        if rising_edge(clk) then
            centralButton <= btnC;
            Reset <= btnR;
        end if;
        
        if (clk'event) and (clk = '1') then
            if Reset = '1' then
                    Reset <= '0';
                    currentState <= c0;
            else
                currentState <= nextState;
            end if;
        end if;
    end process fsm2;
end arch;