library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library xil_defaultlib; 
use xil_defaultlib.matpack.all;

entity ShiftRows is port(
    plain: in std_logic_vector(127 downto 0);
    outmatrix : out matrix
); end ShiftRows;

architecture arch of ShiftRows is
    signal inmatrix: matrix;
    signal temp: std_logic_vector(7 downto 0);
    
begin
    stim : process begin
          -- input matrix creation
        for i in 0 to 3 loop
            for j in 0 to 3 loop
                for l in 0 to 7 loop
                    inmatrix(i)(j)(l) <= plain(32*i+8*j+l);
                end loop;
            end loop;
        end loop;
            -- first row
            outmatrix(0) <= inmatrix(0);
            -- second row
            outmatrix(1)(3) <= inmatrix(1)(0);
            for j in 0 to 2 loop
                outmatrix(1)(j) <= inmatrix(1)(j+1);
            end loop;
            -- third row
            outmatrix(2)(2) <=  inmatrix(2)(0);
            outmatrix(2)(3) <=  inmatrix(2)(1);
            outmatrix(2)(0) <=  inmatrix(2)(2);
            outmatrix(2)(1) <=  inmatrix(2)(3);
            -- fourth row
            outmatrix(3)(0) <= inmatrix(3)(3);
            for j in 1 to 3 loop
                outmatrix(3)(j) <= inmatrix(3)(j-1);
            end loop;
            -- output vector 
    end process;
end arch;


-- une matrice est un tableau de rangée (i)
-- une rangée est un tableau de vecteur (j)
-- un vecteur est un tableau de bit (l)