----------------------------------------------------------------------------------
-- Company: UERGS
-- Engineer: Lucas Karr e Allan Demetrio
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity testbench is

end testbench;

architecture Behavioral of testbench is

    component corex is
        port (
            signal clk             : in  std_logic :='0';
            signal rst_n           : in  std_logic :='1'
              
        ); 
    end component;   
     
    -- control signals
    signal clk_signal               : std_logic :='0';
    signal reset_signal             : std_logic :='1';

    begin
        corex_i : corex
        port map(
            clk                 => clk_signal,
            rst_n               => reset_signal
        );
        
    
    -- clock generator - 100MHZ
    clk_signal 	<= not clk_signal after 5 ns;
    
    -- reset signal
    reset_signal		<= '0' after 5 ns;

end Behavioral;