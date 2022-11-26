library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_ext_9 is
port( input : in std_logic_vector (8 downto 0);
SE_out : out std_logic_vector ( 15 downto 0)

);

end sign_ext_9;

architecture SE_Arch of sign_ext_9 is
begin

SE_9 : process( input )
	begin
	if input(8) ='0' then
		SE_out<= "0000000"&input;
	else  
		SE_out<= "1111111"&input;
	end if;
	end process ;

end SE_Arch;