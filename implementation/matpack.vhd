library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package matpack is

   type row is array (0 to 3) of std_logic_vector(0 to 7);
   type matrix is array(0 to 3) of row;

end  matpack;

package body matpack is
end package body;