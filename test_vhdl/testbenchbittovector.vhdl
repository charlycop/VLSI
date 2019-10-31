-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
use ieee.math_real.all;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity testbenchbittovector is
end testbenchbittovector;

architecture simu of testbenchbittovector is
signal vectorIn 	:  std_logic_vector (31 downto 0);
signal bitIn            :  std_logic;
signal sortie           : std_logic_vector (31 downto 0);

begin

    L0: entity work.test_stdlogictovector
        port map (vectorIn, bitIn,sortie);

    bitIn <= '0', '1' after 10 ns, '0' after 20 ns;
    vectorIn <= X"FFE58239" after 10 ns;


end simu;
