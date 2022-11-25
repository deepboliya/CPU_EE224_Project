
library ieee;
use ieee.std_logic_1164.all;

entity MUX_1_TO_3 is
    port(
        i: in std_logic_vector(15 downto 0);
        d0,d1,d2: out std_logic_vector(15 downto 0);
        S: in std_logic_vector(1 downto 0)
         );
end MUX_1_to_3;
architecture Struct of MUX_1_to_3 is

begin
	process( i,S )
	begin
	 case s is
		when"00" =>
		d0<=i;
		d1<="0000000000000000";
		d2<="0000000000000000";
		when "01"=>
		d1<=i;
		d0<="0000000000000000";
		d2<="0000000000000000";
		when "10" =>
		d2<=i;
		d1<="0000000000000000";
		d0<="0000000000000000";
		when others=>
		d2<="0000000000000000";
		d0<="0000000000000000";
		d1<="0000000000000000";
		end case;
	end process; 
	
end Struct;