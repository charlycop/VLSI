-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity shifter_lsl is
port (  entree 	  : in std_logic_vector (31 downto 0);
	shift_val : in std_logic_vector (4 downto 0);
	sortie    : out std_logic_vector (31 downto 0));

end shifter_lsl;

-- description du composant
ARCHITECTURE archi OF shifter_lsl IS
--les signaux ici
signal etg1_s, etg2_s, etg3_s, etg4_s, etg5_s : std_logic_vector(31 downto 0);

BEGIN

etg1_s <= entree(30 downto 0) & "0"     WHEN shift_val(0)='1' else entree;
etg2_s <= etg1_s(29 downto 0) & "00"    WHEN shift_val(1)='1' else etg1_s;
etg3_s <= etg2_s(27 downto 0) & X"0"    WHEN shift_val(2)='1' else etg2_s;
etg4_s <= etg3_s(23 downto 0) & X"00"   WHEN shift_val(3)='1' else etg3_s;
sortie <= etg4_s(15 downto 0) & X"0000" WHEN shift_val(4)='1' else etg4_s;

END archi;
