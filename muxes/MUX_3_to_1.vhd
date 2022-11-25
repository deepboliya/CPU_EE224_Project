library ieee;
use ieee.std_logic_1164.all;

entity MUX_3_to_1 is
    port(
        A0,A1,A2: in std_logic_vector(15 downto 0);
        
        S: in std_logic_vector(1 downto 0);
        Op: out std_logic_vector(15 downto 0)
    );
end MUX_3_to_1;
architecture Struct of MUX_3_to_1 is

begin
	process( A0, A1,A2, S )
	begin
	case S is
		when "00" =>
		Op<=A0;
		when "01"=>
		Op<=A1;
		when "10"=>
		Op<=A2;

		when others=>
		Op<="0000000000000000";

		end case;
	end process ; 
	
end Struct;
