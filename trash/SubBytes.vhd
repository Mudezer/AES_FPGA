library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library xil_defaultlib; 
use xil_defaultlib.matpack.all;


entity SubBytes is port(
    Clk : in std_logic;
    input : in matrix;
    output : out matrix
); end SubBytes;

architecture arch of SubBytes is -- architecture start

-- déclaration d'un composant
component S_box is port(
    byte_in : in std_logic_vector(0 to 7);
    byte_out : out std_logic_vector(0 to 7)
); end component;

-- déclaration de signaux temporaires
signal temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10 : std_logic_vector(0 to 7);
signal temp11,temp12,temp13,temp14,temp15,temp16,temp17,temp18,temp19 : std_logic_vector(0 to 7);
signal temp20,temp21,temp22,temp23,temp24,temp25,temp26,temp27,temp28 : std_logic_vector(0 to 7);
signal temp29,temp30,temp31,temp32 : std_logic_vector(0 to 7);

begin
uut1 : S_box port map(byte_in => temp1, byte_out => temp2);
uut2 : S_box port map(byte_in => temp3, byte_out => temp4);
uut3 : S_box port map(byte_in => temp5, byte_out => temp6);
uut4 : S_box port map(byte_in => temp7, byte_out => temp8);
uut5 : S_box port map(byte_in => temp9, byte_out => temp10);
uut6 : S_box port map(byte_in => temp11, byte_out => temp12);
uut7 : S_box port map(byte_in => temp13, byte_out => temp14);
uut8 : S_box port map(byte_in => temp15, byte_out => temp16);
uut9 : S_box port map(byte_in => temp17, byte_out => temp18);
uut10 : S_box port map(byte_in => temp19, byte_out => temp20);
uut11 : S_box port map(byte_in => temp21, byte_out => temp22);
uut12 : S_box port map(byte_in => temp23, byte_out => temp24);
uut13 : S_box port map(byte_in => temp25, byte_out => temp26);
uut14 : S_box port map(byte_in => temp27, byte_out => temp28);
uut15 : S_box port map(byte_in => temp29, byte_out => temp30);
uut16 : S_box port map(byte_in => temp31, byte_out => temp32);
    proc : process(Clk) is begin
        if (rising_edge(Clk)) then

            output <= input;

            -- 1st row
            temp1 <= input(0)(0);
            output(0)(0) <= temp2;

            temp3 <= input(0)(1);
            output(0)(1) <= temp4;

            temp5 <= input(0)(2);
            output(0)(2) <= temp6;

            temp7 <= input(0)(3);
            output(0)(3) <= temp8;

            -- 2nd row
            temp9 <= input(1)(0);
            output(1)(0) <= temp10;

            temp11 <= input(1)(1);
            output(1)(1) <= temp12;

            temp13 <= input(1)(2);
            output(1)(2) <= temp14;

            temp15 <= input(1)(3);
            output(1)(3) <= temp16;

            -- 3rd row
            temp17 <= input(2)(0);
            output(2)(0) <= temp18;

            temp19 <= input(2)(1);
            output(2)(1) <= temp20;

            temp21 <= input(2)(2);
            output(2)(2) <= temp22;

            temp23 <= input(2)(3);
            output(2)(3) <= temp24;

            -- 4th row
            temp25 <= input(3)(0);
            output(3)(0) <= temp26;

            temp27 <= input(3)(1);
            output(3)(1) <= temp28;
            
            temp29 <= input(3)(2);
            output(3)(2) <= temp30;

            temp31 <= input(3)(3);
            output(3)(3) <= temp32;


        end if;
    end process;
end arch;