library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;

entity CPU is
    port(clk : in std_logic);
end CPU;

architecture main of CPU is

	component Dataflow is
		 port(IR_E,C_FLAG_E,Z_FLAG_E,PC_E,RF_WE3,RF_RE1,MEM_WE,MEM_RE,T_E,RF_RE2, MUX_RF_D2, MUX_ALU_A, MUX_T_IN, MUX_MEM_OUT: in std_logic;
			MUX_RF_D1, MUX_RF_D3 : in std_logic_vector(2 downto 0);
			MUX_ALU_B,MUX_ALU_C, MUX_MEM_IN, MUX_RF_A1, MUX_RF_A2, MUX_T_OUT, MUX_RF_A3 : in std_logic_vector(1 downto 0);
			CLK : in std_logic;
			Carry_OUT, Zero_OUT : out std_logic;
			IR_OUT : out std_logic_vector(15 downto 0);
			ToBit : in std_logic_vector(2 downto 0));
	end component;
	
	component controller is
		port(IR: in std_logic_vector(15 downto 0);
       clk,cflag,zflag: in std_logic;
		 ir_e,cflag_e,zflag_e,pc_e,rf_we3,rf_re1,rf_re2,mem_we,mem_re,t_e,mux_rfd2,mux_alua,mux_tin,mux_mem_out:out std_logic;
       mux_rfa1, mux_rfa2,mux_rfa3,mux_alub,mux_aluc,mux_mem_add,mux_tout: out std_logic_vector(1 downto 0); 
		 mux_rfd1,mux_rfd3,tobit: out std_logic_vector( 2 downto 0));
	end component;
	
	signal IR_s : std_logic_vector(15 downto 0);
	signal cflag_s, zflag_s ,mux_rfd2s,mux_aluas,mux_tins,mem_outs: std_logic;
	signal IR_es,cflag_es,zflag_es,pc_es,rf_we3s,rf_re1s,rf_re2s,mem_wes,mem_res,t_es : std_logic;
	signal  mux_rfa1s, mux_rfa2s,mux_rfa3s: std_logic_vector(1 downto 0);
	signal mux_alubs,mux_alucs,mem_adds,mux_touts: std_logic_vector(1 downto 0);
   signal  mux_rfd1s,mux_rfd3s,tobits: std_logic_vector( 2 downto 0);
   signal carry_outs,zero_outs: std_logic;
begin

--Controller
Ctrl: controller port map (
								clk=>clk,
								IR=>IR_s,
								cflag=>cflag_s, 
								zflag=>zflag_s, 
								ir_e=>IR_es,
								cflag_e=>cflag_es,
								zflag_e=>zflag_es,
								pc_e=>pc_es,
								rf_we3=>rf_we3s,
								rf_re1=>rf_re1s,
								rf_re2=>rf_re2s,
								mem_we=>mem_wes,
								mem_re=>mem_res,
								t_e=>t_es,
								mux_rfd2=>mux_rfd2s,
								mux_alua=>mux_aluas,
								mux_tin=>mux_tins,
								mux_mem_out=>mem_outs,
								mux_rfa1=>mux_rfa1s,
								mux_rfa2=>mux_rfa2s,
								mux_rfa3=>mux_rfa3s,
								mux_alub=>mux_alubs,
								mux_aluc=>mux_alucs,
								mux_mem_add=>mem_adds,
								mux_tout=>mux_touts,
								mux_rfd1=>mux_rfd1s,
								mux_rfd3=>mux_rfd3s,
								tobit=>tobits
								);

--Datapath
DP: Dataflow port map (IR_E=>IR_es,
                       C_FLAG_E=>cflag_s,
                       Z_FLAG_E=>zflag_s,
                       PC_E=>pc_es,
                       RF_WE3=>rf_we3s,
                       RF_RE1=>rf_re1s,
                       MEM_WE=>mem_wes,
                       MEM_RE=>mem_res,
                       T_E=>t_es,
                       RF_RE2=>rf_re2s,
                       MUX_RF_D2=>mux_rfd2s,
                       MUX_ALU_A=>mux_aluas,
                       MUX_T_IN=>mux_tins,
                       MUX_MEM_OUT=>mem_outs,
							  MUX_RF_D1=>mux_rfd1s,
							  MUX_RF_D3=>mux_rfd3s,
							  MUX_ALU_B=>mux_alubs,
							  MUX_ALU_C=>mux_alucs,
							  MUX_MEM_IN=>mem_adds,
							  MUX_RF_A1=>mux_rfa1s,
							  MUX_RF_A2=>mux_rfa2s,
							  MUX_T_OUT=>mux_touts,
							  MUX_RF_A3=>mux_rfa3s,
							  CLK=>clk,
							  Carry_OUT=>carry_outs,
							  Zero_OUT=>zero_outs,
							  IR_OUT=>IR_s,
							  ToBit =>tobits
							);
							
end main;
