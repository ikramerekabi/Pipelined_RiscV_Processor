`timescale 1ns / 1ps


module control_branches(input [2:0]function3, input branch, cf, zf, vf, sf, input[1:0] jal_jalr, output reg [1:0] control_Branch_output);

    always @(*)
    begin
        if (branch == 1) begin
            case (function3)
                `BR_BEQ : begin
                    if(zf) //beq 
                        control_Branch_output = 1;
                    else
                        control_Branch_output = 0;
                end
                `BR_BNE : begin
                    if(!zf) //bne 
                        control_Branch_output = 1;
                    else
                        control_Branch_output = 0;
                end
                `BR_BLT : begin
                    if(sf!=vf) //blt
                        control_Branch_output = 1;
                    else
                        control_Branch_output = 0;
                end
                `BR_BGE : begin
                    if(sf==vf) //bge
                        control_Branch_output = 1;
                    else
                        control_Branch_output = 0;
                end
                `BR_BLTU : begin
                    if(!cf) //bltu
                        control_Branch_output = 1;
                    else
                        control_Branch_output = 0;
                end
                `BR_BGEU : begin
                    if(cf) //bgeu
                        control_Branch_output = 1;
                    else
                        control_Branch_output = 0;
                end
                default : control_Branch_output = 0;
            endcase
        end
        else if (jal_jalr != 0) begin
            if (jal_jalr[0] == 1) // JAL
                control_Branch_output = 2;
            else if (jal_jalr[1] == 1) // JALR
                control_Branch_output = 3;

        end
        else
            control_Branch_output  = 0;
    end

endmodule
