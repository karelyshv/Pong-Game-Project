/* #/* ###################################################################
**     Filename    : main.c
**     Project     : ADC
**     Processor   : MC9S08QE128CLK
**     Version     : Driver 01.12
**     Compiler    : CodeWarrior HCS08 C Compiler
**     Date/Time   : 2018-01-27, 23:34, # CodeGen: 0
**     Abstract    :
**         Main module.
**         This module contains user's application code.
**     Settings    :
**     Contents    :
**         No public methods
**
** ###################################################################*/
/*!
** @file main.c
** @version 01.12
** @brief
**         Main module.
**         This module contains user's application code.
*/         
/*!
**  @addtogroup main_module main module documentation
**  @{
*/         
/* MODULE main */


/* Including needed modules to compile this module/procedure */
#include "Cpu.h"
#include "Events.h"
#include "AS1.h"
#include "AD1.h"
#include "Bit1.h"
#include "TI1.h"
#include "Cap1.h"
#include "Bit2.h"
/* Include shared modules, which are used for whole project */
#include "PE_Types.h"
#include "PE_Error.h"
#include "PE_Const.h"
#include "IO_Map.h"

/* User includes (#include below this line is not maintained by Processor Expert) */

unsigned char estado = ESPERAR;
unsigned char CodError;
unsigned int Enviados = 3;    // Esta variable no aporta nada más sino el número de elementos del arreglo a enviar.

typedef union{
unsigned char u8[3];
unsigned int u16;
}AMPLITUD;

volatile AMPLITUD iADC, Senal;

unsigned int Marcador = 0xF1;
unsigned int D1 = 0;
unsigned int D2 = 0;
unsigned int A = 0;
unsigned int B = 0;

void main(void)
{
  /* Write your local variable definition here */

	
	
  /*** Processor Expert internal initialization. DON'T REMOVE THIS CODE!!! ***/
  PE_low_level_init();
  /*** End of Processor Expert internal initialization.                    ***/

  /* Write your code here */
  /* For example: for(;;) { } */
  
  for(;;){

    switch (estado){
      
      case ESPERAR:
        break;
        
      case MEDIR:
        CodError = AD1_Measure(TRUE);
        CodError = AD1_GetValue16(&iADC.u16);
        if ( Bit1_GetVal() == 0){
        	D1 = 1;
        }
        if (Bit2_GetVal() == 0){
        	D2 = 1;
        }
        
        estado = ENVIAR;
        break;
    
      case ENVIAR:
    	  
   		B = iADC.u16 & 0x7F;
    	A = (iADC.u16 >> 7) & 0x1F;
     	if(D1 == 1)
   		{
   			A = A | 0x40; // or con 01000000
   			D1 = 0;
   		}
   		if(D2 == 1)
    	{
    		A = A | 0x20; // or con 00100000
    		D2 = 0;
   		}

   	    Senal.u8[0] = Marcador;
   	 	Senal.u8[1] = A;
  	 	Senal.u8[2] = B;
      
      
      // ENVIAR SOLO LA MEDICIÓN DE 16 BITS SIN TRAMA NI PROTOCOLO:
        
        CodError = AS1_SendBlock(Senal.u8,3,&Enviados); //El arreglo con la medición está en iADC.u8 (notar que es un apuntador)
        estado = ESPERAR;
        
        break;
        
      default:
        break;
    
    }
  }

  /*** Don't write any code pass this line, or it will be deleted during code generation. ***/
  /*** RTOS startup code. Macro PEX_RTOS_START is defined by the RTOS component. DON'T MODIFY THIS CODE!!! ***/
  #ifdef PEX_RTOS_START
    PEX_RTOS_START();                  /* Startup of the selected RTOS. Macro is defined by the RTOS component. */
  #endif
  /*** End of RTOS startup code.  ***/
  /*** Processor Expert end of main routine. DON'T MODIFY THIS CODE!!! ***/
  for(;;){}
  /*** Processor Expert end of main routine. DON'T WRITE CODE BELOW!!! ***/
} /*** End of main routine. DO NOT MODIFY THIS TEXT!!! ***/

/* END main */
/*!
** @}
*/
/*
** ###################################################################
**
**     This file was created by Processor Expert 10.3 [05.09]
**     for the Freescale HCS08 series of microcontrollers.
**
** ###################################################################
*/
