-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity Shifter is
  port(
    shift_lsl : in  Std_Logic;
    shift_lsr : in  Std_Logic;
    shift_asr : in  Std_Logic;
    shift_ror : in  Std_Logic;
    shift_rrx : in  Std_Logic;
    shift_val : in  Std_Logic_Vector(4 downto 0);
    din       : in  Std_Logic_Vector(31 downto 0);
    cin       : in  Std_Logic;
    dout      : out Std_Logic_Vector(31 downto 0);
    cout      : out Std_Logic;
    -- global interface
    vdd       : in  bit;
    vss       : in  bit );
end Shifter;

-- description du composant
ARCHITECTURE archi OF Shifter IS
--signal res_s : signed(31 downto 0); -- nécessaire pour la version avec shifts
signal decalTampon_s : Std_Logic_Vector(31 downto 0);
signal shiftVal_s : integer;

BEGIN

-- On met a jour les signaux avec les bonnes valeurs
shiftVal_s    <= to_integer(signed(shift_val));
decalTampon_s  <= X"FFFFFFFF" WHEN (din(31)='1' AND shift_asr='1') else (others => '0');

-- version sans signal --
dout <=      (din(31-shiftVal_s downto 0)         & decalTampon_s(shiftVal_s-1 downto 0))  WHEN shift_lsl='1'
	    else (decalTampon_s(shiftVal_s-1 downto 0)& din(31 downto  shiftVal_s ))           WHEN (shift_lsr='1' OR shift_asr='1')
	    else (din(shiftVal_s-1 downto 0)          & din(31 downto  shiftVal_s ))           WHEN shift_ror='1'
	    else (cin & din(31 downto 1))                 									     WHEN shift_rrx='1'
	    else (others=>'0');

-- VERSION CONVENTIONNELLE --
--res_s <=      signed(din(31-shiftVal_s downto 0)         & decalTampon_s(shiftVal_s-1 downto 0))  WHEN shift_lsl='1'
--	   	 else signed(decalTampon_s(shiftVal_s-1 downto 0)& din(31 downto  shiftVal_s ))           WHEN (shift_lsr='1' or shift_asr='1')
--		 else signed(din(shiftVal_s-1 downto 0)          & din(31 downto  shiftVal_s ))           WHEN shift_ror='1'
--		 else signed (cin & din(31 downto 1))                 									    WHEN shift_rrx='1'
--		 else 		(others=>'0');

-- VERSION AVEC SHIFTS --
--res_s <=             SHIFT_LEFT  (signed(din),   shiftVal_s)        WHEN shift_lsl='1'
--	   	 else signed(SHIFT_RIGHT (unsigned(din), shiftVal_s))       WHEN shift_lsr='1'
--		 else        SHIFT_RIGHT (signed(din),   shiftVal_s)        WHEN shift_asr='1'
--		 else        ROTATE_RIGHT(signed(din),   shiftVal_s)        WHEN shift_ror='1'
--		 else		 signed (cin & din(31 downto 1))                 WHEN shift_rrx='1'
--		 else 		(others=>'0');

cout <= din(31-shiftVal_s) 	WHEN  shift_lsl='1'
		else din(shiftVal_s)   WHEN (shift_lsr='1' OR shift_asr='1' OR shift_ror='1')
		else din(0)  			WHEN shift_rrx='1'
		else '0';

--dout <= std_logic_vector(res_s); -- nécessaire sur la version avec shift


END archi;
