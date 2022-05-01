library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



ENTITY HPSFPGA IS
generic(
	Data_Width : integer := 32;
	Address_Width : integer := 32
);
PORT(
---------FPGA Connections-------------
FPGA_CLK1_50: IN STD_LOGIC;

---------HPS Connections---------------
HPS_CONV_USB_N:INOUT STD_LOGIC;
HPS_DDR3_ADDR:OUT STD_LOGIC_VECTOR(14 downto 0);
HPS_DDR3_BA: OUT STD_LOGIC_VECTOR(2 downto 0);
HPS_DDR3_CAS_N: OUT STD_LOGIC;
HPS_DDR3_CKE:OUT STD_LOGIC;
HPS_DDR3_CK_N: OUT STD_LOGIC;
HPS_DDR3_CK_P: OUT STD_LOGIC;
HPS_DDR3_CS_N: OUT STD_LOGIC;
HPS_DDR3_DM: OUT STD_LOGIC_VECTOR(3 downto 0);
HPS_DDR3_DQ: INOUT STD_LOGIC_VECTOR(31 downto 0);
HPS_DDR3_DQS_N: INOUT STD_LOGIC_VECTOR(3 downto 0);
HPS_DDR3_DQS_P: INOUT STD_LOGIC_VECTOR(3 downto 0);
HPS_DDR3_ODT: OUT STD_LOGIC;
HPS_DDR3_RAS_N: OUT STD_LOGIC;
HPS_DDR3_RESET_N: OUT  STD_LOGIC;
HPS_DDR3_RZQ: IN  STD_LOGIC;
HPS_DDR3_WE_N: OUT STD_LOGIC;
HPS_ENET_GTX_CLK: OUT STD_LOGIC;
HPS_ENET_INT_N:INOUT STD_LOGIC;
HPS_ENET_MDC:OUT STD_LOGIC;
HPS_ENET_MDIO:INOUT STD_LOGIC;
HPS_ENET_RX_CLK: IN STD_LOGIC;
HPS_ENET_RX_DATA: IN STD_LOGIC_VECTOR(3 downto 0);
HPS_ENET_RX_DV: IN STD_LOGIC;
HPS_ENET_TX_DATA: OUT STD_LOGIC_VECTOR(3 downto 0);
HPS_ENET_TX_EN: OUT STD_LOGIC;
HPS_KEY: INOUT STD_LOGIC;
HPS_SD_CLK: OUT STD_LOGIC;
HPS_SD_CMD: INOUT STD_LOGIC;
HPS_SD_DATA: INOUT STD_LOGIC_VECTOR(3 downto 0);
HPS_UART_RX: IN   STD_LOGIC;
HPS_UART_TX: OUT STD_LOGIC;
HPS_USB_CLKOUT: IN STD_LOGIC;
HPS_USB_DATA:INOUT STD_LOGIC_VECTOR(7 downto 0);
HPS_USB_DIR: IN STD_LOGIC;
HPS_USB_NXT: IN STD_LOGIC;
HPS_USB_STP: OUT STD_LOGIC

);
END HPSFPGA;

