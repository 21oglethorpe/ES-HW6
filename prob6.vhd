----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/11/2021 11:30:26 AM
-- Design Name: 
-- Module Name: prob6 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity prob6 is
Port (X, clk : in std_logic;
      Z1, Z2 : out std_logic;
      Y : out std_logic_vector(1 downto 0)
         );
end prob6;

architecture Behavioral of prob6 is
type states is (ST0, ST1, ST2, ST3);
attribute ENUM_ENCODING: STRING;
attribute ENUM_ENCODING of stateS: type is "00 01 10 11";
SIGNAL NS, PS : states;
begin
process(clk)
begin
if rising_edge(clk) then PS <= NS;
end if;
end process;
process(X, PS)
begin
case PS is
    when ST0 => 
        Z1 <= '1';
        if(X = '1') then    Z2 <= '0'; NS <= PS;
        else Z2 <= '0'; NS <= ST2;
        end if;
    when ST1 => 
        Z1 <= '0';
        if(X = '1') then Z2 <= '0'; NS <= PS;
        else Z2 <= '0'; NS <= ST3;
        end if;
    when ST2 =>
        Z1 <= '1';
        if(X = '1') then Z2 <= '0'; NS <= ST0;
        else Z2 <= '0'; NS <= ST1;
        end if;
    when ST3 => 
        Z1 <= '0';
        if(X = '1') then Z2 <= '0'; NS <= ST1;
        else Z2 <= '1'; NS <= ST0;
        end if;
end case;
end process;
with PS select
    Y <= "00" when ST0,
         "01" when ST1,
         "10" when ST2,
         "11" WHEN st3,
         "00" when others;
end Behavioral;
