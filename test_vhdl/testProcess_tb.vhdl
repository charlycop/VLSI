-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity testProcess_tb is
end testProcess_tb;

architecture simu of testProcess_tb is
signal ck, reset, clk_go     : std_logic := '1';
signal sortie_process : std_logic_vector (3 downto 0);
signal sortie_combi   : std_logic_vector (3 downto 0);


begin


L0: entity work.testProcess
port map (ck, reset,sortie_process, sortie_combi);

-- LA CLOCK
reset <= '0' after 10 ns;
clk_go <= '0', '1' after 10 ns, '0' after 1000 ns; 
ck<= not ck after 100 ns when clk_go='1';

end simu;
