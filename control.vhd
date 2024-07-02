library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.ALL;

entity control_unit is
    Port ( 
    jmp :  out std_logic_vector (7  downto 0) := "00000000";
     jmp_e : out std_logic := '0';
    data_to_write : out  std_logic_vector(15 downto 0);
    data_memory_out_signal : in std_logic_vector(15 downto 0);
    reg2 : out std_logic_vector(15 downto 0);
          reg3 : out std_logic_vector(15 downto 0);
           reg4 : out std_logic_vector(15 downto 0);
            reg5 : out std_logic_vector(15 downto 0);
             reg6 : out std_logic_vector(15 downto 0);
              reg7 : out std_logic_vector(15 downto 0);
     reg1 :out  std_logic_vector(15 downto 0);
         address : out std_logic_vector (7  downto 0);
         write_enable : out std_logic ;
        clk                 : in  std_logic;
        rst_n               : in  std_logic;
        pc_enable           : out std_logic;
        instruction         : in std_logic_vector(15 downto 0);
       program_counter : out std_logic_vector(7 downto 0);
         reg1_read                : in std_logic_vector(15 downto 0);
         reg2_read                : in std_logic_vector(15 downto 0);
         reg3_read                : in std_logic_vector(15 downto 0);
         reg4_read                : in std_logic_vector(15 downto 0);
         reg5_read                : in std_logic_vector(15 downto 0);
         reg6_read                : in std_logic_vector(15 downto 0);
         reg7_read                : in std_logic_vector(15 downto 0)
    );
end control_unit;


architecture rtl of control_unit is    
    type state_type is(
        FETCH,
        DECODE,
        ALU_DECODE,
        ALU,
        LOAD,
        STORE,
        PROX,
        BEQ,
        LOAD_REG,
        JUMP,
        RESP_ULA,
        BEQ_DECISION
        
    );
    signal current : state_type;    
    signal nextstate : state_type;
    signal instruction_code : std_logic_vector(3 downto 0);
    signal ula_op_a : std_logic_vector(15 downto 0);
    signal ula_op_b : std_logic_vector(15 downto 0);
    signal ula_op_resp : std_logic_vector(15 downto 0);
    
    
