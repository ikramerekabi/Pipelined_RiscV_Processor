`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2022 12:59:07 AM
// Design Name: 
// Module Name: load_inst_contr
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


module load_inst_contr(input [4:0]opcode_load, input [2:0] load_fn3, input [31:0] data_in, output reg [31:0]   load_inst_contr_output);

always @(*)

begin
if(opcode_load == 5'b00000)
begin
    case(load_fn3)
        `F3_LB : load_inst_contr_output = data_in[7]? {24'hFFFFFF, data_in[7:0]}: {24'd0, data_in[7:0]} ;
        `F3_LB : load_inst_contr_output = data_in[7]? {24'hFFFFFF, data_in[7:0]}: {24'd0, data_in[7:0]} ;
        `F3_LH : load_inst_contr_output = data_in[15]? {16'hFFFF, data_in[15:0]}: {24'd0, data_in[15:0]}; 
        `F3_LW : load_inst_contr_output = data_in;
        `F3_lBU: load_inst_contr_output = {24'd0, data_in[7:0]};
        `F3_LHU: load_inst_contr_output = {24'd0, data_in[7:0]};
         default : load_inst_contr_output = data_in; /// default value ?
    endcase
end
else 
load_inst_contr_output = data_in;

end
endmodule