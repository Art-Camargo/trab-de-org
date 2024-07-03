----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.07.2024 21:45:13
-- Design Name: 
-- Module Name: register_bank - Behavioral
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_bank is
     Port (
        clk : in std_logic;
        r0  : in std_logic_vector(15 downto 0);
        r1  : in std_logic_vector(15 downto 0);
        r2  : in std_logic_vector(15 downto 0);
        r3  : in std_logic_vector(15 downto 0);
        r4  : in std_logic_vector(15 downto 0);
        r5  : in std_logic_vector(15 downto 0);
        r6  : in std_logic_vector(15 downto 0);
        r7  : in std_logic_vector(15 downto 0)
      );
end register_bank;

architecture Behavioral of register_bank is
       signal reg0  :  std_logic_vector(15 downto 0);
       signal reg1  :  std_logic_vector(15 downto 0);
       signal reg2  :  std_logic_vector(15 downto 0);
       signal reg3  :  std_logic_vector(15 downto 0);
       signal reg4  :  std_logic_vector(15 downto 0);
       signal reg5  :  std_logic_vector(15 downto 0);
       signal reg6  :  std_logic_vector(15 downto 0);
       signal reg7  :  std_logic_vector(15 downto 0);
begin
       reg0 <=  r0;
       reg1 <=  r1;
       reg2 <=  r2;
       reg3 <=  r3;
       reg4 <=  r4;
       reg5 <=  r5;
       reg6 <=  r6;
       reg7 <=  r7; 
end Behavioral;
