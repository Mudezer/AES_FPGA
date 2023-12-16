library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library xil_defaultlib; 
use xil_defaultlib.matpack.all;


entity MixColumns is port(
    input: in matrix;
    output: out matrix
); end MixColumns;

architecture arch of MixColumns is -- structure declaration

component LUT_mul2 is port(
    byte_in : in std_logic_vector(0 to 7);
    byte_out : out std_logic_vector(0 to 7)
); end component;

component LUT_mul3 is port(
    byte_in : in std_logic_vector(0 to 7);
    byte_out : out std_logic_vector(0 to 7)
); end component;

signal temp1, temp2 : matrix;

begin

mix_gen : for i in 0 to 16 generate
    begin 
    -- first row
    mix_row_one: if i < 4 generate
       lut_mul2_1: LUT_mul2 port map(input(0)(i),temp1(0)(i)); -- a_00
       lut_mul3_1: LUT_mul3 port map(input(1)(i),temp2(1)(i)); -- a_10
       output(0)(i) <= temp1(0)(i) xor temp2(1)(i) xor input(2)(i) xor input(3)(i);
    end generate mix_row_one;

    -- second row
    mix_row_two: if i >= 4 and i < 8 generate
       lut_mul2_2: LUT_mul2 port map(input(1)(i-4),temp1(1)(i-4)); -- a_01
       lut_mul3_2: LUT_mul3 port map(input(2)(i-4),temp2(2)(i-4)); -- a_20
       output(1)(i-4) <= temp1(1)(i-4) xor temp2(2)(i-4) xor input(3)(i-4) xor input(0)(i-4);
    end generate mix_row_two;

    -- third row
    mix_row_three: if i >= 8 and i < 12 generate
       lut_mul2_3: LUT_mul2 port map(input(2)(i-8),temp1(2)(i-8)); -- a_20
       lut_mul3_3: LUT_mul3 port map(input(3)(i-8),temp2(3)(i-8)); -- a_30
       output(2)(i-8) <= temp1(2)(i-8) xor temp2(3)(i-8) xor input(0)(i-8) xor input(1)(i-8);
    end generate mix_row_three;

    -- fourth row
    mix_row_four: if i >= 12 and i < 16 generate
       lut_mul2_4: LUT_mul2 port map(input(3)(i-12),temp1(3)(i-12)); -- a_30
       lut_mul3_4: LUT_mul3 port map(input(0)(i-12),temp2(0)(i-12)); -- a_00
       output(3)(i-12) <= temp1(3)(i-12) xor temp2(0)(i-12) xor input(1)(i-12) xor input(2)(i-12);
    end generate mix_row_four;
end generate mix_gen;
end arch;