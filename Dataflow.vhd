library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Dataflow is
    port (
			IR_E,C_FLAG_E,Z_FLAG_E,PC_E,RF_WE3,RF_RE1,MEM_WE,MEM_RE,T_E,RF_RE2, MUX_RF_D2, MUX_ALU_A, MUX_T_IN, MUX_MEM_OUT: in std_logic;
			MUX_RF_D1, MUX_RF_D3 : in std_logic_vector(2 downto 0);
			MUX_ALU_B,MUX_ALU_C, MUX_MEM_IN, MUX_RF_A1, MUX_RF_A2, MUX_T_OUT, MUX_RF_A3 : in std_logic_vector(1 downto 0);
			CLK : in std_logic;
			Carry_OUT, Zero_OUT : out std_logic;
			IR_OUT : out std_logic_vector(15 downto 0);
			ToBit : in std_logic_vector(2 downto 0)
    );
end entity Dataflow;

architecture Dataflow_Arch of Dataflow is
   component Register_1 is
    port (
        DIN : in std_logic;
		  DOUT : out std_logic;
        CLK, WE : in std_logic
    );
	end component;

    component Register_16 is
    port (
        DIN : in std_logic_vector(15 downto 0);
		  DOUT : out std_logic_vector(15 downto 0);
        CLK, WE : in std_logic
    );
	end component;

    component Register_File is
        port( RF_A1, RF_A2, RF_A3 : in std_logic_vector(2 downto 0); RF_D1, RF_D2 : out std_logic_vector(15 downto 0); 
                RF_D3 : in std_logic_vector(15 downto 0) ; RF_RE1, RF_RE2, RF_WR3: in std_logic; clk : in std_logic);  
    end component;

    component memory is
		 port(
			WE,RE,clk: in std_logic;
			address,Din: in std_logic_vector(15 downto 0);
			Dout: out std_logic_vector(15 downto 0)
			);
	 end component;

    -- muxes
	 component MUX_1_TO_3 is
		 port(
			  i: in std_logic_vector(15 downto 0);
			  d0,d1,d2: out std_logic_vector(15 downto 0);
			  S: in std_logic_vector(1 downto 0)
				);
	end component;
	
	component MUX_1_TO_2 is
    port(
        i: in std_logic_vector(15 downto 0);
        d0,d1: out std_logic_vector(15 downto 0);
        S: in std_logic
         );
	end component MUX_1_TO_2;
	
	component MUX_1_TO_5 is
    port(
        i: in std_logic_vector(15 downto 0);
        D0,D1,D2,D3,D4: out std_logic_vector(15 downto 0);
        S: in std_logic_vector(2 downto 0)
         );
	end component MUX_1_TO_5;
	
	component MUX_2_to_1 is
    port(
        A0: in std_logic_vector(15 downto 0);
        A1: in std_logic_vector(15 downto 0);
        S: in std_logic;
        Op: out std_logic_vector(15 downto 0)
    );
	end component MUX_2_to_1;
	
	component MUX_3_to_1 is
    port(
        A0,A1,A2: in std_logic_vector(15 downto 0);
        
        S: in std_logic_vector(1 downto 0);
        Op: out std_logic_vector(15 downto 0)
    );
	end component MUX_3_to_1;
	
	component MUX_4_to_1 is
    
    port (
        A0: in std_logic_vector(2 downto 0);
        A1: in std_logic_vector(2 downto 0);
		  A2: in std_logic_vector(2 downto 0);
		  A3: in std_logic_vector(2 downto 0);
        S: in std_logic_vector(1 downto 0);
        Op: out std_logic_vector(2 downto 0)
    ) ;
	end component MUX_4_to_1;
	
	component MUX_5_to_1 is
    port(
        A0,A1,A2,A3,A4: in std_logic_vector(15 downto 0);
        
        S: in std_logic_vector(2 downto 0);
        Op: out std_logic_vector(15 downto 0)
    );
	end component MUX_5_to_1;

    component ALU is
        port (ALU_A , ALU_B : in std_logic_vector(15 downto 0); ALU_S : in std_logic_vector(3 downto 0); ALU_C : out std_logic_vector(15 downto 0); 
        ALU_Carry, ALU_Zero : out std_logic);
    end component;

    component Incrementer is
		port (
			PC_in,  IR, Z : in std_logic_vector( 15 downto 0);
            WE : in std_logic;
            clk : in std_logic;
            PC_out : out std_logic_vector(15 downto 0)
		);
	end component;
    
    -- sign extenders
	 
	component sign_ext_6 is
		port( input : in std_logic_vector (5 downto 0);
		SE_out : out std_logic_vector ( 15 downto 0)

		);

	end component sign_ext_6;

    -- bit shifters
	 component shifter_7bits is
		 port(
			  input: in std_logic_vector(8 downto 0);
			  shift_out: out std_logic_vector(15 downto 0)
		 );
	 
	 end component shifter_7bits;
	 
	 signal mem_op, IR_Op, rfd1_op, rfd2_op, d1_op0, d1_op1, d1_op2, d1_op3, d1_op4, 
				 d2_op0, d2_op1, SE6_op, S7_op, PC_out, mux_rfd3_op, mux_alua_op, mux_alub_op, aluc_op, aluc0, aluc1, aluc2, Tin, Top, Top0, Top1, Top2, mem_add, mux_mem_op0, mux_mem_op1 : std_logic_vector(15 downto 0) := (others => '0');
	 signal mux_rfa1, mux_rfa2, mux_rfa3 : std_logic_vector(2 downto 0); 
	 signal Zin, Cin : std_logic;

