

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity prob13 is
Port (X1, X2, clk : in std_logic;
      CS, RD, Y3, Y2, Y1 : out std_logic;
      Y : out std_logic_vector(1 downto 0)
         );
end prob13;

architecture Behavioral of prob13 is
type states is (ST0, ST1, ST2);
attribute ENUM_ENCODING: STRING;
attribute ENUM_ENCODING of stateS: type is "001 010 100";
SIGNAL NS, PS : states;
begin
process(clk)
begin
if rising_edge(clk) then PS <= NS;
end if;
end process;
process(X1, X2, PS)
begin
case PS is
    when ST0 => 
        Y3 <= '0'; Y2 <= '0'; Y1 <= '1';
        if(X1 = '1') then    CS <= '1'; RD<= '0'; NS <= ST2;
        else CS <= '0'; RD <= '1'; NS <= ST1;
        end if;
    when ST1 => 
        Y3 <= '0'; Y2 <= '1'; Y1 <= '0';
        CS <= '1'; RD <= '1'; NS <= ST2;
    when ST2 =>
        Y3 <= '1'; Y2 <= '0'; Y1 <= '0';
        if(X2 = '1')THEN CS <= '0'; RD <= '1'; NS <= PS;
        else CS <= '0'; RD <= '0'; NS <= ST0;
        end if;
end case;
end process;
with PS select
    Y <= "001" when ST0,
         "010" when ST1,
         "100" when ST2,
         "001" when others;
end Behavioral;
