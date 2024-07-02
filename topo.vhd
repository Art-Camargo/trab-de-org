library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.ALL;


entity corex is
  Port (
      rst_n                  : in  std_logic;
      clk                    : in  std_logic
   );
end corex;

architecture rtl of corex is

   signal pc_enable : std_logic := '0';
   signal address :  std_logic_vector (7  downto 0);
  -- INSTRUCTION DECODER
   signal jump_enable : std_logic := '0';
   signal jump_address : std_logic_vector (7  downto 0);

  signal program_counter               : std_logic_vector (7  downto 0) := "00000000";
  signal pc_test               : std_logic_vector (7  downto 0) := "00000000";
  signal mem_write_enable_signal       : std_logic := '0';
  signal mem_read_enable_signal        : std_logic := '0';
  signal memory_out_signal        : std_logic_vector (15 downto 0);
  signal data_memory_out_signal        : std_logic_vector (15 downto 0);
  signal data_memory_in_signal         : std_logic_vector (15 downto 0);
  signal instruction                   : std_logic_vector (3 downto 0);

  -- REGISTERS
  signal regzero             : std_logic_vector (15 downto 0):= "0000000000000000";
  signal reg1                : std_logic_vector (15 downto 0);
  signal reg2                : std_logic_vector (15 downto 0);
  signal reg3                : std_logic_vector (15 downto 0);
  signal reg4                : std_logic_vector (15 downto 0);
  signal reg5                : std_logic_vector (15 downto 0);
  signal reg6                : std_logic_vector (15 downto 0);
  signal reg7                : std_logic_vector (15 downto 0);
    
  -- REGISTERS OPERATORS
  signal reg_alu_a          : std_logic_vector (15 downto 0);
  signal reg_alu_b          : std_logic_vector (15 downto 0);
  signal reg_alu_out        : std_logic_vector (15 downto 0);


  

  -- ALU
  signal alu_op             : std_logic_vector (3 downto 0);
  
  component memory is
		port(        
		  clk               : in  std_logic;
       
		
        rst_n               : in  std_logic;        
        
        pc                  : in  std_logic_vector(7  downto 0);
        data_fetched        : out std_logic_vector(15 downto 0)
          );      
	end component;
	
	 component inc is
		port(        
		 jmp :  in std_logic_vector (7  downto 0) ;
     jmp_e : in std_logic ;
		   clk: in std_logic;
            pc : out std_logic_vector (7  downto 0);
            pc_enable : in std_logic;
            test : out std_logic_vector (7  downto 0)
          );      
	end component;
	
	component data_memory is 
	   port(
	     clk                 : in  std_logic;
        write_enable        : in  std_logic;
		read_enable         : in  std_logic;
        rst_n               : in  std_logic;        
        data_to_write       : in  std_logic_vector(15 downto 0);
        address             : in  std_logic_vector(7  downto 0);
        data_fetched        : out std_logic_vector(15 downto 0)
       );
     end component;
     
    component control_unit is 
        port (
        jmp :  out std_logic_vector (7  downto 0);
        jmp_e : out std_logic ;
        data_to_write : out  std_logic_vector(15 downto 0);
        data_memory_out_signal : in std_logic_vector(15 downto 0);
        reg1 : out std_logic_vector(15 downto 0);
         reg2 : out std_logic_vector(15 downto 0);
          reg3 : out std_logic_vector(15 downto 0);
           reg4 : out std_logic_vector(15 downto 0);
            reg5 : out std_logic_vector(15 downto 0);
             reg6 : out std_logic_vector(15 downto 0);
              reg7 : out std_logic_vector(15 downto 0);
         address : out std_logic_vector (7  downto 0);
         write_enable : out std_logic ;
          clk                 : in  std_logic;
        rst_n               : in  std_logic;
        pc_enable           : out std_logic;
        instruction         : in std_logic_vector(15 downto 0);
       program_counter  : out std_logic_vector(7 downto 0) ;
         reg1_read                : in std_logic_vector(15 downto 0) ;
         reg2_read                : in std_logic_vector(15 downto 0) ;
         reg3_read                : in std_logic_vector(15 downto 0);
         reg4_read                : in std_logic_vector(15 downto 0);
         reg5_read                : in std_logic_vector(15 downto 0);
         reg6_read                : in std_logic_vector(15 downto 0);
         reg7_read                : in std_logic_vector(15 downto 0)
        );
    end component;

  begin  
  
    control_i : control_unit 
        port map(
        jmp => jump_address,
        jmp_e => jump_enable,
        data_to_write => data_memory_in_signal,
        data_memory_out_signal => data_memory_out_signal,
        reg1 => reg1,
        reg2 => reg2,
        reg3 => reg3,
        reg4 => reg4,
        reg5 => reg5,
        reg6 => reg6,
        reg7 => reg7,
        
         clk              => clk,
           write_enable => mem_write_enable_signal,
           address => address,
            rst_n            => rst_n,           
            instruction => memory_out_signal,
            pc_enable =>            pc_enable,
            program_counter => program_counter,
            reg1_read => reg1,
            reg2_read => reg2,
            reg3_read => reg3,
            reg4_read => reg4,
            reg5_read => reg5,
            reg6_read => reg6,
            reg7_read => reg7
        );

      memory_i : memory
          port map(
            clk              => clk,
           
            rst_n            => rst_n,           
            
            pc               => pc_test,   
            data_fetched     => memory_out_signal 
          );
          
         inc_i : inc
            port map(
            jmp => jump_address,
        jmp_e => jump_enable, 
            test => pc_test,
            clk => clk,
            pc => program_counter,
            pc_enable => pc_enable
          );
          
       data_memory_i : data_memory
        port map (
            clk  => clk,               
            write_enable   => mem_write_enable_signal,        
            read_enable      => mem_read_enable_signal,       
            rst_n            => rst_n,              
            data_to_write    => data_memory_in_signal,
            address           => address,  
            data_fetched        => data_memory_out_signal
         );
      
end rtl;