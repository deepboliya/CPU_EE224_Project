library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_16 is
    port (
        DIN : in std_logic_vector(15 downto 0);
		  DOUT : out std_logic_vector(15 downto 0);
        WE : in std_logic
    );
end entity Register_16;

architecture Register_16_Arch of Register_16 is

    
    signal stored_DIN : std_logic_vector(15 downto 0) := (others => '0');
    begin
       
           
                stored_DIN <= DIN when (WE='1');
         
       

        DOUT <= stored_DIN ;
    
end architecture Register_16_Arch;