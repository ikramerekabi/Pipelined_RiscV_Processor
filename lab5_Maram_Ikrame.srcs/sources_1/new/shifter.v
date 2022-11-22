`timescale 1ns / 1ps


module shifter(input [31:0]a, [4:0]shamt, [1:0]type, output reg  [31:0] r);

always @(*) begin
            
    if(type == 2'b00) // srl
      r = a >> shamt[4:0];
      //shamt[4:0];
  
    else if(type == 2'b01) // sll \
      //  r = a >> shamt[4:0];
        r= a << shamt[4:0];

    else if (type == 2'b10) //sra
       r = $signed (a[31:0])<<< shamt[4:0];
    
end     

endmodule
