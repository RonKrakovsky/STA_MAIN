Library IEEE;
USE IEEE.Std_logic_1164.all;
use ieee.numeric_std.all;

Entity HPS_Converter is 

	Generic(FFT_In_Data_Width       : integer   := 16;
			  FFT_Transform_Width     : integer   := 9;
			  FFT_Max_Transform_Width : integer   := 9;
			  MsbWidth                : integer   := 32;
			  Fraction_Size           : integer   := 3);


   port( i_Data_To_Logger         : in std_logic_vector ((MsbWidth - 1) + (Fraction_Size - 1) downto 0);
			i_Bit_Reversed_Counter : in std_logic_vector ((FFT_Transform_Width - 1) downto 0);
		   O_Data_to_HPS          : out std_logic_vector (((MsbWidth * 2) - 1) + (Fraction_Size - 1) downto 0)
		 );
end Entity;

Architecture Arch_HPS_Converter of HPS_Converter is

begin  

	o_Data_to_HPS(((MsbWidth * 2) - 1 + (Fraction_Size - 1)) downto MsbWidth) <= i_Data_To_Logger;
	o_Data_to_HPS((MsbWidth - 1) downto FFT_Transform_Width) <= (others => '0');
	o_Data_to_HPS((FFT_Transform_Width - 1) downto 0) <= i_Bit_Reversed_Counter;
 
end Arch_HPS_Converter; 