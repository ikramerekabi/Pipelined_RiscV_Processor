`include "defines.vh"
`timescale 1ns / 1ps


module ALU_Control_Unit(input  [1:0] ALUop, input [4:0]opcode, input  [2:0]inst14_12 ,  input inst30, output reg [3:0] ALUselc, output reg I_instruction_flag );


    always @(*)
    begin
        if( ALUop == 0) // store and load instructions
        begin

            ALUselc = 4'b0010;
            I_instruction_flag =0; 
        end
        if( ALUop == 1) // beq 
        begin
            ALUselc= 4'b0110;
            I_instruction_flag =0; 

        end
        if( ALUop == 2) // for R types
        begin
            if(inst14_12 == 0 ) // for add and sub 
                begin
                    if(opcode == `OPCODE_Arith_I)
                        begin
                            ALUselc = `ALU_ADD;
                            I_instruction_flag =0; 

                        end
                    else if(opcode ==`OPCODE_Arith_R)
                    begin
                        if (inst30 ==0 ) // add
                            begin
                                ALUselc = `ALU_ADD;
                                I_instruction_flag =0; 
                            end
                        else begin //sub
                            ALUselc =  `ALU_SUB;
                            I_instruction_flag =0; 
                        end
                    end
                end
            else if(inst14_12 == 3'b111) // and inst
                begin
                if(opcode == `OPCODE_Arith_I) // andi
                begin
                ALUselc= `ALU_AND;
                end
                else if(opcode == `OPCODE_Arith_R) // and
                begin
                    if (inst30 ==0)
                    begin
                        ALUselc= `ALU_AND;
                        I_instruction_flag =0; 
                    end
                end
            end
            else if (inst14_12 == 3'b110) // or inst 
                begin
                    if (inst30 ==0)
                    begin
                        ALUselc= `ALU_OR;
                        I_instruction_flag =0; 
                    end
                end
            else if (inst14_12 == 3'b001) // sll  & slli 
                begin
                if(opcode == `OPCODE_Arith_I) // slli
                begin
                    if (inst30 ==0)
                    begin
                        ALUselc=  `ALU_SLL ;
                        I_instruction_flag =1; 
                    end
                end
                else if(opcode == `OPCODE_Arith_R)
                begin 
                 if (inst30 ==0)
                    begin
                        ALUselc=  `ALU_SLL ;
                        I_instruction_flag =0; 
                    end
                end
                end 
            else if (inst14_12 == 3'b010) // slt
                begin
                    if (inst30 ==0)
                    begin
                        ALUselc=  `ALU_SLT ;
                        I_instruction_flag =0; 
                        
                    end
                end
            else if (inst14_12 == 3'b011) // sltu
                begin
                    if (inst30 ==0)
                    begin
                        ALUselc=  `ALU_SLTU  ;
                        I_instruction_flag =0; 
                    end
                end
            else if (inst14_12 == 3'b100) // xor
                begin
                    
                    //if (inst30 ==0)
                    //begin
                        ALUselc=   `ALU_XOR  ;
                        I_instruction_flag =0; 
                    //end
                end
            else if(inst14_12 == 3'b101 ) //   srl & sra & srli & srai 
            begin
            if(opcode == `OPCODE_Arith_I)
            begin
            if (inst30 ==0 ) // srli 
                    begin
             ALUselc= `ALU_SRL ;
             I_instruction_flag =1; 
             end
                 else begin // srai
                 I_instruction_flag =1; 
                    ALUselc= `ALU_SRA;

                end

            end
            else if(opcode == `OPCODE_Arith_R)
            begin
                if (inst30 ==0 ) // srl 
                    begin
                        ALUselc= `ALU_SRL ;
                        I_instruction_flag =0; 
                    end
                else begin // sra
                    ALUselc= `ALU_SRA;
                    I_instruction_flag =0;

                end
            end
            end
            if (ALUop == 3 )
            begin

                ALUselc= `ALU_JAL; // is this right ? 

            end



        end

    end
endmodule
