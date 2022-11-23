module prv32_ALU(
	input   wire [31:0] a, b,
	input   wire [4:0]  shamt,
	output  reg  [31:0] r,
	output  wire cf, zf, vf, sf,
	input   wire [3:0]  alufn,
	input I_instruction_flag
);

    wire [31:0] add, op_b;
    
    assign op_b = (~b);
    
    assign {cf, add} = alufn[0] ? (a + op_b + 1'b1) : (a + b);
    
    assign zf = (a-b == 0);//it was add
    assign sf = add[31];
    assign vf = (a[31] ^ (op_b[31]) ^ add[31] ^ cf);
    
    wire[31:0] sh;
   // assign r = I_instruction_flag ?():();
    //shifter shifter0(.a(a), .shamt(shamt), .type(alufn[1:0]),  .r(shift_I)); // to be changed 
    shifter shifter0(.a(a), .shamt_R(b), .shamt(shamt),.I_inst_flag(I_instruction_flag) ,.type(alufn[1:0]),  .r(sh)); // to be changed 
    //shifter(input [31:0]a, input [31:0] shamt_R, input I_inst_flag, [4:0]shamt, [1:0]type, output reg  [31:0] r);
    
    always @ * begin
        r = 0;
        (* parallel_case *)
        case (alufn)
            // arithmetic
            4'b00_00 : r = add;
            4'b00_01 : r = add;
            4'b00_11 : r = b;
            // logic
            4'b01_00:  r = a | b;
            4'b01_01:  r = a & b;
            4'b01_11:  r = a ^ b;
            // shift
            4'b10_00:  r=sh; // srl 
            4'b10_01:  r=sh;  // sll 
            4'b10_10:  r=sh;  //sra
            // slt & sltu
            4'b11_01:  r = {31'b0,(sf != vf)}; 
            4'b11_11:  r = {31'b0,(~cf)};  
            //lw and sw 
            4'b00_10:    r = add; //lw        	
            4'b01_10:    r = a-b; //branching 
            4'b10_11:    r = b; // jal 
          
        endcase
    end
endmodule