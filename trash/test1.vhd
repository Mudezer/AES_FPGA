library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Board is port(
    clk : in std_logic;
    btnC : in std_logic;
    btnR : in std_logic;
    led0 : out std_logic;
    led1: out std_logic
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
); end Board;

architecture behavioral of Board is

component SegmentMaster is port(
    clake : in std_logic;
    SEG_OUT : out std_logic_vector(6 downto 0);
    AN : out std_logic_vector(3 downto 0)
);

type statetype is (asInit, asEncrypt, asEncrypted, asDisplaying);
signal currentState, nextState : statetype;

signal input : std_logic_vector(0 to 3);
signal output : std_logic_vector(0 to 3);

signal start : std_logic:='0';
signal encrypting : std_logic:='0';
signal displayed : std_logic:='0';

signal Reset : std_logic:='0';
signal boutonCentral : std_logic:='0';

begin

    fsm1 : process(currentState, start, encrypting, input, output, displayed)
    begin
        case currentState is
            when asInit =>displayed <= '0'; start <= boutonCentral;
            if start = '1' then
                -- led1 <= '1';
                led0 <='0';
                nextState <= asEncrypt;
            else
                nextState <= asInit;
            end if;
            when asEncrypt => displayed <= '0'; encrypting <= '1'; start <= '0';  input <= "0000";
            if encrypting = '1' then
                --Reset <= '0';
                led1 <= '1';
                led0 <= '0';
                nextState <= asEncrypted;
            else
                nextState <= asEncrypt;
            end if;
            when asEncrypted => encrypting <= '0';output <= "0000";
            if input = output then
                led1 <= '0';
                led0 <= '0';
                nextState <= asDisplaying;
            else
                nextState <= asEncrypted;
            end if;
            when asDisplaying => displayed <= '1';
            if displayed = '1' then

                nextState <= asInit;
            else
                nextState <= asDisplaying;
            end if;
        end case;
    end process fsm1;

    fsm2 : process(clk) is begin
        if rising_edge(clk) then
            boutonCentral <= btnC;
            Reset <= btnR;
        end if;
        if (clk'event) and (clk = '1') then
            if Reset = '1' then
                Reset <= '0';
                currentState <= asEncrypt;
            else
                currentState <= nextState;
            end if;
        end if;
    end process fsm2;

end behavioral;
