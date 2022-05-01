library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity DMA is
generic(
	Data_Width : integer := 32;
	Address_Width : integer := 32;
	hps_address_base : std_logic_vector(31 downto 0) := "11111111111111110000000000000000"
);
port (
	-- clock interface
	csi_clock_clk : in std_logic;
	rsi_sink_reset_n : in std_logic;
	
	-- master avalon memory map 
	avm_master_read : out std_logic; -- '1' mean to read from ram and '0' it's write
	avm_master_address : out std_logic_vector (Address_Width-1 downto 0);
	avm_master_readdata : in std_logic_vector (Data_Width-1 downto 0); 
	avm_master_waitrequest : in std_logic;
	avm_master_readdatavalid : in std_logic;
	
	-- mastertohps avalon memory map 
	avm_mastertohps_write : out std_logic;
	avm_mastertohps_address : out std_logic_vector (Address_Width-1 downto 0);
	avm_mastertohps_writedata : out std_logic_vector(Data_Width-1 downto 0);
	avm_mastertohps_waitrequest : in std_logic;
		
	-- control component start and addresses to read and write
	i_control_startaddress : in std_logic_vector(Address_Width-1 downto 0);
	i_control_stopaddress : in std_logic_vector(Address_Width-1 downto 0)
		

);
end DMA;

architecture behave of DMA is

type states_T is (idle, running_read, running_write, stopping);
signal state : states_T;

-- read master signals
signal read_address,write_address,stop_address,out_address : std_logic_vector(Address_Width-1 downto 0); 
signal s_read,s_write,read_valid,flag_Valid : std_logic;
signal read_data : std_logic_vector(Data_Width-1 downto 0);
begin
-------------------------------------------------------------------------------	
	process (csi_clock_clk, rsi_sink_reset_n)
	begin
		if rsi_sink_reset_n = '0' then
			state <= idle;
			read_address <= (others => '0');
			stop_address <= (others => '0');
			write_address <= (others => '0');
			out_address <= i_control_startaddress;
			s_read <= '0';
			s_write <= '0';
			flag_Valid <= '0';
		elsif rising_edge (csi_clock_clk) then
			case state is
				
				when idle =>
					read_address <= i_control_startaddress;
					write_address <= i_control_startaddress;
					stop_address <= i_control_stopaddress;
					if avm_master_waitrequest = '0' and read_address < stop_address then 
						if s_read = '1' then 
							state <= running_write;
							read_address <= read_address + 1;
							s_read <= '0';
						else
							s_read <= '1';
							s_write <= '0';
						end if;
					end if;
					flag_Valid <= '0';
					
					
				when running_write => 
					if read_valid = '1' or flag_Valid = '1' then 
						if avm_mastertohps_waitrequest = '0' and write_address = stop_address then 
							write_address <= i_control_startaddress;
							state <= stopping;
							flag_Valid <= '0';
							s_write <= '0';
						elsif avm_mastertohps_waitrequest = '0' and s_write = '1' then
							write_address <= write_address + 1;
							s_write <= '0';
							s_read <= '1';
							flag_Valid <= '0';
							state <= running_read;
						elsif s_write = '0' then
							s_write <= '1';
							flag_Valid <= '1';
						end if;
					end if;
					
					
				
				when running_read =>
					if avm_master_waitrequest = '0' and s_read = '1' then 
						read_address <= read_address + 1;
						s_write <= '1';
						s_read <= '0';
						state <= running_write;
					end if;
				
				when stopping =>
					state <= idle;
					read_address <= i_control_startaddress;
					write_address <= i_control_startaddress;
			end case;
			
		end if;
	end process;

avm_master_read <= '0' when state = stopping or state = running_write else
						s_read;						
avm_master_address <= read_address;
----------------------------------
avm_mastertohps_address <= write_address + hps_address_base;
avm_mastertohps_write <= '0' when state = stopping or state = running_read else
						s_write; 
avm_mastertohps_writedata <= read_data;

-----------------------------------------
read_valid <= avm_master_readdatavalid;
read_data <= avm_master_readdata when avm_master_readdatavalid = '1';
end behave;