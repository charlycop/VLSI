-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity Alu is
port (  op1  : in  Std_Logic_Vector(31 downto 0);
        op2  : in  Std_Logic_Vector(31 downto 0);
        cin  : in  Std_Logic;
        cmd  : in  Std_Logic_Vector(1 downto 0);
        res  : out Std_Logic_Vector(31 downto 0);
        cout : out Std_Logic;
        z    : out Std_Logic;
        n    : out Std_Logic;
        v    : out Std_Logic;
        vdd  : in  bit;
        vss  : in  bit);
end Alu;

-- description du composant
ARCHITECTURE archi OF alu IS
signal res_s : signed(32 downto 0);
signal op1_s, op2_s : signed(31 downto 0);


BEGIN

-- on conste sur les signaux
op1_s   <= signed(op1);
op2_s   <= signed(op2);

res_s <= '0'&op1_s+op2_s+(cin & "")            WHEN cmd="00"              -- Addition avec retenue sortante
    else signed(('0'& (op1 AND op2)))          WHEN cmd="01"
    else signed(('0'& (op1 OR  op2)))          WHEN cmd="10"
    else signed(('0'& (op1 XOR op2)))          WHEN cmd="11"
    else (others=>'0');


res   <= std_logic_vector(res_s(31 downto 0));
cout  <= std_logic(res_s(32));
z <= '1' WHEN res_s=0 else '0';
n <= '1' WHEN res_s(31)='1' else '0';
v <= '1' WHEN res_s(32)='1' else '0';

END archi;