begin

    --IR
    IR : Register_16 port map( DIN => mux_mem_op0, DOUT => IR_Op, CLK => CLK, WE => IR_E );
	 
	 IR_OUT<=IR_Op;
	 
	 --MUX_RF_A1
	 muxrfa1 : MUX_4_to_1 port map(A0 => IR_Op(11 downto 9), A1 => IR_Op(8 downto 6), A2 => "111", A3 => ToBit, S => MUX_RF_A1, Op => mux_rfa1 );
	 
	 --MUX_RF_A2
	 muxrfa2 : MUX_4_to_1 port map(A0 => IR_Op(8 downto 6), A1 => IR_Op(11 downto 9), A2 => "111", A3 => ToBit, S => MUX_RF_A2, Op => mux_rfa2 );
	 
	 --MUX_RF_A3
	 muxrfa3 : MUX_4_to_1 port map(A0 => "111", A1 => IR_Op(11 downto 9), A2 => IR_Op(8 downto 6), A3 => ToBit, S => MUX_RF_A3, Op => mux_rfa3 );
	 
	 --7 bit Shifter
	 SH7 : shifter_7bits port map(input => IR_Op(8 downto 0), shift_out => S7_op );
	 
	 --Sign Extender6
	 SE6 : sign_ext_6 port map(input => IR_Op(5 downto 0), SE_out => SE6_op );
	 
	 --To_Bit
	 
	 --MUX_RF_D3
	 mux_rfd3: MUX_5_to_1 port map(A0 => d1_op4, A1 => aluc2, A2 => mux_mem_op0, A3 => S7_op, A4 => PC_out, S => MUX_RF_D3, Op => mux_rfd3_op);
	 
	 --Register File
	 RegisterFile : Register_File port map(RF_A1 => mux_rfa1, RF_A2 => mux_rfa2, RF_A3 => mux_rfa3, RF_D1 => rfd1_op, RF_D2 => rfd2_op, 
			RF_D3 => mux_rfd3_op, RF_RE1 => RF_RE1, RF_RE2 => RF_RE2, RF_WR3 => RF_WE3, clk => CLK);
			
	 --MUX_RF_D1
	 mux_rfd1 : MUX_1_TO_5 port map(i => rfd1_op, D0 => d1_op0, D1 => d1_op1, D2 => d1_op2, D3 => d1_op3, D4 => d1_op4, S => MUX_RF_D1 );
	 
	 --MUX_RF_D2
	 mux_rfd2 : MUX_1_TO_2 port map(i => rfd2_op, d0 => d2_op0, d1 => d2_op1, S => MUX_RF_D2);
	 
	 --MUX_ALUA
	 mux_alua : MUX_2_TO_1 port map(A0 => Top0, A1 => d1_op3, S => MUX_ALU_A, Op => mux_alua_op);
	 
	 --MUX_ALUB
	 mux_alub : MUX_3_TO_1 port map(A0 => d2_op0, A1 => SE6_op, A2 => "0000000000000001", S => MUX_ALU_B, Op => mux_alub_op);
	 
	 --ALU
	 alu_1 : ALU port map(ALU_A => mux_alua_op, ALU_B => mux_alub_op, ALU_S => IR_op(15 downto 12), ALU_C => aluc_op, ALU_Carry => Cin, ALU_Zero => Zin);
	 
	 --Carry
	 C : Register_1 port map(DIN => Cin, DOUT => Carry_OUT, CLK => CLK, WE => C_FLAG_E);
	 
	 --Zero
	 Z : Register_1 port map(DIN => Zin, DOUT => Zero_OUT, CLK => CLK, WE => Z_FLAG_E);
	 
	 --MUX_ALU_C
	 mux_aluc : MUX_1_TO_3 port map(i => aluc_op, d0 => aluc0,d1 => aluc1,d2 => aluc2, S => MUX_ALU_C );
	 
	 --MUX_T_IN
	 mux_tin : MUX_2_TO_1 port map(A0 => aluc0, A1 => d1_op2, S => MUX_T_IN, Op => Tin );
	 
	 --MUX_T_OUT
	 mux_tout : MUX_1_TO_3 port map(i => Top, D0 => Top0, D1 => Top1, D2 => Top2, S => MUX_T_OUT);
	 
	 --T Register
	 T : Register_16 port map(DIN => Tin, DOUT => Top, CLK => CLK, WE => T_E);
	 
	 --MUX_MEM_IN
	 mux_memin : MUX_3_TO_1 port map(A0 => aluc1, A1 => Top1, A2 => d1_op1, S => MUX_MEM_IN, Op => mem_add);
	 
	 --MUX_MEM_OUT
	 mux_memout : MUX_1_TO_2 port map(i => mem_op, D0 => mux_mem_op0, D1 => mux_mem_op1, S => MUX_MEM_OUT);
	 
	 --Incrementer
	 INC : Incrementer port map(PC_in => d1_op0, IR => IR_Op, Z => Top2, WE => PC_E, clk => CLK, PC_out => PC_out);
	 
	 --Memory 
	 mem : memory port map(WE => MEM_WE, RE => MEM_RE, clk => CLK, address => mem_add, Din => d2_op1, Dout => mem_op);
	 
	 
end architecture Dataflow_Arch;