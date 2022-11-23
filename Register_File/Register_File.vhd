library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_File is
	port( RF_A1, RF_A2, RF_A3 : in std_logic_vector(2 downto 0); RF_D1, RF_D2 : out std_logic_vector(15 downto 0); 
			RF_D3 : in std_logic_vector(15 downto 0) ; RF_RE1, RF_RE2, RF_WR3: in std_logic; clk : in std_logic);  
end entity Register_File;

architecture bhv of Register_File is
	type Reg_File is array (0 to 7) of std_logic_vector(15 downto 0);
	signal memory : Reg_File := (others => (others => '0'));
	 
begin
   storage: process(clk) is
	begin
		if(clk'event and clk = '1') then
			if RF_RE1 = '1' then
				RF_D1 <= memory(to_integer(unsigned(RF_A1)));
			elsif RF_RE2 = '1' then
				RF_D2 <= memory(to_integer(unsigned(RF_A2)));
			elsif RF_WR3 = '1' then
				memory(to_integer(unsigned(RF_A3))) <= RF_D3;
			else 
				null;
			end if;
		end if;
	end process storage;
end architecture bhv;
