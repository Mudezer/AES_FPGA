library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity StateMachine_tb is
end StateMachine_tb;

architecture StateMachine_tbArch of StateMachine_tb is

component StateMachine is port(
    Clk,EN,RST: in std_logic;
    plain : in matrix;
    output : out matrix
); end component;

signal Clk,RST,EN : std_logic := '0';
signal plain : matrix;
signal output : matrix;

signal plaintext : std_logic_vector(0 to 127);
signal result : matrix;
signal resultExa : std_logic_vector(0 to 127);

begin 
    uut : StateMachine port map(Clk => Clk,RST => RST, EN => EN, plain => plain, output => output);
    clock_process :process
    begin
        wait for 10 ns;

        plaintext <= x"40BFABF406EE4D3042CA6B997A5C5816";
        resultExa <= x"BB36C7EB88334D49A4E7112E74F182C4";

        for i in 0 to 3 loop
            for j in 0 to 3 loop
                for l in 0 to 7 loop
                    plain(i)(j)(l) <= plaintext(j*32+i*8+l);
                    result(i)(j)(l) <= resultExa(j*32+i*8+l);
                end loop;
            end loop;
        end loop;
        wait for 10 ns;
        Clk <= not Clk;
    end process clock_process;

    EN_process :process
    begin
        wait for 10ns;
        EN <= '1';
        -- wait for 100 ns;
    end process EN_process;

    RST_process :process
    begin
        wait for 10 ns;
        -- RST <= '1';
        -- wait for 100 ns;
        RST <= '0';
        -- wait for 100 ns;
    end process RST_process;
end StateMachine_tbArch;
    