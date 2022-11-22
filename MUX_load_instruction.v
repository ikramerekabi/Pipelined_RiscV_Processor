`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2022 12:16:17 AM
// Design Name: 
// Module Name: MUX_load_instruction
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


module MUX_load_instruction(input [6:0]opcode_load, input [2:0] load_fn3, input [31:0] data_in, output reg [31:0]   mux_load_inst_output);

always @(*)

begin
if(opcode_load == 5'b00000 )
begin
    case(load_fn3)
        `F3_LB : mux_load_inst_output = {mux_load_inst_output[31], data_in[7:0]};
        `F3_LH : mux_load_inst_output = {mux_load_inst_output[31], data_in[15:0]};
        `F3_LW : mux_load_inst_output = data_in;
        `F3_lBU: mux_load_inst_output = {24'd0, data_in[7:0]};
        `F3_LHU: mux_load_inst_output = {24'd0, data_in[7:0]};
         default : mux_load_inst_output = data_in; /// default value ?
    endcase
end
else 
mux_load_inst_output = data_in;

end
endmodule
