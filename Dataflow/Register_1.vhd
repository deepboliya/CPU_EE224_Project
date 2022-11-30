library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_1 is
    port (
        DIN : in std_logic;
		  DOUT : out std_logic;
        WE : in std_logic
    );
end entity Register_1;

architecture Register_1_Arch of Register_1 is

    signal stored_DIN : std_logic;
begin
                stored_DIN <= DIN when (WE='1');
     
        DOUT <= stored_DIN ;
    
end architecture Register_1_Arch;
