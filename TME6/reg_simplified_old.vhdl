LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Reg IS
	PORT(
	-- Write Port 1 prioritaire (EXEC)
		wdata1	  		: IN Std_Logic_Vector(31 DOWNTO 0);
		wadr1			: IN Std_Logic_Vector(3 DOWNTO 0);
		wen1			: IN Std_Logic;

	-- Write Port 2 non prioritaire
		wdata2			: IN Std_Logic_Vector(31 DOWNTO 0);
		wadr2			: IN Std_Logic_Vector(3 DOWNTO 0);
		wen2			: IN Std_Logic;

	-- Write CSPR Port
		wcry			: IN Std_Logic;
		wzero			: IN Std_Logic;
		wneg			: IN Std_Logic;
		wovr			: IN Std_Logic;
		cspr_wb			: IN Std_Logic;
		
	-- Read Port 1 32 bits
		reg_rd1		: OUT Std_Logic_Vector(31 DOWNTO 0);
		radr1		: IN Std_Logic_Vector(3 DOWNTO 0);
		reg_v1		: OUT Std_Logic;

	-- Read Port 2 32 bits
		reg_rd2		: OUT Std_Logic_Vector(31 DOWNTO 0);
		radr2		: IN Std_Logic_Vector(3 DOWNTO 0);
		reg_v2		: OUT Std_Logic;

	-- Read Port 3 32 bits
		reg_rd3		: OUT Std_Logic_Vector(31 DOWNTO 0);
		radr3		: IN Std_Logic_Vector(3 DOWNTO 0);
		reg_v3		: OUT Std_Logic;

	-- read CSPR Port
		reg_cry		: OUT Std_Logic;
		reg_zero	: OUT Std_Logic;
		reg_neg		: OUT Std_Logic;
		reg_cznv	: OUT Std_Logic;
		reg_ovr		: OUT Std_Logic;
		reg_vv		: OUT Std_Logic;

		
		
	-- Invalidate Port 
		inval_adr1	: IN Std_Logic_Vector(3 DOWNTO 0);
		inval1		: IN Std_Logic;

		inval_adr2	: IN Std_Logic_Vector(3 DOWNTO 0);
		inval2		: IN Std_Logic;

		inval_czn	: IN Std_Logic;
		inval_ovr	: IN Std_Logic;

	-- PC
		reg_pc		: OUT Std_Logic_Vector(31 DOWNTO 0);
		reg_pcv		: OUT Std_Logic;
		inc_pc		: IN Std_Logic;
	
	-- global interface
		ck				: IN Std_Logic;
		reset_n		: IN Std_Logic;
		vdd			: IN bit;
		vss			: IN bit);
END Reg;

ARCHITECTURE Behavior OF Reg IS
SIGNAL R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15 : std_logic_vector(31 DOWNTO 0);
SIGNAL invalBits : std_logic_vector(14 DOWNTO 0);
SIGNAL wcry_s, wzero_s, wneg_s, wovr_s : std_logic;

BEGIN
--flags--
wcry_s   <= wcry     WHEN cspr_wb='1' AND inval_czn='1' ELSE wcry_s;
reg_cry  <= wcry_s;

wzero_s  <= wzero    WHEN cspr_wb='1' AND inval_czn='1' ELSE wzero_s;
reg_zero  <= wzero_s ;

wneg_s   <= wneg     WHEN cspr_wb='1' AND inval_czn='1'  ELSE wneg_s;
reg_neg  <= wneg_s;

wovr_s   <= wovr     WHEN cspr_wb='1' AND inval_ovr='1'  ELSE wovr_s;
reg_ovr  <= wovr_s;

---PC---
-- Si decode n'a pas de BR, il envoie inc_pc à 1 pour incrémenter.
reg_pc <= std_logic_vector(unsigned(R15) + "00000000000000000000000000000100") WHEN inc_pc='1' ELSE R15;

-- INVALIDATION --
PROCESS (inval_adr1, inval_adr2, inval2, inval1)
VARIABLE reg1: INTEGER := to_integer(unsigned(inval_adr1));
VARIABLE reg2: INTEGER := to_integer(unsigned(inval_adr2));
BEGIN
    
  invalBits(reg1) <= inval1;
  invalBits(reg2) <= inval2;
    
END PROCESS;

