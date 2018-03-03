/* ###################################################################
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
#include "Bit2.h"
#include "TI1.h"
#include "Cap1.h"
/* Include shared modules, which are used for whole project */
#include "PE_Types.h"
#include "PE_Error.h"
#include "PE_Const.h"
#include "IO_Map.h"

/* User includes (#include below this line is not maintained by Processor Expert) */

unsigned char estado = ESPERAR;
unsigned int Enviados = 2;    //Número de elementos del arreglo a enviar

typedef union{
unsigned char u8[2];
unsigned int u16;
}AMPLITUD;

volatile AMPLITUD iADC;

unsigned char Senal[3]={0xF1,0x00,0x00};  
bool D1, D2;

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
        AD1_Measure(TRUE);
        AD1_GetValue16(&iADC.u16);		//Lee señal analógica
        D1 = Bit1_GetVal();				//Lee señal digital 1
		D2 = Bit2_GetVal();				//Lee señal digiral 2
        estado = ENVIAR;
        break;
    
      case ENVIAR:
    	  
   		Senal[2] = (iADC.u16 >> 4) & 0x7F;   			// Selecciono 0A7A6A5A4A3A2A1 , 7 bits de señal analógica menos significativos
   		Senal[1] = (iADC.u16 >> 11) & 0x1F;		// Selecciono 000A12A11A10A9A8 , 5 bits señal analógica más significativos
     	if(D1 == 0)
   		{
     		Senal[1] = Senal[1] | 0x40; 		// or con 01000000 = 0[1]D2A12A11A10A9A8
   		}
   		if(D2 == 0)
    	{
   			Senal[1] = Senal[1] | 0x20; 		// or con 00100000 = 0D1[1]A12A11A10A9A8
   		}
    
        AS1_SendBlock(Senal,3,&Enviados); 		//Se envia por serial arreglo de tres bytes con el protocolo aplicado
  	 	        
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
