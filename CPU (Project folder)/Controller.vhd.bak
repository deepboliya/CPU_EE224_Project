library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is
 port(IR: in std_logic_vector(15 downto 0);
       clk,cflag,zflag: in std_logic;
		 ir_e,cflag_e,zflag_e,pc_e,rf_we3,rf_re1,rf_re2,mem_we,mem_re,t_e:out std_logic;
       mux_rfa1, mux_rfa2,mux_rfa3: out std_logic_vector(1 downto 0); mux_rfd2,mux_alua,mux_tin,mux_mem_out:out std_logic;
		 mux_rfd1,mux_rfd3,tobit: out std_logic_vector( 2 downto 0);
		 mux_alub,mux_aluc,mux_mem_add,mux_tout: out std_logic_vector(1 downto 0));
		 
		 
		 
end entity controller;

architecture hot of controller is

           type state is (S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14);
			
			  shared variable count_13, count_14 : integer := 0;
			  signal present_s,next_s : state ;
			  signal opcode:std_logic_vector(3 downto 0);
			  signal cz: std_logic_vector(1 downto 0);
           signal R: std_logic_vector(7 downto 0)	:="00000000";
			  		  
	begin
			
			opcode(3 downto 0)<= IR(15 downto 12);
			cz(1 downto 0)<= IR(1 downto 0);
			
			clk_process:process(clk, next_s, present_s)
			
				 begin
					 if(clk'event and clk='1') then 
							if(next_s = s13 and present_s = s12) then
								count_13 := count_13 + 1;
							elsif (next_s = s13 and present_s = s14) then
								count_14 := count_14 + 1;
							else 
								null;
							end if;
							if (count_13 = 8 and next_s = s12) then
								count_13 := 0;
								present_s <= s3;
							elsif (count_14 = 8 and next_s = s14) then
								count_14 := 0;
								present_s <= s3;
							else
								present_s <= next_s;
							end if;
					 end if;				 
			end process;
		
	statedefinition:process(IR,present_s,cflag,zflag)

   begin
	   ir_e<='0';
		rf_we3<='0';
		rf_re1<='0';
		rf_re2 <='0';
		t_e<='0';
		mem_re<='0';
		mem_we<='0';
		cflag_e<='0';
		zflag_e<='0';
		pc_e<='0';
		
		mux_rfa1<="00";
		mux_rfa2<="00";
		mux_rfa3<="00";
		mux_rfd1<="000";
		mux_rfd2<='0';
		mux_rfd3<="000";
		mux_mem_add<="00";
		mux_mem_out<='0';
		mux_alua<='0';
		mux_alub<="00";
		mux_aluc<="00";
		mux_tin<='0';
		mux_tout<="00";
		tobit <= "000";
		
--		mux_rfd1="000";
--		rf_a1<="000";
--		rf_a2<="000";
--		rf_a3<="000";
--		rf_d1<="000";
--		rf_d2<="000";
--		rf_d3<="000";
--      mux_rfd3="00";
--		mux_alub="00";
--		mux_aluc="00";
--		mux_memin="00";
--		alu_sel<="0000";
		
		case present_s is
		      
				when s1=>
				   mux_rfa1<="10";
					mux_rfd1<="001";
					rf_re1<='1';
					
					mem_re<='1';
					mux_mem_add<="10";
					mux_mem_out<='1';
				   ir_e<='1';
					
				when s2=>
				   mux_rfa1<="00";
					mux_rfa2<="00";
					mux_rfd1<="011";
					mux_rfd2<='0';
					mux_aluc<="10";
					mux_rfd3<="001";
					mux_rfa3<="00";
					mux_alua<='1';
					mux_alub<="00";
					rf_re1<='1';
					rf_re2<='1';
		         rf_we3<='1';
					cflag_e<=not(IR(13));
					zflag_e<='1';
					
				when s3=>
				   mux_rfa1<="10";
					mux_rfd1<="000";
					rf_re1<='1';
					pc_e<='1';
					mux_rfa3<="11";
					tobit<="111";
					mux_rfd3<="100";
					rf_we3<='1';
					mux_tout<="10";
				   
				when s4=>
			      mux_rfa1<="00";
					mux_rfd1<="011";
					mux_alua<='1';
			      mux_alub<="01";
					rf_re1 <='1';
					mux_aluc<="10";				
					mux_rfd3<="001";
					rf_we3<='1';
					mux_rfa3<="10";
					cflag_e<='1';
					zflag_e<='1';
					
				when s5 =>
				    mux_rfa1<="01";
					 mux_rfa3<="01";
					 mux_rfd1<="011";
					 mux_alua<='1';
					 mux_alub<="01";
					 mux_aluc<="01";
					 mux_mem_add<="00";
					 mux_mem_out<='0';
					 mux_rfd3<="010";
					 zflag_e<='1';
					 rf_re1<='1';
					 rf_we3<='1';
					 mem_re<='1';
				when s6 =>
				    mux_rfa1<="01";
					 mux_rfa2<="01";
					 mux_rfd1<="011";
					 mux_alua<='1';
					 mux_alub<="01";
					 mux_aluc<="01";
					 mux_mem_add<="00";
					 mux_rfd2<='1';
					 rf_re1<='1';
					 rf_re2<='1';
					 mem_we<='1';
					 
				when s7=>
				    mux_rfa3<="01";
					 mux_rfd3<="011";
					 rf_we3<='1';
					
				when s8=>
				    mux_rfa1<="00";
					 mux_rfa2<="00";
					 mux_rfd1<="011";
					 mux_rfd2<='0';
					 mux_alua<='1';
					 mux_alub<="00";
					 mux_aluc<="00";
					 mux_tin<='0';
					 t_e<='1';
					 rf_re1<='1';
					 rf_re2<='1';
				when s9=>
				    mux_rfa3<="01";
					 mux_rfa1<="10";
					 mux_rfd1<="100";
					 mux_rfd3<="000";
					 rf_we3<='1';
					 rf_re1<='1';
				when s10=>
				    mux_rfa1<="01";
					 mux_rfa3<="11";
					 tobit<="111";
					 mux_rfd1<="100";
					 mux_rfd3<="000";
					 rf_we3<='1';
					 rf_re1<='1';
				when s11=>
				    mux_rfa1<="00";
					 mux_rfd1<="010";
					 mux_tin<='1';
					 t_e<='1';
					 rf_re1<='1';
				when s12=>
				   
				    mux_tout<="01";
					 mux_mem_add<="01";
					 mem_re<='1';
					 mux_rfa3<="11";
					 rf_we3<=IR(count_13);
					 mux_mem_out<='0';
					 mux_rfd3<="010";
					 tobit<= std_logic_vector(to_unsigned(count_13,3));
				when s13=>
				    mux_tout<="00";
					 mux_alua<='0';
					 mux_alub<="10";
					 mux_aluc<="00";
					 mux_tin<='0';
					 t_e<='1';
				when s14=>
				    mux_tout<="01";
					 mux_mem_add<="01";
					 mux_rfa2<="11";
					 mux_rfd2<='1';
					 mem_we<=IR(count_14);
					 rf_re2<='1';
					 tobit<= std_logic_vector(to_unsigned(count_14,3));
				when others=>
                NULL;
					 
					end case; 
				
					
					
				end process;   
					
					
				   
					
				  
				  
     	
	next_state : process(present_s, opcode, cz, zflag, cflag)
		 
	begin
				 

		next_s <= present_s;		
		case present_s is
			
			when S1 =>
				if opcode = "0000" or opcode= "0010"   then                  --ADD/ADC/ADZ/NDU/NDC/NDZ or (cz(1) and cflag) or (cz(0) and zflag)
					if cz="00" or ( cz="10" and cflag='1') or (cz="01" and zflag='1')   then
						next_s <= S2;
					else
						next_s <= S3;
					end if;
				elsif opcode = "0001" then --ADI
					next_s <= S4;					
				elsif opcode = "0011" then --LHI
					next_s <= S7;
				elsif opcode = "0100" then --LW
					next_s <= S5;				
				elsif opcode = "0101" then --SW
					next_s <= S6;					
				elsif opcode = "0110" then --LM
					next_s <= S11;							
				elsif opcode = "0111" then --SM
					next_s <= S11;
				elsif opcode = "1100" then --BEQ
					next_s <= S8;
				elsif opcode = "1000" then --JAL
					next_s <= S9;
				elsif opcode = "1001" then --JLR
					next_s <= S9;			
				else
					next_s <= S1;
				end if;
			when S2=>
				next_s <= S3;
			when S3 =>
			   next_s <= S1;				
			when S4 =>
				next_s <= S3;
			when S5 =>
				next_s <= S3;
			when S6 =>
				next_s <= S3;
			when S7 =>
				next_s <= S3;
			when S8 =>
				next_s <= S3;
				
				
			when S9 =>
			   if(opcode ="1000") then --JAL
				next_s <= S3;
				else
				next_s <= S10;      --JLR
				end if;
				
			when S10 => --JLR
				next_s <= S1;
				
				
			when S11 =>
			   if(opcode="0110") then
				next_s <= S12;
				else
				next_s <= S14;
				end if;
			when S12 => 
			   next_S <= S13;
			when S13 =>
				if(opcode= "0110") then
			   next_s <= S12;
				else
				next_s <= S14;
				end if;
				
			when S14 =>
		   next_s<= S13;
				
			
		
			when others =>
				next_s <= S1;
			end case;
	end process;
	end architecture hot ;



 
