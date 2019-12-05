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
SIGNAL R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15 : std_logic_vector(32 DOWNTO 0) := (OTHERS=>'0');
--SIGNAL invalBits : std_logic_vector(14 DOWNTO 0);
SIGNAL wcry_s, wzero_s, wneg_s, wovr_s: std_logic;

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
--reg_pc <= std_logic_vector(unsigned(R15) + "00000000000000000000000000000100") WHEN inc_pc='1' ELSE R15;

-- INVALIDATION --
PROCESS (inval_adr1, inval1)
BEGIN
    
  CASE inval_adr1 IS
    WHEN "0000" => R0(32)  <= NOT inval1 ;
    WHEN "0001" => R1(32)  <= NOT inval1 ;
    WHEN "0010" => R2(32)  <= NOT inval1 ;
    WHEN "0011" => R3(32)  <= NOT inval1 ;
    WHEN "0100" => R4(32)  <= NOT inval1 ;
    WHEN "0101" => R5(32)  <= NOT inval1 ;
    WHEN "0110" => R6(32)  <= NOT inval1 ;
    WHEN "0111" => R7(32)  <= NOT inval1 ;
    WHEN "1000" => R8(32)  <= NOT inval1 ;
    WHEN "1001" => R9(32)  <= NOT inval1 ;
    WHEN "1010" => R10(32) <= NOT inval1 ;
    WHEN "1011" => R11(32) <= NOT inval1 ;
    WHEN "1100" => R12(32) <= NOT inval1 ;
    WHEN "1101" => R13(32) <= NOT inval1 ;
    WHEN "1110" => R14(32) <= NOT inval1 ;
    WHEN "1111" => R15(32) <= NOT inval1 ;
    WHEN OTHERS => R15(32) <= '0';
  END CASE;
    
END PROCESS;

-- READ --
PROCESS (radr1)
BEGIN

  CASE radr1 IS
    WHEN "0000" => reg_rd1 <= R0(31 DOWNTO 0) ;
    WHEN "0001" => reg_rd1 <= R1(31 DOWNTO 0) ;
    WHEN "0010" => reg_rd1 <= R2(31 DOWNTO 0) ;
    WHEN "0011" => reg_rd1 <= R3(31 DOWNTO 0) ;
    WHEN "0100" => reg_rd1 <= R4(31 DOWNTO 0) ;
    WHEN "0101" => reg_rd1 <= R5(31 DOWNTO 0) ;
    WHEN "0110" => reg_rd1 <= R6(31 DOWNTO 0) ;
    WHEN "0111" => reg_rd1 <= R7(31 DOWNTO 0) ;
    WHEN "1000" => reg_rd1 <= R8(31 DOWNTO 0) ;
    WHEN "1001" => reg_rd1 <= R9(31 DOWNTO 0) ;
    WHEN "1010" => reg_rd1 <= R10(31 DOWNTO 0) ;
    WHEN "1011" => reg_rd1 <= R11(31 DOWNTO 0) ;
    WHEN "1100" => reg_rd1 <= R12(31 DOWNTO 0) ;
    WHEN "1101" => reg_rd1 <= R13(31 DOWNTO 0) ;
    WHEN "1110" => reg_rd1 <= R14(31 DOWNTO 0) ;
    WHEN "1111" => reg_rd1 <= R15(31 DOWNTO 0) ;
    WHEN OTHERS => reg_rd1 <= (OTHERS=>'0');
 END CASE;
    
  CASE radr1 IS
    WHEN "0000" => reg_v1 <= R0(32) ;
    WHEN "0001" => reg_v1 <= R1(32) ;
    WHEN "0010" => reg_v1 <= R2(32) ;
    WHEN "0011" => reg_v1 <= R3(32) ;
    WHEN "0100" => reg_v1 <= R4(32) ;
    WHEN "0101" => reg_v1 <= R5(32) ;
    WHEN "0110" => reg_v1 <= R6(32) ;
    WHEN "0111" => reg_v1 <= R7(32) ;
    WHEN "1000" => reg_v1 <= R8(32) ;
    WHEN "1001" => reg_v1 <= R9(32) ;
    WHEN "1010" => reg_v1 <= R10(32) ;
    WHEN "1011" => reg_v1 <= R11(32) ;
    WHEN "1100" => reg_v1 <= R12(32) ;
    WHEN "1101" => reg_v1 <= R13(32) ;
    WHEN "1110" => reg_v1 <= R14(32) ;
    WHEN "1111" => reg_v1 <= R15(32) ;
    WHEN OTHERS => reg_v1 <= '0';
  END CASE;
    
END PROCESS;



---WRITE---

PROCESS (ck)
BEGIN

    IF rising_edge(ck) THEN
        IF wen1 = '1' THEN
            IF    wadr1=X"0" AND R0(32)='0'  THEN 
                R0(31 DOWNTO 0) <= wdata1;
                R0(32) <= '1';
            ELSIF wadr1=X"1" AND R1(32)='0'  THEN 
                R1(31 DOWNTO 0) <= wdata1;
                R1(32) <= '1';
            ELSIF wadr1=X"2" AND R2(32)='0'  THEN
                R2(31 DOWNTO 0) <= wdata1;
                R2(32) <= '1';
            ELSIF wadr1=X"3" AND R3(32)='0'  THEN 
                R3(31 DOWNTO 0) <= wdata1;
                R3(32) <= '1';
            ELSIF wadr1=X"4" AND R4(32)='0'  THEN 
                R4(31 DOWNTO 0) <= wdata1;
                R4(32) <= '1';
            ELSIF wadr1=X"5" AND R5(32)='0'  THEN
                R5(31 DOWNTO 0) <= wdata1;
                R5(32) <= '1';
            ELSIF wadr1=X"6" AND R6(32)='0'  THEN
                R6(31 DOWNTO 0) <= wdata1;
                R6(32) <= '1';
            ELSIF wadr1=X"7" AND R7(32)='0'  THEN
                R7(31 DOWNTO 0) <= wdata1;
                R7(32) <= '1';
            ELSIF wadr1=X"8" AND R8(32)='0'  THEN
                R8(31 DOWNTO 0) <= wdata1;
                R8(32) <= '1';
            ELSIF wadr1=X"9" AND R9(32)='0'  THEN
                R9(31 DOWNTO 0) <= wdata1;
                R9(32) <= '1';
            ELSIF wadr1=X"A" AND R10(32)='0' THEN
                R10(31 DOWNTO 0) <= wdata1;
                R10(32) <= '1';
            ELSIF wadr1=X"B" AND R11(32)='0' THEN
                R11(31 DOWNTO 0) <= wdata1;
                R1(32) <= '1';
            ELSIF wadr1=X"C" AND R12(32)='0' THEN
                R12(31 DOWNTO 0) <= wdata1;
                R12(32) <= '1';
            ELSIF wadr1=X"D" AND R13(32)='0' THEN
                R13(31 DOWNTO 0) <= wdata1;
                R13(32) <= '1';                
            ELSIF wadr1=X"E" AND R14(32)='0' THEN
                R14(31 DOWNTO 0) <= wdata1;
                R14(32) <= '1';
            ELSIF wadr1=X"F" AND R15(32)='0' THEN
                R15(31 DOWNTO 0) <= wdata1;         
                R15(32) <= '1';
            END IF;         
        END IF;
    END IF;

END PROCESS;


END Behavior;

