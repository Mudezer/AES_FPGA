library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library xil_defaultlib; 
use xil_defaultlib.matpack.all;


entity MixColumns is port(
    Clk : in std_logic;
    input : in matrix;
    output : out matrix
); end MixColumns;

architecture arch of MixColumns is 

component LUT_mul2 is port(
    byte_in : in std_logic_vector(0 to 7);
    byte_out : out std_logic_vector(0 to 7)
); end component;

component LUT_mul3 is port(
    byte_in : in std_logic_vector(0 to 7);
    byte_out : out std_logic_vector(0 to 7)
); end component;

signal temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10 : std_logic_vector(0 to 7);
signal temp11,temp12,temp13,temp14,temp15,temp16,temp17,temp18,temp19 : std_logic_vector(0 to 7);
signal temp20,temp21,temp22,temp23,temp24,temp25,temp26,temp27,temp28,temp29 : std_logic_vector(0 to 7);
signal temp30,temp31,temp32,temp33,temp34,temp35,temp36,temp37,temp38,temp39: std_logic_vector(0 to 7);
signal temp40,temp41,temp42,temp43,temp44,temp45,temp46,temp47,temp48,temp49 : std_logic_vector(0 to 7);
signal temp50,temp51,temp52,temp53,temp54,temp55,temp56,temp57,temp58,temp59 : std_logic_vector(0 to 7);
signal temp60,temp61,temp62,temp63,temp64: std_logic_vector(0 to 7);


begin

uut1 : LUT_mul2 port map(byte_in => temp1, byte_out => temp2);
uut2 : LUT_mul3 port map(byte_in => temp3, byte_out => temp4);
uut3 : LUT_mul2 port map(byte_in => temp5, byte_out => temp6);
uut4 : LUT_mul3 port map(byte_in => temp7, byte_out => temp8);
uut5 : LUT_mul2 port map(byte_in => temp9, byte_out => temp10);
uut6 : LUT_mul3 port map(byte_in => temp11, byte_out => temp12);
uut7 : LUT_mul2 port map(byte_in => temp13, byte_out => temp14);
uut8 : LUT_mul3 port map(byte_in => temp15, byte_out => temp16);

uut9 : LUT_mul2 port map(byte_in => temp17, byte_out => temp18);
uut10 : LUT_mul3 port map(byte_in => temp19, byte_out => temp20);
uut11 : LUT_mul2 port map(byte_in => temp21, byte_out => temp22);
uut12 : LUT_mul3 port map(byte_in => temp23, byte_out => temp24);
uut13 : LUT_mul2 port map(byte_in => temp25, byte_out => temp26);
uut14 : LUT_mul3 port map(byte_in => temp27, byte_out => temp28);
uut15 : LUT_mul2 port map(byte_in => temp29, byte_out => temp30);
uut16 : LUT_mul3 port map(byte_in => temp31, byte_out => temp32);

uut17 : LUT_mul2 port map(byte_in => temp33, byte_out => temp34);
uut18 : LUT_mul3 port map(byte_in => temp35, byte_out => temp36);
uut19 : LUT_mul2 port map(byte_in => temp37, byte_out => temp38);
uut20 : LUT_mul3 port map(byte_in => temp39, byte_out => temp40);
uut21 : LUT_mul2 port map(byte_in => temp41, byte_out => temp42);
uut22 : LUT_mul3 port map(byte_in => temp43, byte_out => temp44);
uut23 : LUT_mul2 port map(byte_in => temp45, byte_out => temp46);
uut24 : LUT_mul3 port map(byte_in => temp47, byte_out => temp48);

