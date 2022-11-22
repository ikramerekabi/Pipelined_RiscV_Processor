`include "defines.vh"
`timescale 1ns / 1ps


module ALU_Control_Unit(input  [1:0] ALUop, input  [2:0]inst14_12 , input inst30, output reg [3:0] ALUselc );


always @(*)
 begin 
 if( ALUop == 0) // store and load instructions
 begin
    
   ALUselc = 4'b0010;  
 end 
 if( ALUop == 1)// beq 
 begin
   ALUselc= 4'b0110;  
 end 
 if( ALUop == 2)// for R types
 begin
   if(inst14_12 == 0 )// for add and sub 
   begin
   if (inst30 ==0 )// add
       begin
       ALUselc = `ALU_ADD;  
       end 
       else begin   //sub
         ALUselc =  `ALU_SUB;  

       end 
   end 
   else if(inst14_12 == 3'b111) // and inst
       begin 
       if (inst30 ==0)
         begin 
            ALUselc= `ALU_AND; 
         end
       end  
       
   else if (inst14_12 == 3'b110) // or inst 
       begin 
       if (inst30 ==0)
         begin 
            ALUselc= `ALU_OR; 
         end
       end  
   else if (inst14_12 == 3'b001) // sll 
       begin 
       if (inst30 ==0)
         begin 
            ALUselc=  `ALU_SLL ; 
         end
       end 
    else if (inst14_12 == 3'b010) // slt
       begin 
       if (inst30 ==0)
         begin 
            ALUselc=  `ALU_SLT ; 
         end
       end   
     else if (inst14_12 == 3'b011) // sltu
       begin 
       if (inst30 ==0)
         begin 
            ALUselc=  `ALU_SLTU  ; 
         end
       end   
    else if (inst14_12 == 3'b100) // xor
       begin 
       if (inst30 ==0)
         begin 
            ALUselc=   `ALU_XOR  ; 
         end
       end   
    else if(inst14_12 == 3'b101 )//   srl & sra
        begin
        if (inst30 ==0 )// srl 
            begin
            ALUselc= `ALU_SRL ;  
            end 
            else begin   // sra
              ALUselc= `ALU_SRA;  

            end 
        end 
   if (ALUop == 3 )
       begin 
       
        ALUselc= `ALU_JAL;  // is this right ? // why is ALU_JAL being undefined ?????
       
       end    
       
       
       
 end 
 
end
endmodule
