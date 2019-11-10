-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity annale_2017 is
port (  din 	  : in std_logic_vector (3 downto 0);
	din_valid     : in std_logic;
	ck      	  : in std_logic;
	raz           : in std_logic;
	CS            : out std_logic_vector (3 downto 0));
end annale_2017;

-- description du composant
ARCHITECTURE archi OF annale_2017 IS
signal CS_s : std_logic_vector (3 downto 0) := X"0";

BEGIN

process  (ck, raz)
begin
    if raz='1' then CS_s <= (others => '0');
    
    elsif (rising_edge(ck) AND (din_valid='1')) then
            CS_s <= CS_s XOR din;
    end if;
    
end process;

CS     <= CS_s;
	
END archi;
