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
    jmp :  in std_logic_vector (7  downto 0) ;
     jmp_e : in std_logic ;
    clk: in std_logic;
    pc : out std_logic_vector (7  downto 0);
    pc_enable: in std_logic;
    test : out  std_logic_vector (7  downto 0) := "00000000"
  );
end inc;

architecture Behavioral of inc is

    signal program_counter : std_logic_vector (7  downto 0) := "00000000";
    
begin
   process(clk)
       begin 
            if (clk'event and clk='1') then
               if (jmp_e = '1') then 
               program_counter <= jmp;
               
            
               elsif (pc_enable = '1') then
                   program_counter <= program_counter + "00000001";
      
               end if;
            end if;
           
    end process;
     test <= program_counter;
end Behavioral;
