-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity TestBench is
end TestBench;

architecture simu of TestBench is
    signal a,b: unsigned(3 downto 0);
    signal cin: unsigned(0 downto 0);
    signal s2 : unsigned(4 downto 0);
begin

    L0: entity work.adder4b
        port map (a,b,cin,s2);

    a      <="0000", "0001" after 100 ns, "0010" after 200 ns;
    b      <="0000";
    cin    <= "0";

end simu;