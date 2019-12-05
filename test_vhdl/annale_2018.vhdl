-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity annale_2018 is
port (  prog 	: in std_logic_vector (1 downto 0);
	prog_en : in std_logic;
	ck 	: in std_logic;
	run 	: out std_logic;
	compte  : out integer);

end annale_2018;

-- description du composant
ARCHITECTURE archi OF annale_2018 IS
signal compteur : integer:=0;
signal run_s    : std_logic;
signal prog_s     : std_logic_vector(1 downto 0);

BEGIN

process  (ck)
begin	
	if rising_edge(ck) AND prog_s /= "11" then
		compteur <= compteur + 1 ;
		
		if 	prog_s="00" AND compteur > 512 then
			compteur <= 0;
		elsif prog_s="01" AND compteur > 192*2 then
			compteur <= 0;
		elsif prog_s="10" AND compteur > 192+64 then
			compteur <= 0;
		end if;

	end if;

end process;

prog_s <= prog WHEN prog_en = '1' else prog_s;

run_s <= '1' WHEN (((compteur >= 0) AND (compteur <= 128) AND (prog="00")) OR
	         ((compteur >= 0) AND (compteur <= 192) AND (prog="01" OR prog="10"))) OR
		 (prog="11")
else '0';
	   

run <= run_s AND prog_en;
compte <= compteur;	
END archi;
