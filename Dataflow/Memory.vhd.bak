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
signal mem: mem_index := (0=>"0100000000000001", 1=>"0100001000000011", 2=>"1100000001010100", 3=>"1101001001011100", 128=>"1111111111111111", 129=>"1111111111111110", 130=>"1111111111111100", 131=>"1111111111111000", 132=>"1111111111110000", 133=>"1111111111100000", others => "0000000000000000");


begin
writing : process(WE, clk, address, Din)
begin
  if rising_edge(clk) then
    if WE='1' then
	   mem(to_integer(unsigned(address)))<=Din;
	 else
	   null;
	 end if;
  else
    null;
  end if;
end process;

reading:process(RE,clk)
begin

if rising_edge(clk) then
    if WE='1' then 
	Dout<=mem(to_integer(unsigned(address)));
 else
	   null;
	 end if;
  else
    null;
  end if;
end process;
	
end mem_arch;