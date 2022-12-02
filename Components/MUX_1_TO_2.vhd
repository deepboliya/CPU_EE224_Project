
library ieee;
use ieee.std_logic_1164.all;

entity MUX_1_TO_2 is
    port(
        i: in std_logic_vector(15 downto 0);
        d0,d1: out std_logic_vector(15 downto 0);
        S: in std_logic
         );
end entity MUX_1_TO_2;
architecture Struct of MUX_1_to_2 is

begin
	process( i,S )
	begin
	 case s is
		when '0' =>
		d0<=i;
		d1<="0000000000000000";
	
		when '1'=>
		d1<=i;
		d0<="0000000000000000";


		when others=>
		d0<="0000000000000000";
		d1<="0000000000000000";
		end case;
	end process; 
	
end Struct;