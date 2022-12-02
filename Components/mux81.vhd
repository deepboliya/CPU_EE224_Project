library ieee;
use ieee.std_logic_1164.all;

entity mux81 is
    
    port (
        A0: in std_logic_vector(15 downto 0);
        A1: in std_logic_vector(15 downto 0);
		  A2: in std_logic_vector(15 downto 0);
		  A3: in std_logic_vector(15 downto 0);
		  A4: in std_logic_vector(15 downto 0);
		  A5: in std_logic_vector(15 downto 0);
		  A6: in std_logic_vector(15 downto 0);
		  A7: in std_logic_vector(15 downto 0);
        S: in std_logic_vector(2 downto 0);
		  Enable : in std_logic;
        Op: out std_logic_vector(15 downto 0)
    ) ;
end mux81;
architecture behavior of mux81 is

begin
alu : process( A0, A1, A2, A3, A4, A5, A6, A7, S)
begin
	if Enable = '1' then
		  if S="000" then
			 Op <= A0;
		  elsif S="001" then
			 Op <= A1;
		  elsif S="010" then
			 Op <= A2;
		  elsif S="011" then
			 Op <= A3;
		  elsif S="100" then
			 Op <= A4;
		  elsif S="101" then
			 Op <= A5;
		  elsif S="110" then
			 Op <= A6;
		  else
			 Op <= A7;
		  end if;
	else
		Op <= "0000000000000000";
	end if;
end process ;
end behavior;
