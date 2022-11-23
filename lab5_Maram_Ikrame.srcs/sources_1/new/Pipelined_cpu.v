`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2022 10:25:52 PM
// Design Name: 
// Module Name: Pipelined_cpu
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


module Pipelined_cpu(input rst, input clk, input [1:0]ledSel, input [3:0] ssdSel, input SSD_Clock, output  [15:0] leds_16_SSD, output  [3:0] Anode, output  [6:0] LED_out );

wire [12:0] ssd_13;
Single_Cycle_CPU inst1( rst,  clk, ledSel, ssdSel, leds_16_SSD, ssd_13 );
SSD_seven_segment_display inst2(SSD_Clock, ssd_13,  Anode, LED_out);


    
    
    
    
    
    
    
    
    
   
endmodule