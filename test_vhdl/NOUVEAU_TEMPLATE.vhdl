-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity LE_NOM_ICI is
port (  prog 	: in std_logic_vector (1 downto 0);
	prog_en : in std_logic;
	ck 	: in std_logic;
	run 	: out std_logic;
	compte  : out integer);

end LE_NOM_ICI;

-- description du composant
ARCHITECTURE archi OF LE_NOM_ICI IS
--les signaux ici

BEGIN

END archi;
