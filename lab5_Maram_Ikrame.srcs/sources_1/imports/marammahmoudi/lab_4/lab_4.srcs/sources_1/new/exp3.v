`timescale 1ns / 1ps


module Control_Unit( input [4:0] inst6_2, input inst_20, output reg branch, output reg memRead,  output reg memtoReg,
    output reg [1:0] ALUop, output reg memWrite, output reg ALUsrc, output reg regWrite, output reg[1:0] jal_jalr , output reg  AUIPC,  output reg [1:0] RF_select, output reg load_ctrl,
    output reg hard_reset);

    always @(*)
    begin
        if(inst6_2 == `OPCODE_Arith_R ) //R format 
            begin
                branch= 0;
                memRead= 0;
                memtoReg= 0;
                ALUop = 2'b10;
                memWrite = 0;
                ALUsrc = 0;
                regWrite=1;
                jal_jalr=0;
                AUIPC = 0;
                load_ctrl =1;
                hard_reset = 0;
            end
        else if (inst6_2 == `OPCODE_FENCE || (inst6_2 == `OPCODE_SYSTEM && inst_20 == 0)) begin
            branch= 0;
            memRead= 0;
            memtoReg= 0;
            ALUop = 0;
            memWrite = 0;
            ALUsrc = 0;
            regWrite=0;
            jal_jalr=0;
            AUIPC = 0;
            load_ctrl = 1;
            hard_reset = 1;            
        end
        else if (inst6_2 == `OPCODE_SYSTEM) begin
            branch= 0;
            memRead= 0;
            memtoReg= 0;
            ALUop = 0;
            memWrite = 0;
            ALUsrc = 0;
            regWrite=0;
            jal_jalr=0;
            AUIPC = 0;
            load_ctrl = 0;
            hard_reset = 0;
        end
        else if (inst6_2 == `OPCODE_LUI) begin
            branch = 0;
            memRead= 0;
            memtoReg= 0;
            ALUop = 2'b11;
            memWrite = 0;
            ALUsrc = 1;
            regWrite= 1;
            jal_jalr=0;
            AUIPC = 0;
            load_ctrl =1;
            hard_reset = 0;
        end
        else  if(inst6_2 ==`OPCODE_Load ) //lw 

            begin
                branch= 0;
                memRead= 1;
                memtoReg= 1;
                ALUop = 2'b00;
                memWrite = 0;
                ALUsrc = 1;
                regWrite= 1;
                jal_jalr=0;
                AUIPC = 0;
                load_ctrl =1;
                hard_reset = 0;
            end

        else  if(inst6_2 ==`OPCODE_Store ) //sw 

            begin
                branch= 0;
                memRead= 0;
                memtoReg= 1;
                ALUop = 2'b00;
                memWrite = 1;
                ALUsrc = 1;
                regWrite= 0;
                jal_jalr=0;
                AUIPC = 0;
                load_ctrl =1;
                hard_reset = 0;

            end

        else  if(inst6_2 ==`OPCODE_Branch ) // branch instructions

            begin
                branch= 1;
                memRead= 0;
                memtoReg= 1;
                ALUop = 2'b01;
                memWrite = 0;
                ALUsrc = 0;
                regWrite= 0;
                jal_jalr=0;
                AUIPC = 0;
                load_ctrl =1;
                hard_reset = 0;
            end

        else  if(inst6_2 == `OPCODE_Arith_I ) // arithmatic i instructions

            begin
                branch= 0;
                memRead= 0;
                memtoReg= 0;
                ALUop = 2'b10;
                memWrite = 0;
                ALUsrc = 1;
                regWrite= 1;
                jal_jalr=0;
                AUIPC = 0;
                load_ctrl =1;
                hard_reset = 0;
        end


        else  if(inst6_2 ==  `OPCODE_JALR ) // jalr  // we need to add jal and jalr

            begin
                branch= 0;
                memRead= 0;
                memtoReg= 0;
                ALUop = 2'b00;
                memWrite = 0;
                ALUsrc = 1;
                regWrite= 1;
                jal_jalr=2;
                AUIPC = 0;
                load_ctrl =1;
                hard_reset = 0;
        end

        else  if(inst6_2 ==  `OPCODE_JAL ) // jal 

            begin
                branch= 0;
                memRead= 0;
                memtoReg= 0;
                ALUop = 2'b11; 
                memWrite = 0;
                ALUsrc = 1;
                regWrite= 1;
                jal_jalr= 1;
                AUIPC = 0;
                load_ctrl =1;
                hard_reset = 0;
        end

        else  if(inst6_2 ==  `OPCODE_AUIPC ) //  AUIPC

            begin
                branch= 0;
                memRead= 0;
                memtoReg= 0;
                ALUop = 2'b11; // can we set this to any value ??? 
                memWrite = 0;
                ALUsrc = 1;
                regWrite= 0;
                jal_jalr=0;
                AUIPC = 1;
                load_ctrl =1;
                hard_reset = 0;
        end

        else
            begin
                branch= 0;
                memRead= 0;
                memtoReg= 0;
                ALUop = 2'b00;
                memWrite = 0;
                ALUsrc = 0;
                regWrite= 0;
                AUIPC = 0;
                jal_jalr = 0;
                load_ctrl =1;
                hard_reset = 0;
        end

        if (memtoReg == 1 && jal_jalr == 0 && AUIPC == 0)
            begin
                RF_select = 2'b00; // taking datamem output
            end
        else if (memtoReg == 0 && jal_jalr == 0 && AUIPC == 0)
            begin
                RF_select = 2'b01; // taking  the ALU output 
            end
        else if (memtoReg == 0 && jal_jalr == 1 && AUIPC == 0)
            begin
                RF_select = 2'b10; // taking  pc_add (pc +4)  
            end
        else if (memtoReg == 0 && jal_jalr == 0 && AUIPC == 1)
        begin
            RF_select = 2'b11; // taking  the sum   
        end

    end



endmodule
