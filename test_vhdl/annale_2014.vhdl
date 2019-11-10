-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity Annale_2014 is

port(   
	 ck      : in std_logic;
	 signin  : in std_logic;
	 detect  : out std_logic;
	 sig     : out std_logic_vector (63 downto 0);
	cpt: out std_logic_vector(6 downto 0)
	);

end Annale_2014;


ARCHITECTURE archi OF Annale_2014 IS

signal signal_s : unsigned(63 downto 0);
signal cpt_s      : integer := 0;
signal premierTour : std_logic := '0';

begin


process(ck)
	
begin
	
	if rising_edge(ck) then
		if (signal_s(cpt_s) /= signin ) and (premierTour='1') then
			detect <= '1';
			signal_s(cpt_s) <= signin;
		else
			detect <= '0';
		end if;
	
		if (cpt_s = 63) then 
			cpt_s <= 0;
			if(premierTour = '0') then
				premierTour <= '1' ;
			end if;
		else               cpt_s <= cpt_s + 1;
		end if;
		
	end if;

end process;

sig <= std_logic_vector(signal_s);
--cpt <= std_logic_vector(unsigned(cpt_s));

end archi;


