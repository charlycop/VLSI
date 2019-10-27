-- declaration des bibliothèques STD et WORK
-- sont connues par défaut

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity TestBenchExec is
end TestBenchExec;

architecture simu of TestBenchExec is
    		signal dec2exe_empty	:  Std_logic;
			signal exe_pop			:  Std_logic;

	-- Decode interface operands
			signal dec_op1			:  Std_Logic_Vector(31 downto 0); -- first alu input
			signal dec_op2			:  Std_Logic_Vector(31 downto 0); -- shifter input
			signal dec_exe_dest	    :  Std_Logic_Vector(3 downto 0); -- Rd destination
			signal dec_exe_wb		:  Std_Logic; -- Rd destination write back
			signal dec_flag_wb		:  Std_Logic; -- CSPR modifiy

	-- Decode to mem interface 
			signal dec_mem_data	:  Std_Logic_Vector(31 downto 0); -- data to MEM W
			signal dec_mem_dest	:  Std_Logic_Vector(3 downto 0); -- Destination MEM R
			signal dec_pre_index 	:  Std_logic;

			signal dec_mem_lw		:  Std_Logic;
			signal dec_mem_lb		:  Std_Logic;
			signal dec_mem_sw		:  Std_Logic;
			signal dec_mem_sb		:  Std_Logic;

	-- Shifter command
			signal dec_shift_lsl	:  Std_Logic;
			signal dec_shift_lsr	:  Std_Logic;
			signal dec_shift_asr	:  Std_Logic;
			signal dec_shift_ror	:  Std_Logic;
			signal dec_shift_rrx	:  Std_Logic;
			signal dec_shift_val	:  Std_Logic_Vector(4 downto 0);
			signal dec_cy			:  Std_Logic;

	-- Alu operand selection
			signal dec_comp_op1	:  Std_Logic;
			signal dec_comp_op2	:  Std_Logic;
			signal dec_alu_cy 		:  Std_Logic;

	-- Alu command
			signal dec_alu_cmd		:  Std_Logic_Vector(1 downto 0);

	-- Exe bypass to decod
			signal exe_res			:  Std_Logic_Vector(31 downto 0);

			signal exe_c			:  Std_Logic;
			signal exe_v			:  Std_Logic;
			signal exe_n			:  Std_Logic;
			signal exe_z			:  Std_Logic;

			signal exe_dest		    :  Std_Logic_Vector(3 downto 0); -- Rd destination
			signal exe_wb			:  Std_Logic; -- Rd destination write back
			signal exe_flag_wb		:  Std_Logic; -- CSPR modifiy

	-- Mem interface
			signal exe_mem_adr		:  Std_Logic_Vector(31 downto 0); -- Alu res register
			signal exe_mem_data		:  Std_Logic_Vector(31 downto 0);
			signal exe_mem_dest		:  Std_Logic_Vector(3 downto 0);

			signal exe_mem_lw		:  Std_Logic;
			signal exe_mem_lb		:  Std_Logic;
			signal exe_mem_sw		:  Std_Logic;
			signal exe_mem_sb		:  Std_Logic;

			signal exe2mem_empty	:  Std_logic;
			signal mem_pop			:  Std_logic;

	-- global interface
			signal ck				:  Std_logic;
			signal reset_n			:  Std_logic;
			signal vdd				:  bit;
			signal vss				:  bit;

begin

    EXec: entity work.EXec
        port map (dec2exe_empty, exe_pop, dec_op1, dec_op2, dec_exe_dest, dec_exe_wb, dec_flag_wb, dec_mem_data, dec_mem_dest, dec_pre_index, dec_mem_lw, dec_mem_lb, dec_mem_sw, dec_mem_sb, dec_shift_lsl, dec_shift_lsr, dec_shift_asr, dec_shift_ror, dec_shift_rrx, dec_shift_val, dec_cy, dec_comp_op1, dec_comp_op2, dec_alu_cy, dec_alu_cmd, exe_res, exe_c, exe_v, exe_n, exe_z, exe_dest, exe_wb, exe_flag_wb, exe_mem_adr, exe_mem_data, exe_mem_dest, exe_mem_lw, exe_mem_lb, exe_mem_sw, exe_mem_sb, exe2mem_empty, mem_pop, ck, reset_n, vdd, vss);

	dec_op1      <= (others=>'0'), "00111111111111111111111111111111" after 100 ns, "11111111111111111111111111111111" after 200 ns;	
    dec_op2      <= (others=>'0');
   -- op2      <= (others=>'0'), "00000000000000000000000000000000" after 100 ns, "10000000000000000000000000000001" after 200 ns; 
    --cin      <= '1';
    --cmd      <= (others=>'0');--, "01" after 150 ns, "10" after 200 ns, "11" after 250 ns, "00" after 300 ns;

end simu;
