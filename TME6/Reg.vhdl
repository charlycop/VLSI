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
		vss			: IN bit;

	-- sortie de TEST
		SORTIE  : OUT std_logic_vector(31 downto 0);
        invalBit    : OUT std_logic_vector(15 downto 0));
END Reg;

ARCHITECTURE Behavior OF Reg IS
SIGNAL R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15 : std_logic_vector(31 DOWNTO 0) := (others=>'0');
SIGNAL invalBits : std_logic_vector(15 DOWNTO 0) := (others => '0');
SIGNAL wcry_s, wzero_s, wneg_s, wovr_s : std_logic;

BEGIN

SORTIE <= R2;
invalBit <= invalBits;

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
reg_pc <= R15;

-- READ --
PROCESS (radr1)

BEGIN
  
	CASE radr1 IS
		WHEN X"0" => reg_rd1 <= R0;
		WHEN X"1" => reg_rd1 <= R1;
		WHEN X"2" => reg_rd1 <= R2 ;
		WHEN X"3" => reg_rd1 <= R3 ;
		WHEN X"4" => reg_rd1 <= R4 ;
		WHEN X"5" => reg_rd1 <= R5;
		WHEN X"6" => reg_rd1 <= R6;
		WHEN X"7" => reg_rd1 <= R7 ;
		WHEN X"8" => reg_rd1 <= R8 ;
		WHEN X"9" => reg_rd1 <= R9 ;
		WHEN X"A" => reg_rd1 <= R10 ;
		WHEN X"B" => reg_rd1 <= R11 ;
		WHEN X"C" => reg_rd1 <= R12 ;
		WHEN X"D" => reg_rd1 <= R13;
		WHEN X"E" => reg_rd1 <= R14 ;
		WHEN X"F" => reg_rd1 <= R15 ;
		WHEN OTHERS => reg_rd1 <= (OTHERS=>'0');
	END CASE;
    
  CASE radr1 IS
    WHEN X"0" => reg_v1 <=  NOT invalBits(0) ;
    WHEN X"1" => reg_v1 <=  NOT invalBits(1) ;
    WHEN X"2" => reg_v1 <=  NOT invalBits(2) ;
    WHEN X"3" => reg_v1 <=  NOT invalBits(3) ;
    WHEN X"4" => reg_v1 <=  NOT invalBits(4) ;
    WHEN X"5" => reg_v1 <=  NOT invalBits(5) ;
    WHEN X"6" => reg_v1 <=  NOT invalBits(6) ;
    WHEN X"7" => reg_v1 <=  NOT invalBits(7) ;
    WHEN X"8" => reg_v1 <=  NOT invalBits(8) ;
    WHEN X"9" => reg_v1 <=  NOT invalBits(9) ;
    WHEN X"A" => reg_v1 <= NOT invalBits(10) ;
    WHEN X"B" => reg_v1 <= NOT invalBits(11) ;
    WHEN X"C" => reg_v1 <= NOT invalBits(12) ;
    WHEN X"D" => reg_v1 <= NOT invalBits(13) ;
    WHEN X"E" => reg_v1 <= NOT invalBits(14) ;
    WHEN X"F" => reg_v1 <= NOT invalBits(15) ;
    WHEN OTHERS => reg_v1 <= '0';
  END CASE;
    
END PROCESS;



