`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 07:41:30 PM
// Design Name: 
// Module Name: Forwarding_unit
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


module Forwarding_unit(input [4:0] ID_EX_RegRs1, ID_EX_RegRs2, EX_MEM_RegRd,  MEM_WB_RegRd,input  EX_MEM_RegWrite, MEM_Wb_RegWrite,
    output reg [1:0] forwardA, forwardB);


    always @(*)
    begin
        //if(EX_MEM_RegWrite &&(EX_MEM_RegRd != 0) && (EX_MEM_RegRd == ID_EX_RegRs1))
          //  forwardA = 2'b10;
        //else 
        if (MEM_Wb_RegWrite &&(MEM_WB_RegRd !=0 )&& (MEM_WB_RegRd == ID_EX_RegRs1))
            forwardA = 2'b01;
        else
            forwardA =0;

    end

    always @(*)
    begin
       // if(EX_MEM_RegWrite &&(EX_MEM_RegRd != 0)&&(EX_MEM_RegRd ==ID_EX_RegRs2))
         //   forwardB = 2'b10;
        //else 
        if(MEM_Wb_RegWrite && (MEM_WB_RegRd !=0)&&(MEM_WB_RegRd == ID_EX_RegRs2))
            forwardB = 2'b01;
        else
            forwardB =0;



    end
endmodule

