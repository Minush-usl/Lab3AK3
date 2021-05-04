.syntax unified
.cpu cortex-m4
.thumb
#define a #2
#define b #2
#define c #3

.global vtable_kernel
.global kernel_reset

.type vtable_kernel, %object
.type kernel_reset, %function

.section .interrupt_vector
vtable_kernel:
  .word stack_start
  .word kernel_reset+1
  .size vtable_kernel, .-vtable_kernel

.section .rodata
  data: .asciz "kernel started!\n"
  final: .asciz "Value in register r3: "
.section .text
__kernel_reset:
     ldr r0, =data
  bl dbgput_line
    
  mov r3, a       
  mov r4, b       
  mov r5, c       
  add r3, r4      
  lsr r3, r3, #1      
  mov r6, #1          
  factorial:
    cmp r5, #1       
    beq sum
    mul r6, r5      
    sub r5, #1      
    bne factorial  
  sum:
    add r3, r6
        
  ldr r0, =final
  bl dbgput
  mov r0, r3
  bl dbgput_num
    
  end:
  b end
