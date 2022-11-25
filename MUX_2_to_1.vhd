library ieee;
use ieee.std_logic_1164.all;

entity MUX_2_to_1 is
    port(
        A0: in std_logic_vector(15 downto 0);
        A1: in std_logic_vector(15 downto 0);
        S: in std_logic;
        Op: out std_logic_vector(15 downto 0)
    );
end MUX_2_to_1;
architecture Struct of MUX_2_to_1 is

begin
	process( A0, A1, S )
	begin
		if S='0' then
			Op <= A0;
		elsif S='1' then 
			Op <= A1;
		end if;
	end process ; 
	
end Struct;