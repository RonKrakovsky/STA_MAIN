Library IEEE;
USE IEEE.Std_logic_1164.all;
use ieee.numeric_std.all;

Entity D_Flip_Flop is 

	Generic(FFT_In_Data_Width       : integer   := 16;
			  FFT_Transform_Width     : integer   := 9;
			  FFT_Max_Transform_Width : integer   := 9;
			  FFT_inverse			     : std_Logic := '0';
			  imag_data               : std_logic_vector := "0000000000000000";
			  fcw                     : std_logic_vector := "0000010000000000");


   port(
         
      i_Clk : in  std_logic;   
      i_Real_Data,i_Imag_data 	: in  std_logic_vector ((FFT_In_Data_Width - 1) downto 0);
		i_Switches : in std_logic_vector (5 downto 0);
		o_NCO_Output : out std_logic_vector ((FFT_In_Data_Width - 1) downto 0);
		o_Real_data,o_Imag_data   : out std_logic_vector ((FFT_In_Data_Width - 1) downto 0);
		-- Debug Outputs
		o_NCO_Output_One : out std_logic_vector ((FFT_In_Data_Width - 1) downto 0);
		o_NCO_Output_Two : out std_logic_vector ((FFT_In_Data_Width - 1) downto 0)
		--
   );
end Entity;

Architecture Arch_D_Flip_Flop of D_Flip_Flop is 
   signal s_nco_output : unsigned ((FFT_In_Data_Width - 1) downto 0);
	signal s_added : signed ((FFT_In_Data_Width) downto 0);
begin  

-- o_nco_Output <= std_logic_vector(s_nco_output((FFT_In_Data_Width - 1) downto 0));
o_nco_Output <= i_switches & "0000000000";

-- Debug Outputs
o_NCO_Output_One <= "0010000000000000";
--

 process(i_Clk)
 begin 

		
 
    if(rising_edge(i_Clk)) then
	 
		o_Imag_data <= i_Imag_data;
		o_Real_data <= i_Real_Data;
	--	s_nco_output <= s_nco_output + "0001000000000000";	
		
    end if; 
	 
 end process;
 
end Arch_D_Flip_Flop; 