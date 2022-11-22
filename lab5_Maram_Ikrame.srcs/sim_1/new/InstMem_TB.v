`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2022 05:57:20 PM
// Design Name: 
// Module Name: InstMem_TB
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


module InstMem_TB();
reg [5:0] addr;
wire [31:0] data_out;
InstMem inst1( addr, data_out);

initial begin 
addr= 6'b000001;
#10;
addr= 6'b000010;
#10;
addr= 6'b000000;
#10;

end

endmodule
