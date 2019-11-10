-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity annale_2014_tb is
end annale_2014_tb;

architecture simu of annale_2014_tb is
signal ck     : std_logic := '0';
signal clk_go : std_logic := '1';
signal signin : std_logic := '0';
signal detect : std_logic := '0';
signal cpt : std_logic_vector (6 downto 0) := (others => '0');
signal sig : std_logic_vector (63 downto 0) := (others => '0');
signal compteur : integer := 0;


begin


L0: entity work.Annale_2014
port map (ck, signin, detect, sig,cpt);

process (ck)

begin
	if rising_edge(ck) then
		compteur <= compteur + 1;
		if (compteur < 1000) then
			signin <= '1';
		elsif(compteur = 1000) then
			signin <= '0';
			compteur <= 0;
		end if;
	
	end if;

end process;


-- LA CLOCK
clk_go <= '0' after 100000 ns; 
ck<= not ck after 10 ns when clk_go='1';

assert (compteur <= 2000) report "Le compteur ne s'arrete pas, il vaut : " & integer'image(compteur) severity error;
assert (detect='1') report "Detect est levé quand on a compteur = " &integer'image(to_integer(unsigned(cpt)));
end simu;
