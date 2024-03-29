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
    Rst : in std_logic;
    input : in std_logic_vector(0 to 127);
    output : out std_logic_vector(0 to 127);
    -- debug
    testVector : out std_logic_vector(0 to 127);
    result : out boolean
); end component;

signal Clk, EN : std_logic := '0';
signal Rst : std_logic := '0';

signal input : std_logic_vector(0 to 127);
signal output : std_logic_vector(0 to 127);
-- signal output : matrix;

signal testVector : std_logic_vector(0 to 127);
signal result : boolean;

signal resultExa : std_logic_vector(0 to 127);
-- signal result : matrix;

signal expected : boolean;

begin
    uut : AES port map(Clk => Clk, Rst => Rst, EN => EN,
                         input => input, output => output,
                         testVector => testVector, result => result);

    clock_process : process
    begin
        wait for 10 ns;
        input <= x"6BC1BEE22E409F96E93D7E117393172A"; -- 1st plaintext
        -- input <= x"AE2D8A571E03AC9C9EB76FAC45AF8E51"; -- 2nd plaintext
        -- input <= x"30C81C46A35CE411E5FBC1191A0A52EF"; -- 3rd plaintext
        --input <= x"F69F2445DF4F9B17AD2B417BE66C3710"; -- 4th plaintext

        -- Following lines are for debug purposes
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

        resultExa <= x"3AD77BB40D7A3660A89ECAF32466EF97"; -- 1st ciphertext
        -- resultExa <= x"F5D3D58503B9699DE785895A96FDBAAF"; -- 2nd ciphertext
        -- resultExa <= x"43B1CD7F598ECE23881B00E3ED030688"; -- 3rd ciphertext
        --resultExa <= x"7B0C785E27E8AD3F8223207104725DD4"; -- 4th ciphertext


            -- for i in 0 to 3 loop
            --     for j in 0 to 3 loop
            --         for l in 0 to 7 loop
            --         result(i)(j)(l) <= resultExa(j*32+i*8+l);
            --         end loop;
            --     end loop;
            -- end loop;

        Clk <= not Clk;
        wait for 10 ns;
        
        expected <= resultExa = output;

        wait for 30 ns;
    end process;

    EN_process : process
    begin
        EN <= not EN;
        wait for 10 ns;
    end process;

    Rst_process : process
    begin
       Rst <= not Rst;
       wait for 1 ns;
       Rst <= not Rst;
       wait for 130 ns;
    end process;
end ben;