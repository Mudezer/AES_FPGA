library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity Core is port(
    Clk, EN: in std_logic;
    --Rst : in std_logic;
    input : in matrix;
    output : out matrix
); end Core;

architecture arch of Core is

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

type statetype is (c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12
    ,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24,c25,c26,c27,c28
    ,c29,c30,c31,c32,c33,c34,c35,c36);
signal currentState, nextState : statetype;

signal inputAdd, inputSub, inputShift, inputMix : matrix;
signal outputAdd, outputSub, outputShift, outputMix : matrix;
signal inputKey : std_logic_vector(0 to 127);

signal key : std_logic_vector(0 to 127);

begin
    sub : SubBytes port map(inputSub, outputSub);
    shitf : ShiftRows port map(inputShift, outputShift);
    mix : MixColumns port map(inputMix, outputMix);
    add : AddRoundKey port map(inputAdd, inputKey, outputAdd);

    fsm1 : process(EN, currentState)
    begin
        case currentState is
            when c0 => inputSub <= input;
            if EN = '1' then
                nextState <= c1;
            else
                nextState <= c0;
            end if;
            when c1 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c2;
            else
                nextState <= c1;
            end if;
            when c2 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c3;
            else
                nextState <= c2;
            end if;
            when c3 => inputKey <= x"a0fafe1788542cb123a339392a6c7605"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c4;
            else
                nextState <= c3;
            end if;
            when c4 => inputSub <= outputAdd; -- AddRoundKey => SubBytes (1st round)
            if EN = '1' then
                nextState <= c5;
            else
                nextState <= c4;
            end if;
            when c5 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c6;
            else
                nextState <= c5;
            end if;
            when c6 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c7;
            else
                nextState <= c6;
            end if;
            when c7 => inputKey <= x"f2c295f27a96b9435935807a7359f67f"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c8;
            else
                nextState <= c7;
            end if;
            when c8 => inputSub <= outputAdd; -- AddRoundKey => SubBytes (2nd round)
            if EN = '1' then
                nextState <= c9;
            else
                nextState <= c8;
            end if;
            when c9 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c10;
            else
                nextState <= c9;
            end if;
            when c10 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c11;
            else
                nextState <= c10;
            end if;
            when c11 => inputKey <= x"3d80477d4716fe3e1e237e446d7a883b"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c12;
            else
                nextState <= c11;
            end if;
            when c12 => inputSub <= outputAdd; -- AddRoundKey => SubBytes (3rd round)
            if EN = '1' then
                nextState <= c13;
            else
                nextState <= c12;
            end if;
            when c13 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c14;
            else
                nextState <= c13;
            end if;
            when c14 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c15;
            else
                nextState <= c14;
            end if;
            when c15 => inputKey <= x"ef44a541a8525b7fb671253bdb0bad00"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c16;
            else
                nextState <= c15;
            end if;
            when c16 => inputSub <= outputAdd; -- AddRoundKey => SubBytes (4th round)
            if EN = '1' then
                nextState <= c17;
            else
                nextState <= c16;
            end if;
            when c17 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c18;
            else
                nextState <= c17;
            end if;
            when c18 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c19;
            else
                nextState <= c18;
            end if;
            when c19 => inputKey <= x"d4d1c6f87c839d87caf2b8bc11f915bc"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c20;
            else
                nextState <= c19;
            end if;
            when c20 => inputSub <= outputAdd; -- AddRoundKey => SubBytes (5th round)
            if EN = '1' then
                nextState <= c21;
            else
                nextState <= c20;
            end if;
            when c21 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c22;
            else
                nextState <= c21;
            end if;
            when c22 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c23;
            else
                nextState <= c22;
            end if;
            when c23 => inputKey <= x"6d88a37a110b3efddbf98641ca0093fd"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c24;
            else
                nextState <= c23;
            end if;
            when c24 => inputSub <= outputAdd; -- AddRoundKey => SubBytes (6th round)
            if EN = '1' then
                nextState <= c25;
            else
                nextState <= c24;
            end if;
            when c25 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c26;
            else
                nextState <= c25;
            end if;
            when c26 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c27;
            else
                nextState <= c26;
            end if;
            when c27 => inputKey <= x"4e54f70e5f5fc9f384a64fb24ea6dc4f"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c28;
            else
                nextState <= c27;
            end if;
            when c28 => inputSub <= outputAdd; -- AddRoundKey => SubBytes (7th round)
            if EN = '1' then
                nextState <= c29;
            else
                nextState <= c28;
            end if;
            when c29 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c30;
            else
                nextState <= c29;
            end if;
            when c30 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c31;
            else
                nextState <= c30;
            end if;
            when c31 => inputKey <= x"ead27321b58dbad2312bf5607f8d292f"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c32;
            else
                nextState <= c31;
            end if;
            when c32 => inputSub <= outputAdd; -- AddRoundKey => SubBytes (8th round)
            if EN = '1' then
                nextState <= c33;
            else
                nextState <= c32;
            end if;
            when c33 => inputShift <= outputSub;
            if EN = '1' then
                nextState <= c34;
            else
                nextState <= c33;
            end if;
            when c34 => inputMix <= outputShift;
            if EN = '1' then
                nextState <= c35;
            else
                nextState <= c34;
            end if;
            when c35 => inputKey <= x"ac7766f319fadc2128d12941575c006e"; inputAdd <= outputMix;
            if EN = '1' then
                nextState <= c36;
            else
                nextState <= c35;
            end if;
            when c36 => output <= outputAdd; -- AddRoundKey => output (9th round)
            if EN = '1' then
                nextState <= c0;
            else
                nextState <= c36;
            end if;
        end case;
    end process fsm1;

    fsm2 : process(Clk)
    begin
        if (Clk'event) and (Clk = '1') then
            --if Rst = '1' then
              --  currentState <= c0;
            --else
                currentState <= nextState;
           -- end if;
        end if;
    end process fsm2;
end arch;