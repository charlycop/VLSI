-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
use ieee.math_real.all;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity testbench_Reg is
end testbench_Reg;

architecture simu of testbench_Reg is
	-- Write Port 1 prioritaire (EXEC)
		signal wdata1	  		: Std_Logic_Vector(31 DOWNTO 0);
		signal wadr1			: Std_Logic_Vector(3 DOWNTO 0);
		signal wen1			: Std_Logic;

	-- Write Port 2 non prioritaire
		signal wdata2			: Std_Logic_Vector(31 DOWNTO 0);
		signal wadr2			: Std_Logic_Vector(3 DOWNTO 0);
		signal wen2			: Std_Logic;

	-- Write CSPR Port
		signal wcry			: Std_Logic;
		signal wzero			: Std_Logic;
		signal wneg			: Std_Logic;
		signal wovr			: Std_Logic;
		signal cspr_wb			: Std_Logic;
		
	-- Read Port 1 32 bits
		signal reg_rd1		: Std_Logic_Vector(31 DOWNTO 0);
		signal radr1		: Std_Logic_Vector(3 DOWNTO 0);
		signal reg_v1		: Std_Logic;

	-- Read Port 2 32 bits
		signal reg_rd2		: Std_Logic_Vector(31 DOWNTO 0);
		signal radr2		: Std_Logic_Vector(3 DOWNTO 0);
		signal reg_v2		: Std_Logic;

	-- Read Port 3 32 bits
		signal reg_rd3		: Std_Logic_Vector(31 DOWNTO 0);
		signal radr3		: Std_Logic_Vector(3 DOWNTO 0);
		signal reg_v3		: Std_Logic;

	-- read CSPR Port
		signal reg_cry		: Std_Logic;
		signal reg_zero	: Std_Logic;
		signal reg_neg		: Std_Logic;
		signal reg_cznv	: Std_Logic;
		signal reg_ovr		: Std_Logic;
		signal reg_vv		: Std_Logic;

		
		
	-- Invalidate Port 
		signal inval_adr1	: Std_Logic_Vector(3 DOWNTO 0);
		signal inval1		: Std_Logic;

		signal inval_adr2	: Std_Logic_Vector(3 DOWNTO 0);
		signal inval2		: Std_Logic;

		signal inval_czn	: Std_Logic;
		signal inval_ovr	: Std_Logic;

	-- PC
		signal reg_pc		: Std_Logic_Vector(31 DOWNTO 0);
		signal reg_pcv		: Std_Logic;
		signal inc_pc		: Std_Logic;
	
	-- global interface
		signal ck				: Std_Logic := '0';
		signal ckOnOff : std_logic;
		signal reset_n		: Std_Logic;
		signal vdd			:  bit;
		signal vss			:  bit;
        signal SORTIE       : Std_Logic_Vector(31 DOWNTO 0);
        signal invalBit     : std_logic_vector(15 downto 0);

begin

    L0: entity work.Reg
        port map (wdata1, wadr1, wen1, wdata2, wadr2, wen2, wcry, wzero, wneg, wovr, cspr_wb, reg_rd1, radr1, reg_v1, reg_rd2, radr2, reg_v2, reg_rd3, radr3, reg_v3, reg_cry, reg_zero, reg_neg, reg_cznv, reg_ovr, reg_vv, inval_adr1, inval1, inval_adr2, inval2, inval_czn, inval_ovr, reg_pc, reg_pcv, inc_pc, ck, reset_n, vdd, vss, SORTIE, invalBit);

-- LA CLOCK
ckOnOff <= '1', '0' after 1000 ns; 
ck<= not ck after 10 ns when ckOnOff='1';

-- On écrit dans R2 la valeur 3566
wdata1     <= X"00000dee" after 100 ns, X"000FFFFF" after 490 ns;
wadr1      <= X"2"        after 100 ns, X"3" after 450 ns;
wen1       <= '1'	      after 120 ns;
inval_adr1 <= X"0", X"2"  after 100 ns, X"3" after 520 ns;
inval1     <= '0', '1' after 150 ns;

-- On lit dans R2
radr1 <= X"2"        after 200 ns, X"3" after 500 ns;

-- On incrémente PC
inc_pc <= '0', '1' after 200 ns, '0' after 210 ns;



end simu;
