library ieee;
use ieee.std_logic_1164.all;

entity shifter_7bits is
    port (
        input: in std_logic_vector(8 downto 0);
        shift_out: out std_logic_vector(15 downto 0)
    );
	 
end shifter_7bits;

architecture arch of shifter_7bits is
begin
	
		shift_out <= input&"0000000";
	 
end arch;