library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity VectorComparison is port(
    clk: in std_logic;
    btnC : in std_logic;

    led0 : out std_logic;
    led1 : out std_logic;
    led2 : out std_logic;
); end VectorComparison;


architecture arch of VectorComparison is

signal input : std_logic_vector(0 to 127);
signal output : std_logic_vector(0 to 127);

signal EN : std_logic := '1';
signal centralButton : std_logic := '0';
-- signal leftButton : std_logic := '0';

signal start : std_logic := '0';

signal result : boolean ; 

type statetype is (init, assign , compute, compare , display);
signal state currentState, nextState : statetype;


begin
    fsm1 : process(EN, currentState, start)
    begin
        case currentState is
            when init => led0 <= '1'; start <= centralButton;
            if start = '1' then
                led0 <= '0';
                nextState <= assign;
            else
                nextState <= init;
            end if;
            when assign => input <= x"3AD77BB40D7A3660A89ECAF32466EF97";
                            output <= x"3AD77BB40D7A3660A89ECAF32466EF97";
            if EN = '1' then
                nextState <= compute;
            else
                nextState <= assign;
            end if;
            when compute => result <= input = output;
            if result then 
                nextState <= display;
            else
                led1 <= '1';
                nextState <= compute;
            end if;
            when display => led2 <= '1';
            if EN = '1' then
                nextState <= display;
            else
                nextState <= init;
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
                currentState <= init;
            else
                currentState <= nextState;
            end if;
        end if;
    end process fsm2;
end arch;