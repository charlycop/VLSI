-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
use ieee.math_real.all;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity testbenchannale is
end testbenchannale;

architecture simu of testbenchannale is
signal prog 	:  std_logic_vector (1 downto 0);
signal prog_en :  std_logic;
signal ck 	:  std_logic:='0';
signal run 	:  std_logic;
signal compte   : integer;
signal clk_go : std_logic := '1';

begin

    L0: entity work.annale_2018
        port map (prog, prog_en, ck, run, compte);

    --prog <= "00", "01" after 1000 ns, "10" after 2000 ns;
    prog_en <= '0', '1' after 10 ns;


process
variable rd : integer;
variable rdstd : std_logic_vector(31 downto 0);

begin
	--  Check each pattern.
	for i in 1 to 4 loop
		--  Set the inputs.
		prog <= std_logic_vector(to_unsigned(i,2));
		wait for 1000000 ns;
		
	end loop;

wait;
end process;

    assert ((compte<=386) AND prog="00")  report "ERREUR COMPTEEUR SUP A 386 : "&integer'image(compte) severity error;
    -- LA CLOCK
	clk_go <= '0' after 100000000 ns; 
	ck<= not ck after 10 ns when clk_go='1';

end simu;
