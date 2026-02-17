/* Startup file for STM32F401xE */
.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.thumb

.global g_pfnVectors
.global Default_Handler

.word _sidata
.word _sdata
.word _edata
.word _sbss
.word _ebss

/* Vector Table */
.section .isr_vector,"a",%progbits
    .type g_pfnVectors, %object
    .size g_pfnVectors, .-g_pfnVectors

g_pfnVectors:
    .word _estack
    .word Reset_Handler
    .word NMI_Handler
    .word HardFault_Handler
    .word MemManage_Handler
    .word BusFault_Handler
    .word UsageFault_Handler
    .word 0
    .word 0
    .word 0
    .word 0
    .word SVC_Handler
    .word DebugMon_Handler
    .word 0
    .word PendSV_Handler
    .word SysTick_Handler

/* External Interrupts */
    .word WWDG_IRQHandler
    .word PVD_IRQHandler
    .word TAMP_STAMP_IRQHandler
    .word RTC_WKUP_IRQHandler
    .word FLASH_IRQHandler
    .word RCC_IRQHandler
    .word EXTI0_IRQHandler
    .word EXTI1_IRQHandler
    .word EXTI2_IRQHandler
    .word EXTI3_IRQHandler
    .word EXTI4_IRQHandler
    .word DMA1_Stream0_IRQHandler
    .word DMA1_Stream1_IRQHandler
    .word DMA1_Stream2_IRQHandler
    .word DMA1_Stream3_IRQHandler
    .word DMA1_Stream4_IRQHandler
    .word DMA1_Stream5_IRQHandler
    .word DMA1_Stream6_IRQHandler
    .word ADC_IRQHandler
    .word 0
    .word 0
    .word 0
    .word 0
    .word EXTI9_5_IRQHandler
    .word TIM1_BRK_TIM9_IRQHandler
    .word TIM1_UP_TIM10_IRQHandler
    .word TIM1_TRG_COM_TIM11_IRQHandler
    .word TIM1_CC_IRQHandler
    .word TIM2_IRQHandler
    .word TIM3_IRQHandler
    .word TIM4_IRQHandler
    .word I2C1_EV_IRQHandler
    .word I2C1_ER_IRQHandler
    .word I2C2_EV_IRQHandler
    .word I2C2_ER_IRQHandler
    .word SPI1_IRQHandler
    .word SPI2_IRQHandler
    .word USART1_IRQHandler
    .word USART2_IRQHandler
    .word 0
    .word EXTI15_10_IRQHandler
    .word RTC_Alarm_IRQHandler
    .word OTG_FS_WKUP_IRQHandler
    .word 0
    .word 0
    .word 0
    .word 0
    .word DMA1_Stream7_IRQHandler
    .word 0
    .word SDIO_IRQHandler
    .word TIM5_IRQHandler
    .word SPI3_IRQHandler
    .word 0
    .word 0
    .word DMA2_Stream0_IRQHandler
    .word DMA2_Stream1_IRQHandler
    .word DMA2_Stream2_IRQHandler
    .word DMA2_Stream3_IRQHandler
    .word DMA2_Stream4_IRQHandler
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word OTG_FS_IRQHandler
    .word DMA2_Stream5_IRQHandler
    .word DMA2_Stream6_IRQHandler
    .word DMA2_Stream7_IRQHandler
    .word USART6_IRQHandler
    .word I2C3_EV_IRQHandler
    .word I2C3_ER_IRQHandler
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word 0
    .word RNG_IRQHandler
    .word FPU_IRQHandler

/* Reset Handler */
.section .text.Reset_Handler
    .weak Reset_Handler
    .type Reset_Handler, %function

Reset_Handler:
    ldr sp, =_estack
    movs r1, #0
    b LoopCopyDataInit

CopyDataInit:
    ldr r3, =_sidata
    ldr r3, [r3, r1]
    str r3, [r0, r1]
    adds r1, r1, #4

