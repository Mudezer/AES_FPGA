library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity Decoder is port(
    SEG_BCD : in std_logic_vector(1 downto 0);
    SEG_OUT : out std_logic_vector(6 downto 0)
); end Decoder;

architecture arch of Decoder is

    begin
        process(SEG_BCD)
        begin
            case SEG_BCD is
                when "00" => SEG_OUT <= "0100000";
                when "01" => SEG_OUT <= "0000110";
                when "10" => SEG_OUT <= "0010010";
                when "11" => SEG_OUT <= "1111111";
            end case;
        end process;
end arch;