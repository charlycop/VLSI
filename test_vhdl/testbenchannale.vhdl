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

begin

    L0: entity work.annale
        port map (prog, prog_en, ck, run, compte);

    --prog <= "00", "01" after 1000 ns, "10" after 2000 ns;
    prog_en <= '0', '1' after 10 ns;
    ck <= not ck after 1 ns;


process
variable rd : integer;
variable rdstd : std_logic_vector(31 downto 0);

begin
	--  Check each pattern.
	for i in 1 to 4 loop
		--  Set the inputs.
		prog <= std_logic_vector(to_unsigned(i,2));
		wait for 1000 ns;
		
	end loop;
assert ((compte=200) AND (prog="00") AND (run='1'))  report "RUN A 1 HOLALA" severity error;
end process;

end simu;
