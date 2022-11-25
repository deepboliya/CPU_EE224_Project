 -- A DUT entity is used to wrap your design so that we can combine it with testbench.
-- This example shows how you can do this for the OR Gate

library ieee;
use ieee.std_logic_1164.all;

entity DUT is
    port(input_vector: in std_logic_vector(8 downto 0);
       	output_vector: out std_logic_vector(15 downto 0));
end entity;

architecture DutWrap of DUT is
   component sign_ext_9 is
  port( input : in std_logic_vector (8 downto 0);
SE_out : out std_logic_vector ( 15 downto 0)

);
   end component;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   add_instance: sign_ext_9 
			port map (
					-- order of inputs B A
					
					input => input_vector(8 downto 0),
               -- order of output OUTPUT
					SE_out => output_vector(15 downto 0));
end DutWrap;