ARCHITECTURE MAIN OF HPSFPGA IS
COMPONENT soc_system4
	PORT
	(
		clk_clk		:	 IN STD_LOGIC;
		dma_0_i_controll_startaddress		:	 IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		dma_0_i_controll_stopaddress		:	 IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		hps_0_h2f_reset_reset_n		:	 OUT STD_LOGIC;
		hps_io_hps_io_emac1_inst_TX_CLK		:	 OUT STD_LOGIC;
		hps_io_hps_io_emac1_inst_TXD0		:	 OUT STD_LOGIC;
		hps_io_hps_io_emac1_inst_TXD1		:	 OUT STD_LOGIC;
		hps_io_hps_io_emac1_inst_TXD2		:	 OUT STD_LOGIC;
		hps_io_hps_io_emac1_inst_TXD3		:	 OUT STD_LOGIC;
		hps_io_hps_io_emac1_inst_RXD0		:	 IN STD_LOGIC;
		hps_io_hps_io_emac1_inst_MDIO		:	 INOUT STD_LOGIC;
		hps_io_hps_io_emac1_inst_MDC		:	 OUT STD_LOGIC;
		hps_io_hps_io_emac1_inst_RX_CTL		:	 IN STD_LOGIC;
		hps_io_hps_io_emac1_inst_TX_CTL		:	 OUT STD_LOGIC;
		hps_io_hps_io_emac1_inst_RX_CLK		:	 IN STD_LOGIC;
		hps_io_hps_io_emac1_inst_RXD1		:	 IN STD_LOGIC;
		hps_io_hps_io_emac1_inst_RXD2		:	 IN STD_LOGIC;
		hps_io_hps_io_emac1_inst_RXD3		:	 IN STD_LOGIC;
		hps_io_hps_io_sdio_inst_CMD		:	 INOUT STD_LOGIC;
		hps_io_hps_io_sdio_inst_D0		:	 INOUT STD_LOGIC;
		hps_io_hps_io_sdio_inst_D1		:	 INOUT STD_LOGIC;
		hps_io_hps_io_sdio_inst_CLK		:	 OUT STD_LOGIC;
		hps_io_hps_io_sdio_inst_D2		:	 INOUT STD_LOGIC;
		hps_io_hps_io_sdio_inst_D3		:	 INOUT STD_LOGIC;
		hps_io_hps_io_usb1_inst_D0		:	 INOUT STD_LOGIC;
		hps_io_hps_io_usb1_inst_D1		:	 INOUT STD_LOGIC;
		hps_io_hps_io_usb1_inst_D2		:	 INOUT STD_LOGIC;
		hps_io_hps_io_usb1_inst_D3		:	 INOUT STD_LOGIC;
		hps_io_hps_io_usb1_inst_D4		:	 INOUT STD_LOGIC;
		hps_io_hps_io_usb1_inst_D5		:	 INOUT STD_LOGIC;
		hps_io_hps_io_usb1_inst_D6		:	 INOUT STD_LOGIC;
		hps_io_hps_io_usb1_inst_D7		:	 INOUT STD_LOGIC;
		hps_io_hps_io_usb1_inst_CLK		:	 IN STD_LOGIC;
		hps_io_hps_io_usb1_inst_STP		:	 OUT STD_LOGIC;
		hps_io_hps_io_usb1_inst_DIR		:	 IN STD_LOGIC;
		hps_io_hps_io_usb1_inst_NXT		:	 IN STD_LOGIC;
		hps_io_hps_io_uart0_inst_RX		:	 IN STD_LOGIC;
		hps_io_hps_io_uart0_inst_TX		:	 OUT STD_LOGIC;
		master_memory_0_avalon_streaming_sink_data		:	 IN STD_LOGIC_VECTOR(63 DOWNTO 0);
		master_memory_0_avalon_streaming_sink_ready		:	 OUT STD_LOGIC;
		master_memory_0_dataaddress_out_startofpacket		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		master_memory_0_i_control_read		:	 IN STD_LOGIC;
		master_memory_0_i_control_write		:	 IN STD_LOGIC;
		master_memory_0_i_control_startaddress		:	 IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		master_memory_0_i_control_stopaddress		:	 IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		master_memory_0_source_data		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		master_memory_0_source_valid		:	 OUT STD_LOGIC;
		memory_mem_a		:	 OUT STD_LOGIC_VECTOR(14 DOWNTO 0);
		memory_mem_ba		:	 OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		memory_mem_ck		:	 OUT STD_LOGIC;
		memory_mem_ck_n		:	 OUT STD_LOGIC;
		memory_mem_cke		:	 OUT STD_LOGIC;
		memory_mem_cs_n		:	 OUT STD_LOGIC;
		memory_mem_ras_n		:	 OUT STD_LOGIC;
		memory_mem_cas_n		:	 OUT STD_LOGIC;
		memory_mem_we_n		:	 OUT STD_LOGIC;
		memory_mem_reset_n		:	 OUT STD_LOGIC;
		memory_mem_dq		:	 INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		memory_mem_dqs		:	 INOUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		memory_mem_dqs_n		:	 INOUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		memory_mem_odt		:	 OUT STD_LOGIC;
		memory_mem_dm		:	 OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		memory_oct_rzqin		:	 IN STD_LOGIC;
		reset_reset_n		:	 IN STD_LOGIC
	);
