-- this component takes a complex vector and outputs its module squared.
--	the component also outputs only the amount of Msb bits chosen from the highest value of the module
-- vector squared.  
------------------------------------------------------------------------
--	entity pin discription	:
--	i_realData		-real data vector input .
--	i_imageData		-image data vector input.
--	o_Squared_data -output data module squared.
------------------------------------------------------------------------
-- entity generic discription :
--	fftResultWidth		-the width of the fft real and complex output.
--	MsbWidth				-the amount of bits of Msb bits chosen from the highest value of the module 
--							 vector squared.
--	MsbNum				-the number of the highest bit to output the MsbWidth "underneath it".
------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity vector_moduleSquared is
generic(fftResultWidth:integer:=16;
		  MsbWidth		 :integer:=32;
		  MsbNum			 :integer:=32); 
port(	i_realData,i_imageData		:in signed(fftResultWidth-1 downto 0);
		o_Squared_Data				:out unsigned(MsbWidth-1 downto 0));		
end entity;
		
architecture arch_vector_moduleSquared of vector_moduleSquared is 
signal realSquared,imageSquared,tempResult:unsigned(2*fftResultWidth downto 0);
begin 
imageSquared<=unsigned('0'&(i_imageData*i_imageData));
realSquared<=unsigned('0'&(i_realData*i_realData));
tempResult<=imageSquared+realSquared;
o_Squared_Data<=tempResult(MsbNum downto MsbNum-(MsbWidth-1));
end architecture;