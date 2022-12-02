library ieee;
use ieee.std_logic_1164.all;

entity MUX_5_to_1 is
    port(
        A0,A1,A2,A3,A4: in std_logic_vector(15 downto 0);
        
        S: in std_logic_vector(2 downto 0);
        Op: out std_logic_vector(15 downto 0)
    );
end MUX_5_to_1;
architecture Struct of MUX_5_to_1 is

begin
	process( A0, A1,A2,A3,A4, S )
	begin
	case S is
		when "000" =>
		Op<=A0;
		when "001"=>
		Op<=A1;
		when "010"=>
		Op<=A2;
		when "011"=>
		Op<=A3;
		when "100"=>
		Op<=A4;

		when others=>
		Op<="0000000000000000";

		end case;
	end process ; 
	
end Struct;