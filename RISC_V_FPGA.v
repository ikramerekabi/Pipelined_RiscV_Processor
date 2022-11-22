`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2022 01:22:26 PM
// Design Name: 
// Module Name: RISC_V_FPGA
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
 
// ledsel1 is j15
// ledsel2 is L16
// ssdSel[0] M13
// ssdSel[1] R15
// ssdSel[2] R17
// ssdSel[3] T18
module RISC_V_FPGA(input rst, input clk, input [1:0]ledSel, input [3:0] ssdSel, input SSD_Clock, output  [15:0] leds_16_SSD, output  [3:0] Anode, output  [6:0] LED_out );

wire [12:0] ssd_13;
Single_Cycle_CPU inst1( rst,  clk, ledSel, ssdSel, leds_16_SSD, ssd_13 );
SSD_seven_segment_display inst2(SSD_Clock, ssd_13,  Anode, LED_out);


    
    
    
    
    
    
    
    
    
   
endmodule
