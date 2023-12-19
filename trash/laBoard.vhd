library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity leBoard is port(
    clk : in std_logic;
    btnR : in std_logic; -- reset and restarts
    btnC : in std_logic; -- start the encryption
    led0 : out std_logic;
    led1 : out std_logic;
    -- led2 : out std_logic;
    led3 : out std_logic;
    led4 : out std_logic
); end leBoard;

architecture arch of leBoard is 

component AES is port(
    Clk, EN: in std_logic;
    Rst : in std_logic;
    input : in std_logic_vector(0 to 127);
    output : out std_logic_vector(0 to 127)
); end component;





signal inputAES : std_logic_vector(0 to 127);
signal outputAES : std_logic_vector(0 to 127);
signal testingOutput : std_logic_vector(0 to 127);

signal Reset : std_logic := '0';


signal start : std_logic := '0';
signal encrypting : std_logic := '0';
signal encrypted : std_logic := '0';
signal displayed : std_logic := '0';

signal boutonCentral: std_logic := '0';

type statetype is (isInit, isEncrypting,isEncrypted, isDisplaying);
signal currentState, nextState : statetype;

begin
    encripted : AES port map(Clk => clk, EN => '1', Rst => Reset, input => inputAES, output => outputAES);

    fsm1 : process(currentState, start, encrypting, encrypted, displayed) is
    begin
        case currentState is
            when isInit => led1 <= '1' ; displayed <= '0'; start <= boutonCentral;
            if start = '1' then
                led0 <= '0';
                nextState <= isEncrypting;
            else
                nextState <= isInit;
            end if;
            when isEncrypting => led3 <= '1';start <= '0'; displayed <= '0'; encrypting <= '1'; inputAES <= x"6BC1BEE22E409F96E93D7E117393172A";
            if encrypting = '1' then
                led1 <= '0';
                led0 <= '0';
                nextState <= isEncrypted;
            else
                nextState <= isEncrypting;
            end if;
            when isEncrypted => led4 <= '1'; encrypting <= '0'; testingOutput <= outputAES;
            if testingOutput = x"3AD77BB40D7A3660A89ECAF32466EF97" then
                led3 <= '0';
                led1 <= '0';
                led0 <= '0';
                nextState <= isDisplaying;
            else
                nextState <= isEncrypted;
            end if;
            when isDisplaying => displayed <= '1';
            if displayed = '1' then
                led4 <= '0';
                led0 <= '1';
                start <= '0';
                nextState <= isInit;
            else
                nextState <= isDisplaying;
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
                currentState <= isEncrypting;
            else
                currentState <= nextState;
            end if;
        end if;
    end process fsm2;
end arch;