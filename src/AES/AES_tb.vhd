library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.matpack.all;

entity AES_tb is
end AES_tb;

architecture ben of AES_tb is 

component AES is port(
    Clk, EN : in std_logic;
    input : in std_logic_vector(0 to 127);
    output : out std_logic_vector(0 to 127)
    -- output : out matrix
); end component;

signal Clk, EN : std_logic := '0';

signal input : std_logic_vector(0 to 127);
signal output : std_logic_vector(0 to 127);
-- signal output : matrix;

signal resultExa : std_logic_vector(0 to 127);
-- signal result : matrix;

begin
    kek : AES port map(Clk => Clk, EN => EN, input => input, output => output);

    clock_process : process
    begin
        wait for 10 ns;
        input <= x"6BC1BEE22E409F96E93D7E117393172A";
        -- resultExa <= x"40BFABF406EE4D3042CA6B997A5C5816"; -- 1st addroundkey
        -- resultExa <= x"F265E8D51FD2397BC3B9976D9076505C"; -- 1st round
        -- resultExa <= x"FDF37CDB4B0C8C1BF7FCD8E94AA9BBF8"; -- 2nd round
        -- resultExa <= x"ACD1EC9CA242E2C31F690F7AB704B90F"; -- 3rd round
        -- resultExa <= x"A2616E5F44A54D39C029E20092B764E9"; -- 4th round
        -- resultExa <= x"2C4AF31432C3EFC9C8A9B87B252ECDA7"; -- 5th round
        -- resultExa <= x"CD4DC0137EB3BA1993B939FF2BD3BCF7"; -- 6th round
        -- resultExa <= x"E26DBB7D40D22134E3B7FDA26B9B077C"; -- 7th round
        -- resultExa <= x"41D7C6537D669140DD2F179D02ACC51B"; -- 8th round
        -- resultExa <= x"BB36C7EB88334D49A4E7112E74F182C4"; -- 9th round
        resultExa <= x"3AD77BB40D7A3660A89ECAF32466EF97";

            -- for i in 0 to 3 loop
            --     for j in 0 to 3 loop
            --         for l in 0 to 7 loop
            --         result(i)(j)(l) <= resultExa(j*32+i*8+l);
            --         end loop;
            --     end loop;
            -- end loop;

        Clk <= not Clk;
        wait for 10 ns;
    end process;

    EN_process : process
    begin
        EN <= not EN;
        wait for 10 ns;
    end process;

    --Rst_process : process
    --begin
     --   Rst <= '0';
       -- wait for 1 ns;
    --end process;
end ben;