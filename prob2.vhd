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
        Y: out std_logic_vector(1 downto 0);
        Z, y1, y0: out std_logic);
end prob2;

architecture Behavioral of prob2 is
type state_type is (a, b, c);
attribute ENUM_ENCODING: STRING;
attribute ENUM_ENCODING of state_type: type is "10 11 01";
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
        when a =>
            y1 <= '1'; y0 <= '0';
            if(x1 = '1') then z <= '0'; NS <= c;
            else z <= '0'; NS <= PS;
            end if;
        when b => 
            y1 <= '1'; y0 <= '1';
            if(x2 = '1') then z <= '0'; NS <= PS;
            else z <= '1'; NS <= a;
            end if;
        when c =>
            y1 <= '0'; y0 <= '1';
            if(x2 = '1') then z <= '0'; NS <= b;
            else z <= '1'; NS <= a;
        end if;
    end case;
    end process;
    with PS select
    Y <= "10" when a,
         "11" when b,
         "01" when c,
         "10" when others;
end Behavioral;
