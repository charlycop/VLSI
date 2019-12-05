reg_rd1 <= R0 WHEN radr1 = "0000"
      else R1 WHEN radr1 = "0001"
      else R2 WHEN radr1 = "0010"
      else R3 WHEN radr1 = "0011"
      else R4 WHEN radr1 = "0100"
      else R5 WHEN radr1 = "0101"
      else R6 WHEN radr1 = "0110"
      else R7 WHEN  radr1 = "0111"
      else R8 WHEN radr1 = "1000"
        radr1 = "1001"

WITH radr1 SELECT
  reg_rd1 <=  R0  WHEN "0000",
              R1  WHEN "0001",
              R2  WHEN "0010",
              R3  WHEN "0011",
              R4  WHEN "0100",
              R5  WHEN "0101",
              R6  WHEN "0110",
              R7  WHEN "0111",
              R8  WHEN "1000",
              R9  WHEN "1001",
              R10 WHEN "1010",
              R11 WHEN "1011",
              R12 WHEN "1100",
              R13 WHEN "1101",
              R14 WHEN "1110",
              R15 WHEN "1111",
              (others => '0') WHEN OTHERS;

reg_v1 <= '1' 

WITH radr2 SELECT
  reg_rd2 <=  R0  WHEN "0000",
              R1  WHEN "0001",
              R2  WHEN "0010",
              R3  WHEN "0011",
              R4  WHEN "0100",
              R5  WHEN "0101",
              R6  WHEN "0110",
              R7  WHEN "0111",
              R8  WHEN "1000",
              R9  WHEN "1001",
              R10 WHEN "1010",
              R11 WHEN "1011",
              R12 WHEN "1100",
              R13 WHEN "1101",
              R14 WHEN "1110",
              R15 WHEN "1111",
              (others => '0') WHEN OTHERS;

WITH radr3 SELECT
  reg_rd3 <=  R0  WHEN "0000",
              R1  WHEN "0001",
              R2  WHEN "0010",
              R3  WHEN "0011",
              R4  WHEN "0100",
              R5  WHEN "0101",
              R6  WHEN "0110",
              R7  WHEN "0111",
              R8  WHEN "1000",
              R9  WHEN "1001",
              R10 WHEN "1010",
              R11 WHEN "1011",
              R12 WHEN "1100",
              R13 WHEN "1101",
              R14 WHEN "1110",
              R15 WHEN "1111",
              (others => '0') WHEN OTHERS;

---WRITE---
R0  <= wdata1 WHEN inval1='1' AND inval_adr1 = X"0" AND wadr1=inval_adr1 else R0;
R1  <= wdata1 WHEN inval1='1' AND inval_adr1 = X"1" AND wadr1=inval_adr1 else R1;
R2  <= wdata1 WHEN inval1='1' AND inval_adr1 = X"2" AND wadr1=inval_adr1 else R2;
R3  <= wdata1 WHEN inval1='1' AND inval_adr1 = X"3" AND wadr1=inval_adr1 else R3;
R4  <= wdata1 WHEN inval1='1' AND inval_adr1 = X"4" AND wadr1=inval_adr1 else R4;
R5  <= wdata1 WHEN inval1='1' AND inval_adr1 = X"5" AND wadr1=inval_adr1 else R5;
R6  <= wdata1 WHEN inval1='1' AND inval_adr1 = X"6" AND wadr1=inval_adr1 else R6;
R7  <= wdata1 WHEN inval1='1' AND inval_adr1 = X"7" AND wadr1=inval_adr1 else R7;
R8  <= wdata1 WHEN inval1='1' AND inval_adr1 = X"8" AND wadr1=inval_adr1 else R8;
R9  <= wdata1 WHEN inval1='1' AND inval_adr1 = X"9" AND wadr1=inval_adr1 else R9;
R10 <= wdata1 WHEN inval1='1' AND inval_adr1 = X"A" AND wadr1=inval_adr1 else R10;
R11 <= wdata1 WHEN inval1='1' AND inval_adr1 = X"B" AND wadr1=inval_adr1 else R11;
R12 <= wdata1 WHEN inval1='1' AND inval_adr1 = X"C" AND wadr1=inval_adr1 else R12;
R13 <= wdata1 WHEN inval1='1' AND inval_adr1 = X"D" AND wadr1=inval_adr1 else R13;
R14 <= wdata1 WHEN inval1='1' AND inval_adr1 = X"E" AND wadr1=inval_adr1 else R14;
R15 <= wdata1 WHEN inval1='1' AND inval_adr1 = X"F" AND wadr1=inval_adr1 else R15;

process(wadr1)

begin
  
  if inval1='1' and then
    CASE wadr1 IS
      WHEN ("0000") => wdata1 <= R0;
      WHEN "0001" AND inval_adr1=wadr1 => wdata1 <= R1;
      WHEN "0010" AND inval_adr1=wadr1 => wdata1 <= R2;
      WHEN "0011" AND inval_adr1=wadr1 => wdata1 <= R3;
      WHEN "0100" AND inval_adr1=wadr1 => wdata1 <= R4;
      WHEN "0101" AND inval_adr1=wadr1 => wdata1 <= R5;
      WHEN "0110" AND inval_adr1=wadr1 => wdata1 <= R6;
      WHEN "0111" AND inval_adr1=wadr1 => wdata1 <= R7;
      WHEN "1000" AND inval_adr1=wadr1 => wdata1 <= R8;
      WHEN "1001" AND inval_adr1=wadr1 => wdata1 <= R9;
      WHEN "1010" AND inval_adr1=wadr1 => wdata1 <= R10;
      WHEN "1011" AND inval_adr1=wadr1 => wdata1 <= R11;
      WHEN "1100" AND inval_adr1=wadr1 => wdata1 <= R12;
      WHEN "1101" AND inval_adr1=wadr1 => wdata1 <= R13;
      WHEN "1110" AND inval_adr1=wadr1 => wdata1 <= R14;
      WHEN "1111" AND inval_adr1=wadr1 => wdata1 <= R15;
      WHEN OTHERS => reg_rd1 <= (others=>'0');
    end case;
  end if;
  

end process;