-- READ --
PROCESS (radr1)
VARIABLE registre: INTEGER := to_integer(unsigned(radr1));
BEGIN
    
  CASE registre IS
    WHEN 0 => reg_rd1 <= R0;
    WHEN 1 => reg_rd1 <= R1;
    WHEN 2 => reg_rd1 <= R2 ;
    WHEN 3 => reg_rd1 <= R3 ;
    WHEN 4 => reg_rd1 <= R4 ;
    WHEN 5 => reg_rd1 <= R5;
    WHEN 6 => reg_rd1 <= R6;
    WHEN 7 => reg_rd1 <= R7 ;
    WHEN 8 => reg_rd1 <= R8 ;
    WHEN 9 => reg_rd1 <= R9 ;
    WHEN 10 => reg_rd1 <= R10 ;
    WHEN 11 => reg_rd1 <= R11 ;
    WHEN 12 => reg_rd1 <= R12 ;
    WHEN 13 => reg_rd1 <= R13;
    WHEN 14 => reg_rd1 <= R14 ;
    WHEN 15 => reg_rd1 <= R15 ;
    WHEN OTHERS => reg_rd1 <= (OTHERS=>'0');
 END CASE;
    
  CASE registre IS
    WHEN 0 => reg_v1 <= invalBits(registre) ;
    WHEN 1 => reg_v1 <= invalBits(registre) ;
    WHEN 2 => reg_v1 <= invalBits(registre) ;
    WHEN 3 => reg_v1 <= invalBits(registre) ;
    WHEN 4 => reg_v1 <= invalBits(registre) ;
    WHEN 5 => reg_v1 <= invalBits(registre) ;
    WHEN 6 => reg_v1 <= invalBits(registre) ;
    WHEN 7 => reg_v1 <= invalBits(registre) ;
    WHEN 8 => reg_v1 <= invalBits(registre) ;
    WHEN 9 => reg_v1 <= invalBits(registre) ;
    WHEN 10 => reg_v1 <= invalBits(registre) ;
    WHEN 11 => reg_v1 <= invalBits(registre) ;
    WHEN 12 => reg_v1 <= invalBits(registre) ;
    WHEN 13 => reg_v1 <= invalBits(registre) ;
    WHEN 14 => reg_v1 <= invalBits(registre) ;
    WHEN 15 => reg_v1 <= invalBits(registre) ;
    WHEN OTHERS => reg_v1 <= '0';
  END CASE;
    
END PROCESS;

PROCESS (radr2)
VARIABLE registre: INTEGER := to_integer(unsigned(radr1));
BEGIN
    
  CASE registre IS
    WHEN 0 => reg_rd2 <= R0;
    WHEN 1 => reg_rd2 <= R1;
    WHEN 2 => reg_rd2 <= R2 ;
    WHEN 3 => reg_rd2 <= R3 ;
    WHEN 4 => reg_rd2 <= R4 ;
    WHEN 5 => reg_rd2 <= R5;
    WHEN 6 => reg_rd2 <= R6;
    WHEN 7 => reg_rd2 <= R7 ;
    WHEN 8 => reg_rd2 <= R8 ;
    WHEN 9 => reg_rd2 <= R9 ;
    WHEN 10 => reg_rd2 <= R10 ;
    WHEN 11 => reg_rd2 <= R11 ;
    WHEN 12 => reg_rd2 <= R12 ;
    WHEN 13 => reg_rd2 <= R13;
    WHEN 14 => reg_rd2 <= R14 ;
    WHEN 15 => reg_rd2 <= R15 ;
    WHEN OTHERS => reg_rd2 <= (OTHERS=>'0');
 END CASE;
    
  CASE registre IS
    WHEN 0 => reg_v2 <= invalBits(registre) ;
    WHEN 1 => reg_v2 <= invalBits(registre) ;
    WHEN 2 => reg_v2 <= invalBits(registre) ;
    WHEN 3 => reg_v2 <= invalBits(registre) ;
    WHEN 4 => reg_v2 <= invalBits(registre) ;
    WHEN 5 => reg_v2 <= invalBits(registre) ;
    WHEN 6 => reg_v2 <= invalBits(registre) ;
    WHEN 7 => reg_v2 <= invalBits(registre) ;
    WHEN 8 => reg_v2 <= invalBits(registre) ;
    WHEN 9 => reg_v2 <= invalBits(registre) ;
    WHEN 10 => reg_v2 <= invalBits(registre) ;
    WHEN 11 => reg_v2 <= invalBits(registre) ;
    WHEN 12 => reg_v2 <= invalBits(registre) ;
    WHEN 13 => reg_v2 <= invalBits(registre) ;
    WHEN 14 => reg_v2 <= invalBits(registre) ;
    WHEN 15 => reg_v2 <= invalBits(registre) ;
    WHEN OTHERS => reg_v2 <= '0';
  END CASE;
    
END PROCESS;

