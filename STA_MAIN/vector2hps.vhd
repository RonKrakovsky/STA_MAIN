--ron krakovsky
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity vector2hps is
generic(
	Data_Width : integer := 32;
	Address_Width : integer := 32;
	hps_address_base : std_logic_vector(31 downto 0) := "11111111111111110000000000000000"
);
port (

	i_data : in std_logic_vector(Data_Width-1 DOWNTO 0);
	i_address : in std_logic_vector(Address_Width-1 downto 0);
	o_data : out std_logic_vector(Data_Width+Address_Width-1 downto 0) -- MSB[address(Address_Width),data(Data_Width)]LSB
	

);
end vector2hps;

architecture behave of vector2hps is
begin


--o_data <= (hps_address_base + i_address) & i_data;
o_data <= (i_address) & i_data;

end behave;