uut25 : LUT_mul2 port map(byte_in => temp49, byte_out => temp50);
uut26 : LUT_mul3 port map(byte_in => temp51, byte_out => temp52);
uut27 : LUT_mul2 port map(byte_in => temp53, byte_out => temp54);
uut28 : LUT_mul3 port map(byte_in => temp55, byte_out => temp56);
uut29 : LUT_mul2 port map(byte_in => temp57, byte_out => temp58);
uut30 : LUT_mul3 port map(byte_in => temp59, byte_out => temp60);
uut31 : LUT_mul2 port map(byte_in => temp61, byte_out => temp62);
uut32 : LUT_mul3 port map(byte_in => temp63, byte_out => temp64);



    proc : process(Clk) is begin
        if (rising_edge(Clk)) then

        ---- First column ----

        -- b(0)(0)
        temp1 <= input(0)(0);   -- 2*a(0)(0)
        temp3 <= input(1)(0);   -- 3*a(1)(0)
        output(0)(0) <= temp2 xor temp4 xor input(2)(0) xor input(3)(0);

        -- b(1)(0)
        temp5 <= input(1)(0);
        temp7 <= input(2)(0); 
        output(1)(0) <= input(0)(0) xor temp6 xor temp8 xor input(3)(0);

        -- b(2)(0)
        temp9 <= input(2)(0);   
        temp11 <= input(3)(0);   
        output(2)(0) <= input(0)(0) xor input(1)(0) xor temp10 xor temp12;

        -- b(3)(0)
        temp13 <= input(3)(0);  
        temp15 <= input(0)(0);   
        output(3)(0) <= temp16 xor input(1)(0) xor input(2)(0) xor temp14;


        ---- Second column ----

        -- b(0)(1)
        temp17 <= input(0)(1); 
        temp19 <= input(1)(1);   
        output(0)(1) <= temp18 xor temp20 xor input(2)(1) xor input(3)(1);

        -- b(1)(1)
        temp21 <= input(1)(1);
        temp23 <= input(2)(1); 
        output(1)(1) <= input(0)(1) xor temp22 xor temp24 xor input(3)(1);

        -- b(2)(1)
        temp25 <= input(2)(1);   
        temp27 <= input(3)(1);   
        output(2)(1) <= input(0)(1) xor input(1)(1) xor temp26 xor temp28;

        -- b(3)(1)
        temp29 <= input(3)(1);  
        temp31 <= input(0)(1);   
        output(3)(1) <= temp32 xor input(1)(1) xor input(2)(1) xor temp30;


        ---- Third column ----

        -- b(0)(2)
        temp33 <= input(0)(2); 
        temp35 <= input(1)(2);   
        output(0)(2) <= temp34 xor temp36 xor input(2)(2) xor input(3)(2);

        -- b(1)(2)
        temp37 <= input(1)(2);
        temp39 <= input(2)(2); 
        output(1)(2) <= input(0)(2) xor temp38 xor temp40 xor input(3)(2);

        -- b(2)(2)
        temp41 <= input(2)(2);   
        temp43 <= input(3)(2);   
        output(2)(2) <= input(0)(2) xor input(1)(2) xor temp42 xor temp44;

        -- b(3)(2)
        temp45 <= input(3)(2);  
        temp47 <= input(0)(2);   
        output(3)(2) <= temp48 xor input(1)(2) xor input(2)(2) xor temp46;


        ---- Fourth column ----

        -- b(0)(3)
        temp49 <= input(0)(3); 
        temp51 <= input(1)(3);   
        output(0)(3) <= temp50 xor temp52 xor input(2)(3) xor input(3)(3);

        -- b(1)(3)
        temp53 <= input(1)(3);
        temp55 <= input(2)(3); 
        output(1)(3) <= input(0)(3) xor temp54 xor temp56 xor input(3)(3);

        -- b(2)(3)
        temp57 <= input(2)(3);   
        temp59 <= input(3)(3);   
        output(2)(3) <= input(0)(3) xor input(1)(3) xor temp58 xor temp60;

        -- b(3)(3)
        temp61 <= input(3)(3);  
        temp63 <= input(0)(3);   
        output(3)(3) <= temp64 xor input(1)(3) xor input(2)(3) xor temp62;

        end if;
    end process;
end arch;