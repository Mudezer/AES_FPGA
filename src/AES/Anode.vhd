library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity Anode is port(
    Clakos : in std_logic;
    ANODE_ACT : out std_logic_vector(3 downto 0);
    SEG_BCD : out std_logic_vector(1 downto 0)
); end Anode;

architecture arch of Anode is 

signal refresh_counter : std_logic_vector(19 downto 0);
signal SEG_active_Count : std_logic_vector(1 downto 0);

begin
    process(Clakos)
    begin
        if (rising_edge(Clakos)) then
            refresh_counter <= refresh_counter + 1;
        end if;
        end process;
        SEG_active_Count <= refresh_counter(19 downto 18);

        process(SEG_active_Count)
        begin
            case SEG_active_Count is
                when "00" => ANODE_ACT <= "0111"; SEG_BCD <= "00";
                when "01" => ANODE_ACT <= "1011"; SEG_BCD <= "01";
                when "10" => ANODE_ACT <= "1101"; SEG_BCD <= "10";
                when "11" => ANODE_ACT <= "1110"; SEG_BCD <= "11";
                when others => ANODE_ACT <= "1111"; SEG_BCD <= "11";
        end case;
    end process;
end arch;