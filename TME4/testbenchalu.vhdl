-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity TestBenchAlu is
end TestBenchAlu;

architecture simu of TestBenchAlu is
    signal    op1  :  Std_Logic_Vector(31 downto 0);
    signal    op2  :  Std_Logic_Vector(31 downto 0);
    signal    cin  :  Std_Logic;
    signal    cmd  :  Std_Logic_Vector(1 downto 0);
    signal    res  :  Std_Logic_Vector(31 downto 0);
    signal    cout :  Std_Logic;
    signal    z    :  Std_Logic;
    signal    n    :  Std_Logic;
    signal    v    :  Std_Logic;
    signal    vdd  :  bit;
    signal    vss  :  bit;
begin

    L0: entity work.Alu
        port map (op1, op2, cin, cmd, res, cout, z, n, v, vdd, vss);

    op1      <= (others=>'0'), "11111111111111111111111111110100" after 100 ns;
    op2      <= "00000000000000000000000000000001";
    cin      <= '0';
    cmd      <= (others=>'0'), "01" after 150 ns, "10" after 200 ns, "11" after 250 ns;

end simu;