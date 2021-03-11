----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/11/2021 12:51:18 AM
-- Design Name: 
-- Module Name: prob2 - Behavioral
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

entity prob2 is
Port ( x1, x2, clk: in std_logic;
        Y: out character;
        z1, z2: out std_logic);
end prob2;

architecture Behavioral of prob2 is
type state_type is (ST0, ST1, ST2);
attribute ENUM_ENCODING: STRING;
attribute ENUM_ENCODING of state_type: type is "a b c ";
signal PS, NS : state_type;
begin
    process(clk)
    begin
    if rising_edge(clk) then
        PS <= NS;
    end if;
    end process;
    process(PS, x1, x2)
    begin
    case PS is
        when ST0 =>
            z1 <= '0';
            if(x1 = '1') then z2 <= '1'; NS <= ST1;
            else z2 <= '0'; NS <= ST2;
            end if;
        when ST1 => 
            z1 <= '1';
            if(x2 = '1') then z2 <= '0'; NS <= ST0;
            else z2 <= '1'; NS <= ST2;
            end if;
        when ST2 =>
            z1 <= '1';
            if(x1 = '1') then z2 <= '1'; NS <= ST1;
            else z2 <= '1'; NS <= ST0;
        end if;
    end case;
    end process;
    with PS select
    Y <= 'a' when ST0,
         'b' when ST1,
         'c' when ST2,
         'a' when others;
end Behavioral;
