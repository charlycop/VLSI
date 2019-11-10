-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity TestBench is
end TestBench;

architecture simu of TestBench is
signal ope1,ope2: std_logic_vector(31 downto 0);
signal start: std_logic;
signal ck: std_logic;
signal res : std_logic_vector(31 downto 0);
signal valid : std_logic;

begin

L0: entity work.Annale_2016
port map (ope1,ope2,start,ck,res,valid);

ope1 <=X"00000002",X"00000001" after 100 ns;
ope2 <=X"00000002";
start<='1' after 10 ns;


end simu;