PROCESS (radr3)
VARIABLE registre: INTEGER := to_integer(unsigned(radr1));
BEGIN
    
  CASE registre IS
    WHEN 0 => reg_rd3 <= R0;
    WHEN 1 => reg_rd3 <= R1;
    WHEN 2 => reg_rd3 <= R2 ;
    WHEN 3 => reg_rd3 <= R3 ;
    WHEN 4 => reg_rd3 <= R4 ;
    WHEN 5 => reg_rd3 <= R5;
    WHEN 6 => reg_rd3 <= R6;
    WHEN 7 => reg_rd3 <= R7 ;
    WHEN 8 => reg_rd3 <= R8 ;
    WHEN 9 => reg_rd3 <= R9 ;
    WHEN 10 => reg_rd3 <= R10 ;
    WHEN 11 => reg_rd3 <= R11 ;
    WHEN 12 => reg_rd3 <= R12 ;
    WHEN 13 => reg_rd3 <= R13;
    WHEN 14 => reg_rd3 <= R14 ;
    WHEN 15 => reg_rd3 <= R15 ;
    WHEN OTHERS => reg_rd3 <= (OTHERS=>'0');
 END CASE;
    
  CASE registre IS
    WHEN 0 => reg_v3 <= invalBits(registre) ;
    WHEN 1 => reg_v3 <= invalBits(registre) ;
    WHEN 2 => reg_v3 <= invalBits(registre) ;
    WHEN 3 => reg_v3 <= invalBits(registre) ;
    WHEN 4 => reg_v3 <= invalBits(registre) ;
    WHEN 5 => reg_v3 <= invalBits(registre) ;
    WHEN 6 => reg_v3 <= invalBits(registre) ;
    WHEN 7 => reg_v3 <= invalBits(registre) ;
    WHEN 8 => reg_v3 <= invalBits(registre) ;
    WHEN 9 => reg_v3 <= invalBits(registre) ;
    WHEN 10 => reg_v3 <= invalBits(registre) ;
    WHEN 11 => reg_v3 <= invalBits(registre) ;
    WHEN 12 => reg_v3 <= invalBits(registre) ;
    WHEN 13 => reg_v3 <= invalBits(registre) ;
    WHEN 14 => reg_v3 <= invalBits(registre) ;
    WHEN 15 => reg_v3 <= invalBits(registre) ;
    WHEN OTHERS => reg_v3 <= '0';
  END CASE;
    
END PROCESS;

---WRITE---
PROCESS (ck)
VARIABLE registre: INTEGER := to_integer(unsigned(wadr1));
BEGIN

    IF rising_edge(ck) THEN
        IF wen1 = '1' AND invalBits(registre)='0' THEN
			CASE registre IS
				WHEN 0 => R0 <= wdata1;
				WHEN 1 => R1 <= wdata1;
				WHEN 2 => R2 <= wdata1;
				WHEN 3 => R3 <= wdata1;
				WHEN 4 => R4 <= wdata1;
				WHEN 5 => R5 <= wdata1;
				WHEN 6 => R6 <= wdata1;
				WHEN 7 => R7 <= wdata1;
				WHEN 8 => R8 <= wdata1;
				WHEN 9 => R9 <= wdata1;
				WHEN 10 => R10 <= wdata1;
				WHEN 11 => R11 <= wdata1;
				WHEN 12 => R12 <= wdata1;
				WHEN 13 => R13 <= wdata1;
				WHEN 14 => R14 <= wdata1;
				WHEN 15 => R15 <= wdata1;
				WHEN OTHERS => R1 <= (others=>'0');
  			END CASE;
			invalBits(registre) <= '1'; 
		END IF;
    END IF;

END PROCESS;

---WRITE---
PROCESS (ck)
VARIABLE registre: INTEGER := to_integer(unsigned(wadr2));
BEGIN

    IF rising_edge(ck) THEN
        IF wen2 = '1' AND invalBits(registre)='0' THEN
			CASE registre IS
				WHEN 0 => R0 <= wdata2;
				WHEN 1 => R1 <= wdata2;
				WHEN 2 => R2 <= wdata2;
				WHEN 3 => R3 <= wdata2;
				WHEN 4 => R4 <= wdata2;
				WHEN 5 => R5 <= wdata2;
				WHEN 6 => R6 <= wdata2;
				WHEN 7 => R7 <= wdata2;
				WHEN 8 => R8 <= wdata2;
				WHEN 9 => R9 <= wdata2;
				WHEN 10 => R10 <= wdata2;
				WHEN 11 => R11 <= wdata2;
				WHEN 12 => R12 <= wdata2;
				WHEN 13 => R13 <= wdata2;
				WHEN 14 => R14 <= wdata2;
				WHEN 15 => R15 <= wdata2;
				WHEN OTHERS => R1 <= (others=>'0');
  			END CASE;
			invalBits(registre) <= '1'; 
		END IF;
    END IF;

END PROCESS;


END Behavior;

