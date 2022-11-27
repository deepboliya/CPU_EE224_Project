library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_1 is
    port (
        DIN : in std_logic;
		  DOUT : out std_logic;
        CLK, WE : in std_logic
    );
end entity Register_1;

architecture Register_1_Arch of Register_1 is
begin
    process(CLK, WE, DIN)
    variable stored_DIN : std_logic;
    begin
        if rising_edge(CLK) then
            if WE = '1' then
                stored_DIN := DIN;
            else 
                null;
            end if;
        else 
            null;
        end if;
        DOUT <= stored_DIN after 5ns;
    end process;
end architecture Register_1_Arch;