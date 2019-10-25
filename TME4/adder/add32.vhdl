-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

-- declaration de l interface
ENTITY adder32b IS
PORT (
        a,b: in unsigned(3 downto 0);
        cin: in unsigned;
        s2: out unsigned(4 downto 0));

end adder32b;

s2   <= '0'&a+b+cin;  -- Addition avec retenue sortante