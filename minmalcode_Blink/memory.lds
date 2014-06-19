
/*
 * Software License Agreement (BSD License)
 *
 * Copyright (c) 2010, Roel Verdult
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 1. Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 * 3. Neither the name of the copyright holders nor the
 * names of its contributors may be used to endorse or promote products
 * derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ''AS IS'' AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 *  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */


OUTPUT_ARCH(arm)
ENTRY(_start)


/* RAMの最初は割り込みベクタなどが書かれるので、最初を後ろにずらす */

MEMORY
{
    flash(rx): ORIGIN = 0x00000000, LENGTH = 32K
    sram(rwx): ORIGIN = 0x10000000, LENGTH = 4K
}

sram_top = ORIGIN(sram) + LENGTH(sram);

SECTIONS
{

    .text : ALIGN(4)
    {
      KEEP(*(.irq_vectors))
      /* . = 0x00006000; */
      *(.text*) 
      *(.rodata*)
     } > flash

    .ARM.extab : { *(.ARM.extab* .gnu.linkonce.armextab.*) } > flash
    __exidx_start = .;
    .ARM.exidx : { *(.ARM.exidx* .gnu.linkonce.armexidx.*) } > flash
    __exidx_end = .;


    .data : AT (__exidx_end)
    {
      _data = .;
      *(vtable)
      *(.data*)
      _edata = .;
    } > sram
  
    __bss_start = . ;
    /* zero initialized data */
    .bss :
    {
      *(.bss*)
      *(COMMON)
    } > sram

    __bss_end = . ;

    /* For GDB compatibility we decrease the top with 16 bytes */
    stack_entry = sram_top - 16;
}