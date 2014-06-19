#include <stdint.h>

#define LPC_AHB_BASE          (0x50000000UL)
#define LPC_GPIO0_BASE        (LPC_AHB_BASE  + 0x00000)
#define LPC_GPIO0_DIR        (LPC_GPIO0_BASE + 0x8000)
#define LPC_GPIO0_DATA       (LPC_GPIO0_BASE + 0x3FFC)


int main(void){
	*(volatile uint32_t *)LPC_GPIO0_DIR = 0x01 << 0;
	*(volatile uint32_t *)LPC_GPIO0_DATA = 0x01 << 0;

    while(1);
}