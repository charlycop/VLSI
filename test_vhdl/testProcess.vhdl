-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity testProcess is
port ( 	ck 	    : in std_logic;
		reset   : in std_logic;
		sortie_process 	: out std_logic_vector(3 downto 0);
		sortie_combi    : out std_logic_vector(3 downto 0));

end testProcess;

-- description du composant
ARCHITECTURE archi OF testProcess IS
--les signaux ici
signal sortie_s  : unsigned(3 downto 0) := "0000";
BEGIN

process (ck, reset)
begin
	if reset='1' then
   		sortie_s <= "0000";
    elsif rising_edge(ck) then
--		sortie_s <= std_logic_vector(unsigned(sortie_s) + "0001");
		sortie_s <= (to_integer(unsigned(sortie_s)) + 1);

    end if;
 sortie_process<= sortie_s;
	

end process;

sortie_combi <= sortie_s;


END archi;
