-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity TestBenchShifter is
end TestBenchShifter;

architecture simu of TestBenchShifter is

    signal shift_lsl : Std_Logic;
    signal shift_lsr :  Std_Logic;
    signal shift_asr :  Std_Logic;
    signal shift_ror :  Std_Logic;
    signal shift_rrx :  Std_Logic;
    signal shift_val :  Std_Logic_Vector(4 downto 0);
    signal din       :  Std_Logic_Vector(31 downto 0);
    signal cin       :  Std_Logic;
    signal dout      :  Std_Logic_Vector(31 downto 0);
    signal cout      :  Std_Logic;
    -- global interface
    signal vdd       :   bit;
    signal vss       :   bit;

begin

    L0: entity work.Shifter
        port map (shift_lsl, shift_lsr, shift_asr, shift_ror, shift_rrx, shift_val, din, cin, dout, cout, vdd, vss);
	cin <=  '1';
    shift_lsl <= '1';
	shift_lsr <= '0';
	shift_asr <= '0';
	shift_ror <= '0';
	shift_rrx <= '0';
	shift_val <= "00010";
	din       <=  X"00000001", X"00000002" after 100 ns;


end simu;
