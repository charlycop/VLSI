-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity test_stdlogictovector is
port (  vectorIn 	: in std_logic_vector (31 downto 0);
	bitIn           : in std_logic;
	sortie          : out std_logic_vector (31 downto 0));

end test_stdlogictovector;

-- description du composant
ARCHITECTURE archi OF test_stdlogictovector IS
signal tampon : std_logic_vector (31 downto 0);
BEGIN

tampon <= X"FFFFFFFF" WHEN bitIn='1' else (others=>'0');
sortie <= tampon XOR vectorIn;

END archi;