---WRITE---
PROCESS (ck, inval_adr1, inval_adr2, inval2, inval1, inc_pc)
BEGIN
        
    IF rising_edge(ck) THEN
        	IF invalBits(0)='1' THEN
		        IF     wadr1 = X"0" AND wen1 = '1' THEN 
		            R0 <= wdata1;
		            invalBits(0)<='0';
		        ELSIF  wadr2 = X"0" AND wen2 = '1' THEN
		            R0 <= wdata2;
		            invalBits(0)<='0';
		        END IF;

			ELSIF invalBits(1)='1' THEN
			    IF  wadr1 = X"1" AND wen1 = '1' THEN 
			        R1 <= wdata1;
			        invalBits(1)<='0';
			    ELSIF  wadr2 = X"1" AND wen2 = '1' THEN
			        R1 <= wdata2;
			        invalBits(1)<='0';
			    END IF;

			ELSIF invalBits(2)='1' THEN
			    IF  wadr1 = X"2" AND wen1 = '1' THEN 
			        R2 <= wdata1;
			        invalBits(2)<='0';
			    ELSIF  wadr2 = X"1" AND wen2 = '1' THEN
			        R2 <= wdata2;
			        invalBits(2)<='0';
			    END IF;

			ELSIF invalBits(3)='1' THEN
			    IF  wadr1 = X"3" AND wen1 = '1' THEN 
			        R3 <= wdata1;
			        invalBits(3)<='0';
			    ELSIF  wadr2 = X"3" AND wen2 = '1' THEN
			        R3 <= wdata2;
			        invalBits(3)<='0';
			    END IF;

			ELSIF invalBits(4)='1' THEN
			    IF  wadr1 = X"4" AND wen1 = '1' THEN 
			        R4 <= wdata1;
			        invalBits(4)<='0';
			    ELSIF  wadr2 = X"4" AND wen2 = '1' THEN
			        R4 <= wdata2;
			        invalBits(4)<='0';
			    END IF;   

			ELSIF invalBits(5)='1' THEN
			    IF  wadr1 = X"5" AND wen1 = '1' THEN 
			        R5 <= wdata1;
			        invalBits(5)<='0';
			    ELSIF  wadr2 = X"5" AND wen2 = '1' THEN
			        R5 <= wdata2;
			        invalBits(5)<='0';
			    END IF;

			ELSIF invalBits(6)='1' THEN
			    IF  wadr1 = X"6" AND wen1 = '1' THEN 
			        R6 <= wdata1;
			        invalBits(6)<='0';
			    ELSIF  wadr2 = X"6" AND wen2 = '1' THEN
			        R6 <= wdata2;
			        invalBits(6)<='0';
			    END IF;

			ELSIF invalBits(7)='1' THEN
			    IF  wadr1 = X"7" AND wen1 = '1' THEN 
			        R7 <= wdata1;
			        invalBits(7)<='0';
			    ELSIF  wadr2 = X"7" AND wen2 = '1' THEN
			        R7 <= wdata2;
			        invalBits(7)<='0';
			    END IF;

			ELSIF invalBits(8)='1' THEN
			    IF  wadr1 = X"8" AND wen1 = '1' THEN 
			        R8 <= wdata1;
			        invalBits(8)<='0';
			    ELSIF  wadr2 = X"8" AND wen2 = '1' THEN
			        R8 <= wdata2;
			        invalBits(8)<='0';
			    END IF;

			ELSIF invalBits(9)='1' THEN
			    IF  wadr1 = X"9" AND wen1 = '1' THEN 
			        R9 <= wdata1;
			        invalBits(9)<='0';
			    ELSIF  wadr2 = X"9" AND wen2 = '1' THEN
			        R9 <= wdata2;
			        invalBits(9)<='0';
			    END IF;

			ELSIF invalBits(10)='1' THEN
			    IF  wadr1 = X"A" AND wen1 = '1' THEN 
			        R10 <= wdata1;
			        invalBits(10)<='0';
			    ELSIF  wadr2 = X"A" AND wen2 = '1' THEN
			        R10 <= wdata2;
			        invalBits(10)<='0';
			    END IF;

			ELSIF invalBits(11)='1' THEN
			    IF  wadr1 = X"B" AND wen1 = '1' THEN 
			        R11 <= wdata1;
			        invalBits(11)<='0';
			    ELSIF  wadr2 = X"B" AND wen2 = '1' THEN
			        R11 <= wdata2;
			        invalBits(11)<='0';
			    END IF;

			ELSIF invalBits(12)='1' THEN
			    IF  wadr1 = X"C" AND wen1 = '1' THEN 
			        R12 <= wdata1;
			        invalBits(12)<='0';
			    ELSIF  wadr2 = X"C" AND wen2 = '1' THEN
			        R12 <= wdata2;
			        invalBits(12)<='0';
			    END IF;

			ELSIF invalBits(13)='1' THEN
			    IF  wadr1 = X"D" AND wen1 = '1' THEN 
			        R13 <= wdata1;
			        invalBits(13)<='0';
			    ELSIF  wadr2 = X"D" AND wen2 = '1' THEN
			        R13 <= wdata2;
			        invalBits(13)<='0';
			    END IF;

			ELSIF invalBits(14)='1' THEN
			    IF  wadr1 = X"E" AND wen1 = '1' THEN 
			        R14 <= wdata1;
			        invalBits(14)<='0';
			    ELSIF  wadr2 = X"E" AND wen2 = '1' THEN
			        R14 <= wdata2;
			        invalBits(14)<='0';
			    END IF;

			ELSIF invalBits(15)='1' OR inc_pc='1' THEN
			    IF  wadr1 = X"F" AND wen1 = '1' THEN 
			        R15 <= wdata1;
			        invalBits(15)<='0';
			    ELSIF  wadr2 = X"F" AND wen2 = '1' THEN
			        R15 <= wdata2;
			        invalBits(15)<='0';
			    END IF;
			END IF;

		
	
	ELSE
		IF (inc_pc='1')  THEN R15 <= std_logic_vector(unsigned(R15) + "00000000000000000000000000000100"); END IF;
		IF    wadr1=X"0" THEN invalBits(0) <= inval1;
		ELSIF wadr2=X"0" THEN invalBits(0) <= inval2; END IF;
		IF    wadr1=X"1" THEN invalBits(1) <= inval1;
		ELSIF wadr2=X"1" THEN invalBits(1) <= inval2; END IF;
		IF    wadr1=X"2" THEN invalBits(2) <= inval1;
		ELSIF wadr2=X"2" THEN invalBits(2) <= inval2; END IF;
		IF    wadr1=X"3" THEN invalBits(3) <= inval1;
		ELSIF wadr2=X"3" THEN invalBits(3) <= inval2; END IF;
		IF    wadr1=X"4" THEN invalBits(4) <= inval1; 
		ELSIF wadr2=X"4" THEN invalBits(4) <= inval2; END IF;
		IF    wadr1=X"5" THEN invalBits(5) <= inval1; 
		ELSIF wadr2=X"5" THEN invalBits(5) <= inval2; END IF;
		IF    wadr1=X"6" THEN invalBits(6) <= inval1; 
		ELSIF wadr2=X"6" THEN invalBits(6) <= inval2; END IF;
		IF    wadr1=X"7" THEN invalBits(7) <= inval1; 
		ELSIF wadr2=X"7" THEN invalBits(7) <= inval2; END IF;
		IF    wadr1=X"8" THEN invalBits(8) <= inval1; 
		ELSIF wadr2=X"8" THEN invalBits(8) <= inval2; END IF;
		IF    wadr1=X"9" THEN invalBits(9) <= inval1; 
		ELSIF wadr2=X"9" THEN invalBits(9) <= inval2; END IF;
		IF    wadr1=X"A" THEN invalBits(10) <= inval1; 
		ELSIF wadr2=X"A" THEN invalBits(10) <= inval2; END IF;
		IF    wadr1=X"B" THEN invalBits(11) <= inval1; 
		ELSIF wadr2=X"B" THEN invalBits(11) <= inval2; END IF;
		IF    wadr1=X"C" THEN invalBits(12) <= inval1; 
		ELSIF wadr2=X"C" THEN invalBits(12) <= inval2; END IF;
		IF    wadr1=X"D" THEN invalBits(13) <= inval1; 
		ELSIF wadr2=X"D" THEN invalBits(13) <= inval2; END IF;
		IF    wadr1=X"E" THEN invalBits(14) <= inval1; 
		ELSIF wadr2=X"E" THEN invalBits(14) <= inval2; END IF;
		IF    wadr1=X"F" THEN invalBits(15) <= inval1; 
		ELSIF wadr2=X"F" THEN invalBits(15) <= inval2; END IF;
    END IF;

END PROCESS;


END Behavior;

