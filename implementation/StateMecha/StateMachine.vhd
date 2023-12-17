library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity StateMachine is port(
    Clk,RST,EN: in std_logic;
    plain : in matrix;
    output : out matrix
); end StateMachine;

architecture arch of StateMachine is 

-- component declaration
component MixColumns is port(
    Clk: in std_logic;
    input : in matrix;
    output : out matrix
); end component;

component ShiftRows is port(
    Clk: in std_logic;
    input : in matrix;
    output : out matrix
); end component;

component SubBytes is port(
    Clk: in std_logic;
    input : in matrix;
    output : out matrix
); end component;

component AddRoundKey is port(
    Clk: in std_logic;
    input : in matrix;
    key : in std_logic_vector(0 to 127);
    output : out matrix
); end component;

-- internal elements declaration

type statetype is (c0, c1, c2, c3, c4, c5, c6, c7, c8);
signal currentState, nextState : statetype;
signal inputKey : std_logic_vector(0 to 127); -- input key for addroundkey
signal tempOut : matrix; -- output of addroundkey
signal tempIn : matrix; -- input of subbytes

signal o1, o2, o3 : matrix;



begin
bytess : SubBytes port map(Clk => Clk, input => tempIn, output => o1);
shifts : ShiftRows port map(Clk => Clk, input => o1, output => o2);
mixes : MixColumns port map(Clk => Clk, input => o2, output => o3);
adds : AddRoundKey port map(Clk => Clk, input => o3, key => inputKey, output => tempOut);

fsm1 : process(EN,currentState)
    begin
    case currentState is
        when c0 => inputKey <= x"a0fafe1788542cb123a339392a6c7605";
        if EN = '1' then
            nextState <= c1;
            tempIn <= plain;
            tempIn <= tempOut;
        else nextState <= c0; end if;
        when c1 => inputKey <= x"f2c295f27a96b9435935807a7359f67f";
        if EN = '1' then
            nextState <= c2;
            tempIn <= tempOut;
        else nextState <= c1; end if;
        when c2 => inputKey <= x"3d80477d4716fe3e1e237e446d7a883b";
        if EN = '1' then
            nextState <= c3;
            tempIn <= tempOut;
            else nextState <= c2; end if;
        when c3 => inputKey <= x"ef44a541a8525b7fb671253bdb0bad00"; --done
        if EN = '1' then
            nextState <= c4;
            tempIn <= tempOut;    
        else nextState <= c3; end if;
        when c4 => inputKey <= x"d4d1c6f87c839d87caf2b8bc11f915bc";
        if EN = '1' then
            nextState <= c5;
            tempIn <= tempOut;    
        else nextState <= c4; end if;
        when c5 => inputKey <= x"6d88a37a110b3efddbf98641ca0093fd";
        if EN = '1' then
            nextState <= c6;
            tempIn <= tempOut;
        else nextState <= c5; end if;
        when c6 => inputKey <= x"4e54f70e5f5fc9f384a64fb24ea6dc4f"; -- done
        if EN = '1' then
            nextState <= c7;
            tempIn <= tempOut;
        else nextState <= c6; end if;
        when c7 => inputKey <= x"ead27321b58dbad2312bf5607f8d292f";
        if EN = '1' then
            nextState <= c8;
            tempIn <= tempOut;
            else nextState <= c7; end if;
        when c8 => inputKey <= x"ac7766f319fadc2128d12941575c006e"; -- 9th round done
        if EN = '1' then
            nextState <= c0;
            output <= tempOut;
        else nextState <= c8; end if;
        -- when c9 => inputKey <= x"9bcaa6f2c21c498aaa4542b5f01baf43";
        -- if EN = '1' then
        --     nextState <= c0;
        --     output <= tempOut;
        -- else nextState <= c9; end if;
    end case;
end process;
    

fsm2 : process(Clk, RST)
    begin
        if(Clk'event) and (Clk = '1') then
            if (RST = '1') then
                currentState <= c0;
            else
                currentState <= nextState;
            end if;
        end if;
end process;
end arch;

