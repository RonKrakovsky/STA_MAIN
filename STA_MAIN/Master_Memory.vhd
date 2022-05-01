library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity Master_Memory is
generic(
	Data_Width : integer := 32;
	Address_Width : integer := 10
);
port (
	-- clock interface
	csi_clock_clk : in std_logic;
	rsi_sink_reset_n : in std_logic;
	
	-- master avalon memory map 
	avm_master_read : out std_logic; -- '1' mean to read from ram and '0' it's write
	avm_master_write : out std_logic;
	avm_master_address : out std_logic_vector (Address_Width-1 downto 0);
	avm_master_readdata : in std_logic_vector (Data_Width-1 downto 0); 
	avm_master_writedata : out std_logic_vector(Data_Width-1 downto 0);
	avm_master_waitrequest : in std_logic;
	avm_master_readdatavalid : in std_logic;
		
	-- control component start and addresses to read and write
	i_control_read : in std_logic; -- -- '1' mean to read from ram and '0' it's write
	i_control_write : in std_logic;
	i_control_startaddress : in std_logic_vector(Address_Width-1 downto 0);
	i_control_stopaddress : in std_logic_vector(Address_Width-1 downto 0);
	
	-- avalon striming input data 
	asi_sink_writedata : in std_logic_vector(Data_Width+Address_Width-1 downto 0); -- MSB[address(Address_Width),data(Data_Width)]LSB
	asi_sink_ready : out std_logic;
	
	-- avalon striming output data 
	aso_source_Data : out std_logic_vector(Data_Width-1 downto 0);
	aso_source_valid : out std_logic;
	aso_source_dataaddress : out std_logic_vector(Address_Width-1 downto 0)

);
end Master_Memory;

architecture behave of Master_Memory is

type read_states_T is (idle, running, running_write, stopping);
signal read_state : read_states_T;

-- read master signals
signal read_address,stop_address,out_address : std_logic_vector(Address_Width-1 downto 0); 

begin
-------------------------------------------------------------------------------	
	process (csi_clock_clk, rsi_sink_reset_n)
	begin
		if rsi_sink_reset_n = '0' then
			read_state <= idle;
			read_address <= (others => '0');
			stop_address <= (others => '0');
			out_address <= i_control_startaddress;
		elsif rising_edge (csi_clock_clk) then
			case read_state is
				
				when idle =>
					read_address <= i_control_startaddress;
					stop_address <= i_control_stopaddress;
					if avm_master_waitrequest = '0' and read_address < stop_address then 
						if i_control_read = '1' then 
							read_state <= running;
							read_address <= read_address + 1;
						elsif i_control_write = '1' then 
							read_state <= running_write;
						end if;
					end if;
					
					
				when running_write => 
					if i_control_read = '1' then 
						read_state <= stopping;
					end if;
					
				
				when running =>
					if avm_master_waitrequest = '0' and read_address < stop_address and i_control_read = '1' then 
						read_address <= read_address + 1;
					elsif read_address = stop_address then 
						read_state <= stopping;
					end if;
					if i_control_write = '1' then 
						read_state <= stopping;
					end if;
				
				when stopping =>
					read_state <= idle;
					read_address <= i_control_startaddress;
			end case;
			
			if avm_master_readdatavalid = '1' then 
				if out_address = stop_address then 
					out_address <= i_control_startaddress;
				else 
					out_address <= out_address + 1;
				end if;
			end if;
			
			if i_control_write = '1' then 
				out_address <= i_control_startaddress;
			end if;
		end if;
	end process;

avm_master_read <= '0' when read_state = stopping or read_state = running_write else
						i_control_read;
avm_master_write <= '0' when read_state = stopping or i_control_read = '1' or read_state = running else
						i_control_write; 						
avm_master_address <= read_address when i_control_read = '1' and i_control_write = '0' else
						asi_sink_writedata(Data_Width+Address_Width-1 downto Data_Width) when i_control_write = '1' and i_control_read = '0' else
						(others => '0');
aso_source_dataaddress <= out_address;
aso_source_valid <= avm_master_readdatavalid;
aso_source_Data <= avm_master_readdata;
asi_sink_ready <= '0' when read_state = stopping or i_control_read = '1' or read_state = running else
						not avm_master_waitrequest;
avm_master_writedata <= asi_sink_writedata(Data_Width-1 downto 0);
end behave;