LoopCopyDataInit:
    ldr r0, =_sdata
    ldr r3, =_edata
    adds r2, r0, r1
    cmp r2, r3
    bcc CopyDataInit
    ldr r2, =_sbss
    b LoopFillZerobss

FillZerobss:
    movs r3, #0
    str r3, [r2]
    adds r2, r2, #4

LoopFillZerobss:
    ldr r3, = _ebss
    cmp r2, r3
    bcc FillZerobss

    bl SystemInit
    bl main

LoopForever:
    b LoopForever

.size Reset_Handler, .-Reset_Handler

/* Default Handler */
.section .text.Default_Handler,"ax",%progbits
Default_Handler:
Infinite_Loop:
    b Infinite_Loop
    .size Default_Handler, .-Default_Handler

/* Macro for exception handlers */
.macro HANDLER name
.weak \name
.set \name, Default_Handler
.endm

HANDLER NMI_Handler
HANDLER HardFault_Handler
HANDLER MemManage_Handler
HANDLER BusFault_Handler
HANDLER UsageFault_Handler
HANDLER SVC_Handler
HANDLER DebugMon_Handler
HANDLER PendSV_Handler
HANDLER SysTick_Handler
HANDLER WWDG_IRQHandler
HANDLER PVD_IRQHandler
HANDLER TAMP_STAMP_IRQHandler
HANDLER RTC_WKUP_IRQHandler
HANDLER FLASH_IRQHandler
HANDLER RCC_IRQHandler
HANDLER EXTI0_IRQHandler
HANDLER EXTI1_IRQHandler
HANDLER EXTI2_IRQHandler
HANDLER EXTI3_IRQHandler
HANDLER EXTI4_IRQHandler
HANDLER DMA1_Stream0_IRQHandler
HANDLER DMA1_Stream1_IRQHandler
HANDLER DMA1_Stream2_IRQHandler
HANDLER DMA1_Stream3_IRQHandler
HANDLER DMA1_Stream4_IRQHandler
HANDLER DMA1_Stream5_IRQHandler
HANDLER DMA1_Stream6_IRQHandler
HANDLER ADC_IRQHandler
HANDLER EXTI9_5_IRQHandler
HANDLER TIM1_BRK_TIM9_IRQHandler
HANDLER TIM1_UP_TIM10_IRQHandler
HANDLER TIM1_TRG_COM_TIM11_IRQHandler
HANDLER TIM1_CC_IRQHandler
HANDLER TIM2_IRQHandler
HANDLER TIM3_IRQHandler
HANDLER TIM4_IRQHandler
HANDLER I2C1_EV_IRQHandler
HANDLER I2C1_ER_IRQHandler
HANDLER I2C2_EV_IRQHandler
HANDLER I2C2_ER_IRQHandler
HANDLER SPI1_IRQHandler
HANDLER SPI2_IRQHandler
HANDLER USART1_IRQHandler
HANDLER USART2_IRQHandler
HANDLER EXTI15_10_IRQHandler
HANDLER RTC_Alarm_IRQHandler
HANDLER OTG_FS_WKUP_IRQHandler
HANDLER DMA1_Stream7_IRQHandler
HANDLER SDIO_IRQHandler
HANDLER TIM5_IRQHandler
HANDLER SPI3_IRQHandler
HANDLER DMA2_Stream0_IRQHandler
HANDLER DMA2_Stream1_IRQHandler
HANDLER DMA2_Stream2_IRQHandler
HANDLER DMA2_Stream3_IRQHandler
HANDLER DMA2_Stream4_IRQHandler
HANDLER OTG_FS_IRQHandler
HANDLER DMA2_Stream5_IRQHandler
HANDLER DMA2_Stream6_IRQHandler
HANDLER DMA2_Stream7_IRQHandler
HANDLER USART6_IRQHandler
HANDLER I2C3_EV_IRQHandler
HANDLER I2C3_ER_IRQHandler
HANDLER RNG_IRQHandler
HANDLER FPU_IRQHandler
