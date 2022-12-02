library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memory is
    port(
	   WE,RE,clk: in std_logic;
		address,Din: in std_logic_vector(15 downto 0);
		Dout: out std_logic_vector(15 downto 0)
		);
end memory;

architecture mem_arch of memory is
	type mem_index is array(65535 downto 0) of std_logic_vector(15 downto 0);
	signal mem: mem_index := (
	0=>"0000001010000000",

	--1=>"1111111111111111",
--	1=>"0101101010100000", 2=>"0000001010100000", 3=>"1100100101000001",4=>"0100001010100000",5=>"0000000000110000",6=>"0000101001110010",
	others => "1111111111111111");
begin

  
writing : process(WE, clk, address, Din)
begin
 -- if rising_edge(clk) then
    if WE='1' then
	   mem(to_integer(unsigned(address)))<=Din;
	 else
	   null;
	 end if;
  --else
  --  null;
  --end if;
end process;

reading:process(RE,clk,mem,address)
begin
--if rising_edge(clk) then
    if RE='1' then 
	Dout<=mem(to_integer(unsigned(address)));
 else
	   null;
	 end if;
 -- else
   -- null;
 -- end if;
end process;
	
end mem_arch;