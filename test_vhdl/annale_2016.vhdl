-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity Annale_2016 is

port(    ope1   : in  Std_Logic_Vector(31 downto 0);
         ope2   : in  Std_Logic_Vector(31 downto 0);
         start  : in  Std_Logic; 
	 ck     : in std_logic;
	 res    : out std_logic_vector(31 downto 0);
	 valid  : out std_logic);

end Annale_2016;


  ARCHITECTURE archi OF Annale_2016 IS


signal res_s :unsigned(31 downto 0):=X"00000000";
--signal ope1_s,ope2_s :unsigned(31 downto 0);--ope1 qui correspond a celui qu'on va decaler 
begin


process(start,ope1,ope2)
variable ope1_s,ope2_s : unsigned(31 DOWNTO 0);
variable i:integer:=0;
begin

ope2_s:=unsigned(ope2);
ope1_s:=unsigned(ope1);

if(ope1/=X"00000000" and ope2/=X"00000000" and start='1') then 
	i:=0;
  while (ope2_s>X"00000000" and i<31) LOOP
	
	if(ope2_s(i)='1') then 
	res_s<=res_s + ope1_s;
	ope2_s(i):='0';
	end if;
	--ope2_s:='0'&ope2_s(31 downto 1);
       ope1_s:=ope1_s(30 downto 0)&'0';
      i:=i+1;

  END LOOP;

end if;


end process;

res<=std_logic_vector(res_s);


end archi;


