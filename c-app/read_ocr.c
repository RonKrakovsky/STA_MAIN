#define soc_cv_av 
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h> 
#include <sys/mman.h> 
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <stdint.h>

#define HPS_FPGA_BRIDGE_BASE 0xC0000000
#define HW_REGS_BASE ( HPS_FPGA_BRIDGE_BASE )
#define HW_REGS_SPAN ( 0x40000000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )

//Address of the HPS-OCR, as seen by both processor and FPGA-DMAC
#define HPS_OCR_ADDRESS 0xFFFF0000


uint32_t* virtual_base;
int fd;
int data;

int main (){
	void *virtual_base;
	int fd;
	if( ( fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1 ) {
		printf( "ERROR: could not open \"/dev/mem\"...\n" );
		return( 1 );
	} 
	//mmap from 0xC0000000 to 0xFFFFFFFF (1GB): FPGA and HPS peripherals
	virtual_base = mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, HW_REGS_BASE );
	
	if( virtual_base == MAP_FAILED ) {
		printf( "ERROR: mmap() failed...\n" );
		close( fd );
		return( 1 );
	}
	
	// Config start address of On Chip Memory
	void *HPS_OCR_vaddr_void = virtual_base + ((unsigned long)(HPS_OCR_ADDRESS-HPS_FPGA_BRIDGE_BASE) & (unsigned long)( HW_REGS_MASK ));
	uint8_t* HPS_OCR_vaddr = (uint8_t *) HPS_OCR_vaddr_void;
	
	// On Chip Memory in HPS 
	uint32_t* hps_ocr_ptr = (uint32_t*)HPS_OCR_vaddr;
	int i;
    uint32_t num2;
  	for (i=0; i<65536/4; i++)
	{
        num2 = *(hps_ocr_ptr);
        hps_ocr_ptr++;
        printf(" address %d : %d\n", i, num2);
	}
	printf("Check HPS On-Chip RAM OK\n");
	
return 0;


}