begin

    process (clk)
        begin
            if (clk'event and clk='1') then
                if (rst_n='1') then
                    current <= FETCH;
                else
                    current <= nextstate;
                end if;
            end if;
    end process;
    
    process(clk,current)
        begin
            --nextstate <= current;
            jmp_e <= '0';
            pc_enable <= '0';
            case (current) is
            
                when FETCH =>
                 
                
                 nextstate <= DECODE;
                
               when DECODE =>
                  instruction_code <= instruction(15 downto 12);
                  case (instruction(15 downto 12)) is
                    -- ADD
                     when "0001" =>
                        nextstate <= ALU_DECODE;
                     -- SUB
                     when "0010" =>
                        nextstate <= ALU_DECODE;
                     -- AND
                     when "0011" =>
                        nextstate <= ALU_DECODE;
                     -- NOT
                     when "0100" =>
                        nextstate <= ALU_DECODE;
                     -- JUMP
                     when "0101" =>
                        nextstate <= JUMP;
                     --BEQ
                     when "0110" =>
                        nextstate <= BEQ;
                     -- LOAD
                     when "0111" =>
                        nextstate <= LOAD;
                     --STORE
                     when "1000" =>
                        nextstate <= STORE;
                        
                    
                     when others => 
                  end case;
                  
                  
                when ALU_DECODE => 
                    case (instruction(8 downto 6)) is 
                        when "001" => ula_op_a <= reg1_read;
                        when "010" => ula_op_a <= reg2_read;
                        when "011" => ula_op_a <= reg3_read;
                        when "100" => ula_op_a <= reg4_read;
                        when "101" => ula_op_a <= reg5_read;
                        when "110" => ula_op_a <= reg6_read;
                        when "111" => ula_op_a <= reg7_read;
                        when others => ula_op_a <= "0000000000000000";
                    end case;
                    
                    case (instruction(5 downto 3)) is 
                        when "001" => ula_op_b <= reg1_read;
                        when "010" => ula_op_b <= reg2_read;
                        when "011" => ula_op_b <= reg3_read;
                        when "100" => ula_op_b <= reg4_read;
                        when "101" => ula_op_b <= reg5_read;
                        when "110" => ula_op_b <= reg6_read;
                        when "111" => ula_op_b <= reg7_read;
                        when others => ula_op_b <= "0000000000000000";
                    end case;
                   
                    
                    nextstate <= ALU;
                    
                when ALU =>
                    case (instruction(15 downto 12)) is 
                         when "0001" => ula_op_resp <= ula_op_a + ula_op_b;
                         when "0010" => ula_op_resp <= ula_op_a - ula_op_b;
                         when "0011" => ula_op_resp <= ula_op_a and ula_op_b;
                         when "0100" => ula_op_resp <= not ula_op_a;
                         when others => ula_op_resp <=  "0000000000000000";
                    end case;
                    nextstate <= RESP_ULA;
                    
                 
                when RESP_ULA => 
                      
                    case (instruction(11 downto 9)) is 
                    
                        when "001" => reg1 <= ula_op_resp;
                        when "010" => reg2 <= ula_op_resp;
                        when "011" => reg3 <= ula_op_resp;
                        when "100" => reg4 <= ula_op_resp;
                        when "101" => reg5 <= ula_op_resp;
                        when "110" => reg6 <= ula_op_resp;
                        when "111" => reg7 <= ula_op_resp;
                        when others => reg1 <= "0000000000000000";
                    end case;
                    
                    nextstate <= PROX;
                -- load OK (full)
                when LOAD => 
                    write_enable <= '0';
                    address <= instruction(11 downto 4);
                    nextstate <= LOAD_REG;
                    
                when LOAD_REG => 
                     case (instruction(3 downto 1)) is 
                        when "001" => reg1 <= data_memory_out_signal;
                        when "010" => reg2 <= data_memory_out_signal;
                        when "011" => reg3 <= data_memory_out_signal;
                        when "100" => reg4 <= data_memory_out_signal;
                        when "101" => reg5 <= data_memory_out_signal;
                        when "110" => reg6 <= data_memory_out_signal;
                        when "111" => reg7 <= data_memory_out_signal;
                        when others => 
                     end case;
                     nextstate <= PROX;
                     
                     
                when STORE => 
                     write_enable <= '1';
                     address <= instruction(11 downto 4);
                     case (instruction(3 downto 1)) is 
                        when "001" => data_to_write <= reg1_read;
                        when "010" => data_to_write <= reg2_read;
                        when "011" => data_to_write <= reg3_read;
                        when "100" => data_to_write <= reg4_read;
                        when "101" => data_to_write <= reg5_read;
                        when "110" => data_to_write <= reg6_read;
                        when "111" => data_to_write <= reg7_read;
                        when others => 
                     end case;
                    nextstate <= PROX;
                
                
                when JUMP => 
                   jmp_e <= '1';
                   jmp <=  instruction(11 downto 4);
                   nextstate <= PROX;
                   
                when BEQ => 
                    jmp <= "11" & instruction(11 downto 6);
                      case (instruction(5 downto 3)) is 
                        when "001" => ula_op_a <= reg1_read;
                        when "010" => ula_op_a <= reg2_read;
                        when "011" => ula_op_a <= reg3_read;
                        when "100" => ula_op_a <= reg4_read;
                        when "101" => ula_op_a <= reg5_read;
                        when "110" => ula_op_a <= reg6_read;
                        when "111" => ula_op_a <= reg7_read;
                        when others => ula_op_a <= "0000000000000000";
                    end case;
                    
                    case (instruction(2 downto 0)) is 
                        when "001" => ula_op_b <= reg1_read;
                        when "010" => ula_op_b <= reg2_read;
                        when "011" => ula_op_b <= reg3_read;
                        when "100" => ula_op_b <= reg4_read;
                        when "101" => ula_op_b <= reg5_read;
                        when "110" => ula_op_b <= reg6_read;
                        when "111" => ula_op_b <= reg7_read;
                        when others => ula_op_b <= "0000000000000000";
                    end case;
                    
                    nextstate <= BEQ_DECISION;
               
               when BEQ_DECISION => 
                    if (ula_op_a = ula_op_b) then
                         jmp_e <= '1';
                    end if;
                     nextstate <= PROX;
               
                when others => -- PROX
                   
                   pc_enable <= '1';
                     
                    nextstate <= FETCH;
            
            end case;
    end process;                                                        
end rtl;