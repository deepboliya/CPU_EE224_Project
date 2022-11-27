library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
	port (ALU_A , ALU_B : in std_logic_vector(15 downto 0); ALU_S : in std_logic_vector(3 downto 0); ALU_C : out std_logic_vector(15 downto 0); 
			ALU_Carry, ALU_Zero : out std_logic);
end entity ALU;

architecture Structure_ALU of ALU is

	function NAND_16(A : in std_logic_vector(15 downto 0);
						B : in std_logic_vector(15 downto 0))
	return std_logic_vector is
		variable result : std_logic_vector(15 downto 0) := (others => '0');
	begin
			L1 : for i in 0 to 15 loop
				result(i) := A(i) nand B(i);
			end loop L1;
		return result;
	end function NAND_16;
--------------------------------------------------------------------------------------------------------------------------------	
	function ADD_16(A : in std_logic_vector(15 downto 0); B : in std_logic_vector(15 downto 0)) return std_logic_vector is
		variable C : std_logic_vector(16 downto 0) := (others => '0');
		variable S : std_logic_vector(15 downto 0);
	begin
		Loop1: for i in 0 to 15 loop
			S(i) := A(i) xor B(i) xor C(i);
			C(i+1) := ( A(i) and C(i) ) or ( ( A(i) xor C(i) ) and B(i) );
		end loop Loop1;
		return S;
	end function ADD_16;
---------------------------------------------------------------------------------------------------------------------------------	
	function Carry_16(A : in std_logic_vector(15 downto 0); B : in std_logic_vector(15 downto 0)) return std_logic is
		variable C : std_logic_vector(16 downto 0) := (others => '0');
--		variable S : std_logic_vector(15 downto 0);
	begin
		Loop1: for i in 0 to 15 loop
--			S(i) := A(i) xor B(i) xor C(i);
			C(i+1) := ( A(i) and C(i) ) or ( ( A(i) xor C(i) ) and B(i) );
		end loop Loop1;
		return C(16);
	end function Carry_16;
---------------------------------------------------------------------------------------------------------------------------------
	function XOR_16(A : in std_logic_vector(15 downto 0);
						B : in std_logic_vector(15 downto 0))
	return std_logic_vector is
		variable result : std_logic_vector(15 downto 0) := (others => '0');
	begin
			L1 : for i in 0 to 15 loop
				result(i) := A(i) xor B(i);
			end loop L1;
		return result;
	end function XOR_16;
---------------------------------------------------------------------------------------------------------------------------------
begin
	ALU_Process : process(ALU_A, ALU_B, ALU_S)
	begin
		if ALU_S = "0000" OR ALU_S = "0001" then
			ALU_C <= ADD_16(ALU_A, ALU_B);		  
			ALU_Carry <= Carry_16(ALU_A, ALU_B);
			if ADD_16(ALU_A, ALU_B) = "0000000000000000" then
				ALU_Zero <= '1';
			else 
				ALU_Zero <= '0';
			end if;
		elsif ALU_S = "0010" then
		   ALU_CARRY<='0';--carry enable zero so we dont care
			ALU_C <= NAND_16(ALU_A, ALU_B);		  
			if NAND_16(ALU_A, ALU_B) = "0000000000000000" then
				ALU_Zero <= '1';
			else
				ALU_Zero <= '0';
			end if;
		elsif ALU_S = "0100" then
		   ALU_CARRY<='0';--carry enable will take care
			ALU_C <= ADD_16(ALU_A, ALU_B);
			if ADD_16(ALU_A, ALU_B) = "0000000000000000" then
				ALU_Zero <= '1';
			else 
				ALU_Zero <= '0';
			end if;
		elsif ALU_S = "0101" or ALU_S = "0110" or ALU_S = "0111" then
		   ALU_ZERO<='0';--zero enable will take care
		   ALU_CARRY<='0';--carry enable will take care
			ALU_C <= ADD_16(ALU_A, ALU_B);
		elsif ALU_S = "1100" then
		   ALU_CARRY<='0';--carry enable will take care
			ALU_ZERO<='0';--zero enable will take care
			ALU_C <= XOR_16(ALU_A, ALU_B);
		else
		   ALU_ZERO<='0';--zero enable will take care
		   ALU_CARRY<='0';--carry enable will take care
			ALU_C <= "0000000000000000";
		end if;
	end process ALU_Process;
end architecture Structure_ALU;