END COMPONENT;

COMPONENT Log_10
	PORT
	(
		csi_sink_clk		:	 IN STD_LOGIC;
		rsi_sink_reset		:	 IN STD_LOGIC;
		i_bit_index		:	 IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		o_bit_index		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		asi_sink_data		:	 IN STD_LOGIC_VECTOR(30 DOWNTO 0);
		aso_source_data		:	 OUT UNSIGNED(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT vector2hps
	GENERIC ( Data_Width : INTEGER := 32; Address_Width : INTEGER := 32; hps_address_base : STD_LOGIC_VECTOR(31 DOWNTO 0) := b"11111111111111110000000000000000" );
	PORT
	(
		i_data		:	 IN STD_LOGIC_VECTOR(data_width-1 DOWNTO 0);
		i_address		:	 IN STD_LOGIC_VECTOR(address_width-1 DOWNTO 0);
		o_data		:	 OUT STD_LOGIC_VECTOR(data_width+address_width-1 DOWNTO 0)
	);
END COMPONENT;

--COMPONENT write_data
--	GENERIC ( Data_Width : INTEGER := 31; Address_Width : INTEGER := 32 );
--	PORT
--	(
--		csi_clock_clk		:	 IN STD_LOGIC;
--		rsi_sink_reset_n		:	 IN STD_LOGIC;
--		o_data		:	 OUT STD_LOGIC_VECTOR(data_width-1 DOWNTO 0);
--		o_address		:	 OUT STD_LOGIC_VECTOR(address_width-1 DOWNTO 0)
--	);
--END COMPONENT;

COMPONENT FFT_main
	GENERIC ( FFT_Inverse : BIT := '0'; FFT_In_Data_Width : INTEGER := 16; FFT_Transform_Width : INTEGER := 14; FFT_Max_Transform_Width : INTEGER := 14;
		 FFT_TransformSize : INTEGER := 16384; MsbWidth : INTEGER := 32 );
	PORT
	(
		i_Switch		:	 IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		i_clk_50Mhz		:	 IN STD_LOGIC;
		i_reset_n		:	 IN STD_LOGIC;
		o_data		:	 OUT STD_LOGIC_VECTOR(30 DOWNTO 0);
		o_index		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL HPS_H2F_RST:STD_LOGIC;
signal dataaddress_out,siganl_address,siganl_address2 :std_logic_vector(31 downto 0);
signal source_data : std_LOGIC_VECTOR(31 dowNTO 0);
signal writedata : std_logic_vector(Data_Width+Address_Width-1 downto 0);
signal source_valid,ready,s_write : std_LOGIC;
signal pio_hps_ready,pio_fpga_ready :  STD_LOGIC_VECTOR(7 DOWNTO 0);
signal signal_log10_outdata : UNSIGNED(31 DOWNTO 0);
signal signal_log10_indata : STD_LOGIC_VECTOR(30 DOWNTO 0);
BEGIN

u0 : component soc_system4
        port map (
            clk_clk                         => FPGA_CLK1_50,                         --                     clk.clk
            reset_reset_n                   => '1',                   --                   reset.reset_n
            memory_mem_a                    => HPS_DDR3_ADDR,                    --                  memory.mem_a
            memory_mem_ba                   => HPS_DDR3_BA,                   --                        .mem_ba
            memory_mem_ck                   => HPS_DDR3_CK_P,                   --                        .mem_ck
            memory_mem_ck_n                 => HPS_DDR3_CK_N,                 --                        .mem_ck_n
            memory_mem_cke                  => HPS_DDR3_CKE,                  --                        .mem_cke
            memory_mem_cs_n                 => HPS_DDR3_CS_N,                 --                        .mem_cs_n
            memory_mem_ras_n                => HPS_DDR3_RAS_N,                --                        .mem_ras_n
            memory_mem_cas_n                => HPS_DDR3_CAS_N,                --                        .mem_cas_n
            memory_mem_we_n                 => HPS_DDR3_WE_N,                 --                        .mem_we_n
            memory_mem_reset_n              => HPS_DDR3_RESET_N,              --                        .mem_reset_n
            memory_mem_dq                   => HPS_DDR3_DQ,                   --                        .mem_dq
            memory_mem_dqs                  => HPS_DDR3_DQS_P,                  --                        .mem_dqs
            memory_mem_dqs_n                => HPS_DDR3_DQS_N,                --                        .mem_dqs_n
            memory_mem_odt                  => HPS_DDR3_ODT,                  --                        .mem_odt
            memory_mem_dm                   => HPS_DDR3_DM,                   --                        .mem_dm
            memory_oct_rzqin                => HPS_DDR3_RZQ,                --                        .oct_rzqin
            hps_0_h2f_reset_reset_n         => HPS_H2F_RST,         --         hps_0_h2f_reset.reset_n
            hps_io_hps_io_emac1_inst_TX_CLK => HPS_ENET_GTX_CLK, --                  hps_io.hps_io_emac1_inst_TX_CLK
            hps_io_hps_io_emac1_inst_TXD0   => HPS_ENET_TX_DATA(0),   --                        .hps_io_emac1_inst_TXD0
            hps_io_hps_io_emac1_inst_TXD1   => HPS_ENET_TX_DATA(1),   --                        .hps_io_emac1_inst_TXD1
            hps_io_hps_io_emac1_inst_TXD2   => HPS_ENET_TX_DATA(2),   --                        .hps_io_emac1_inst_TXD2
            hps_io_hps_io_emac1_inst_TXD3   => HPS_ENET_TX_DATA(3),   --                        .hps_io_emac1_inst_TXD3
            hps_io_hps_io_emac1_inst_RXD0   => HPS_ENET_RX_DATA(0),   --                        .hps_io_emac1_inst_RXD0
            hps_io_hps_io_emac1_inst_MDIO   => HPS_ENET_MDIO,   --                        .hps_io_emac1_inst_MDIO
            hps_io_hps_io_emac1_inst_MDC    => HPS_ENET_MDC,    --                        .hps_io_emac1_inst_MDC
            hps_io_hps_io_emac1_inst_RX_CTL => HPS_ENET_RX_DV, --                        .hps_io_emac1_inst_RX_CTL
            hps_io_hps_io_emac1_inst_TX_CTL => HPS_ENET_TX_EN, --                        .hps_io_emac1_inst_TX_CTL
            hps_io_hps_io_emac1_inst_RX_CLK => HPS_ENET_RX_CLK, --                        .hps_io_emac1_inst_RX_CLK
            hps_io_hps_io_emac1_inst_RXD1   => HPS_ENET_RX_DATA(1),   --                        .hps_io_emac1_inst_RXD1
            hps_io_hps_io_emac1_inst_RXD2   => HPS_ENET_RX_DATA(2),   --                        .hps_io_emac1_inst_RXD2
            hps_io_hps_io_emac1_inst_RXD3   => HPS_ENET_RX_DATA(3),   --                        .hps_io_emac1_inst_RXD3
            hps_io_hps_io_sdio_inst_CMD     => HPS_SD_CMD,     --                        .hps_io_sdio_inst_CMD
            hps_io_hps_io_sdio_inst_D0      => HPS_SD_DATA(0),      --                        .hps_io_sdio_inst_D0
            hps_io_hps_io_sdio_inst_D1      => HPS_SD_DATA(1),      --                        .hps_io_sdio_inst_D1
            hps_io_hps_io_sdio_inst_CLK     => HPS_SD_CLK,     --                        .hps_io_sdio_inst_CLK
            hps_io_hps_io_sdio_inst_D2      => HPS_SD_DATA(2),      --                        .hps_io_sdio_inst_D2
            hps_io_hps_io_sdio_inst_D3      => HPS_SD_DATA(3),      --                        .hps_io_sdio_inst_D3
            hps_io_hps_io_usb1_inst_D0      => HPS_USB_DATA(0),      --                        .hps_io_usb1_inst_D0
            hps_io_hps_io_usb1_inst_D1      => HPS_USB_DATA(1),      --                        .hps_io_usb1_inst_D1
            hps_io_hps_io_usb1_inst_D2      => HPS_USB_DATA(2),      --                        .hps_io_usb1_inst_D2
            hps_io_hps_io_usb1_inst_D3      => HPS_USB_DATA(3),      --                        .hps_io_usb1_inst_D3
            hps_io_hps_io_usb1_inst_D4      => HPS_USB_DATA(4),      --                        .hps_io_usb1_inst_D4
            hps_io_hps_io_usb1_inst_D5      => HPS_USB_DATA(5),      --                        .hps_io_usb1_inst_D5
            hps_io_hps_io_usb1_inst_D6      => HPS_USB_DATA(6),      --                        .hps_io_usb1_inst_D6
            hps_io_hps_io_usb1_inst_D7      => HPS_USB_DATA(7),      --                        .hps_io_usb1_inst_D7
            hps_io_hps_io_usb1_inst_CLK     => HPS_USB_CLKOUT,     --                        .hps_io_usb1_inst_CLK
            hps_io_hps_io_usb1_inst_STP     => HPS_USB_STP,     --                        .hps_io_usb1_inst_STP
            hps_io_hps_io_usb1_inst_DIR     => HPS_USB_DIR,     --                        .hps_io_usb1_inst_DIR
            hps_io_hps_io_usb1_inst_NXT     => HPS_USB_NXT,     --                        .hps_io_usb1_inst_NXT
            hps_io_hps_io_uart0_inst_RX     => HPS_UART_RX,     --                        .hps_io_uart0_inst_RX
            hps_io_hps_io_uart0_inst_TX     => HPS_UART_TX,
				master_memory_0_avalon_streaming_sink_data => writedata,
				master_memory_0_avalon_streaming_sink_ready => ready,
				master_memory_0_dataaddress_out_startofpacket => dataaddress_out,
				master_memory_0_i_control_read => '0',
				master_memory_0_i_control_write	=> '1',
				master_memory_0_i_control_startaddress => (others => '0'),	
				master_memory_0_i_control_stopaddress => "00000000000000010000000000000000",
				master_memory_0_source_data	=> source_data,
				master_memory_0_source_valid => source_valid,
				dma_0_i_controll_startaddress => (others => '0'),
				dma_0_i_controll_stopaddress => "00000000000000010000000000000000"
			
        );

	
u1 : component Log_10 
	port map(
		csi_sink_clk => FPGA_CLK1_50,
		rsi_sink_reset => '1',
		i_bit_index => siganl_address,
		o_bit_index => siganl_address2,
		asi_sink_data => signal_log10_indata,
		aso_source_data => signal_log10_outdata
		
	);	
	
u3 : component vector2hps
	port map(
		i_data => std_logic_vector(signal_log10_outdata),
		i_address => siganl_address2,
		o_data => writedata
	
	);

u4 : component FFT_main
	port map(
		
		i_Switch => "001100",	
		i_clk_50Mhz	=> FPGA_CLK1_50,	
		i_reset_n => '1',
		o_data => signal_log10_indata,
		o_index => siganl_address
	
	);
	
	
END MAIN;