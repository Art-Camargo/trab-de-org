----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.07.2024 19:16:48
-- Design Name: 
-- Module Name: increment - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.ALL;


entity inc is
  Port (
    clk: in std_logic;
    pc : out std_logic_vector (7  downto 0);
    pc_enable: in std_logic
  );
end inc;

architecture Behavioral of inc is

    signal program_counter : std_logic_vector (7  downto 0) := "00000000";
    
begin
   process(clk)
       begin 
            if (clk'event and clk='1') then
               if (pc_enable = '1') then
                    program_counter <= program_counter + "00000001";
                    pc <= program_counter ;
               end if;
            end if;
    end process;
end Behavioral;
