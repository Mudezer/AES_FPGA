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

type statetype is (c0, c1, c2, c3, c4, c5,c6,c7,c8);
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
            when c8 => output <= outputAdd; -- AddRoundKey => SubBytes (2nd round)
            if EN = '1' then
                nextState <= c0;
            else
                nextState <= c8;
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