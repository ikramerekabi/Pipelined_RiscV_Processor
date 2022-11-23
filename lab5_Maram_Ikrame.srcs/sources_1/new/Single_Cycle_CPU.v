    `timescale 1ns / 1ps
    `include "defines.vh"

module Single_Cycle_CPU(input rst, input clk, input [1:0]ledSel,
    input [3:0] ssdSel, output reg [15:0]leds_16, output reg [12:0] ssd_13  );



    wire [31:0] PC_addrs;
    wire [31:0] pc_output;
    wire [31:0] inst_mem_output;
    wire branch;
    wire memRead;
    wire memtoReg;
    wire [1:0]ALUop;
    wire memWrite;
    wire ALUsrc;
    wire regWrite;
    wire [31:0]writedata_RF;
    wire [31:0]read_data1;
    wire [31:0]read_data2;
    wire [31:0] immGen_output;
    wire [31:0] RF_MUX_output;
    wire [3:0] lAU_Control_output;
    wire [31:0] NBit_lAU_output;
    wire LAU_zero_flag;
    wire [31:0] data_memory_output;
    wire [31:0] shift_left_output;
    wire [31:0] sum;
    wire [31:0] pc_add;
    wire [13:0] concat_output;
    wire cf, zf, vf, sf;
    wire [1:0] control_Branch_output;
    wire [1:0] jal_jalr;
    wire AUIPC;
    wire [1:0] RF_select;
    wire load_ctrl;
    wire hard_reset;
    wire load=1'b1;

    /// pipeline declaration ////

    ///////////////  new wires declarations

    wire [31:0] IF_ID_PC, IF_ID_Inst; //
    wire [31:0] IF_ID_pc_add;

    wire [31:0] ID_EX_PC, ID_EX_RegR1,ID_EX_RegR2 , ID_EX_Imm; //
    wire [11:0] ID_EX_Ctrl; //  this includes   branch, memRead,  memtoReg, [1:0] ALUop memWrite ALUsrc, regWrite, JALR_JAL, rf_select
    wire [3:0] ID_EX_Func; //
    wire [4:0] ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd; ///
    wire [31:0] ID_EX_pc_add;
    wire [4:0] ID_EX_opcode;

    wire [31:0] EX_MEM_BranchAddOut, EX_MEM_ALU_out, EX_MEM_RegR2; //
    wire [4:0] EX_MEM_Rd; //
    wire EX_MEM_Zero; // 
    wire [11:0] EX_MEM_Cntrl; //
    wire [2:0] EX_MEM_func3;
    wire [31:0] EX_MEM_pc_add;
    wire EX_MEM_cf, EX_MEM_vf, EX_MEM_sf ;
    wire [4:0] EX_MEM_opcode;


    wire [31:0] MEM_WB_Load_out, MEM_WB_ALU_out; //
    wire [11:0] MEM_WB_Ctrl; //
    wire [4:0] MEM_WB_Rd; //
    wire [31:0] MEM_WB_pc_add;
    wire [31:0] MEM_WB_BranchAddOut;
    wire [31:0] Single_mem_out; 
    wire [1:0] Forward_A, Forward_B;
    wire [31:0] forwarding_mux_RS1_out, forwarding_mux_RS2_out;
    wire pc_src;
    wire [11:0] flushing_mux_out;

   // wire [1:0] forwardA, forwardB; //for the forwarding unit 
   // wire [31:0] hazard_mux_rs1_output, hazard_mux_rs2_output;
    //wire [7:0] hazar_det_mux_out;




    N_bit_register #(96) IF_ID(~clk ,load, rst, {pc_output,Single_mem_out, pc_add}, {IF_ID_PC, IF_ID_Inst,IF_ID_pc_add}); // IF_ID //we added pc add
    //196
    N_bit_register #(196) ID_EX(clk,load,rst,{{jal_jalr, RF_select, branch, memRead,  memtoReg, ALUop, memWrite, ALUsrc, regWrite },IF_ID_PC,
        read_data1, read_data2, immGen_output, {IF_ID_Inst[30], IF_ID_Inst[14:12]}, IF_ID_Inst[19:15], IF_ID_Inst [24:20], IF_ID_Inst[11:7],IF_ID_pc_add, IF_ID_Inst[6:2]},
        {ID_EX_Ctrl,ID_EX_PC,ID_EX_RegR1,ID_EX_RegR2,
        ID_EX_Imm, ID_EX_Func,ID_EX_Rs1,ID_EX_Rs2,ID_EX_Rd,ID_EX_pc_add, ID_EX_opcode} ); // ID_EX
    // ex mem kan 186
    N_bit_register #(160) EX_MEM (~clk,load, rst,{ flushing_mux_out, sum, cf, LAU_zero_flag, vf, sf, NBit_lAU_output, forwarding_mux_RS2_out, ID_EX_Rd, ID_EX_Func[2:0],ID_EX_opcode,ID_EX_pc_add  }
        ,{ EX_MEM_Cntrl, EX_MEM_BranchAddOut,EX_MEM_cf , EX_MEM_Zero, EX_MEM_vf, EX_MEM_sf , EX_MEM_ALU_out,EX_MEM_RegR2, EX_MEM_Rd,EX_MEM_func3, EX_MEM_opcode, EX_MEM_pc_add}); // EX_MEM
// EX_MEM_REG2 IS THE output of the forwardimg mux rs2
    N_bit_register #(300) MEM_WB (clk, load ,rst, { EX_MEM_Cntrl, Single_mem_out, EX_MEM_ALU_out, EX_MEM_Rd,EX_MEM_BranchAddOut,EX_MEM_pc_add} ,
        { MEM_WB_Ctrl,MEM_WB_Load_out, MEM_WB_ALU_out, MEM_WB_Rd, MEM_WB_BranchAddOut,MEM_WB_pc_add } ); // MEM_WB  but i have a question,
    // f diagram not all the control signals go in,so why would we pass them all ?? 




    ///////
    N_bit_register pc( .clk(clk), .load(load), .rst(rst | hard_reset), .D(PC_addrs), .Q(pc_output));

   // InstMem inst_instMem(.addr(pc_output [7:2]), .data_out(inst_mem_output));

    Control_Unit inst_control ( IF_ID_Inst[6:2], IF_ID_Inst[20], branch, memRead,  memtoReg, ALUop, memWrite, ALUsrc, regWrite, jal_jalr, AUIPC, RF_select, load_ctrl, hard_reset);

    Register_File inst_RF( .clk(~clk),  .rst(rst), .readReg1(IF_ID_Inst[19:15]), .readReg2(IF_ID_Inst [24:20]),
        .writeReg(MEM_WB_Rd), .Write_data(writedata_RF) , .RegWrite(MEM_WB_Ctrl[0]), .read_data1(read_data1), .read_data2(read_data2 ));

    rv32_ImmGen inst_ImmGen(.IR(IF_ID_Inst), .Imm(immGen_output));

    N_bit_MUX inst_RF_MUX(.A(ID_EX_Imm), .B(forwarding_mux_RS2_out),  .sel(ID_EX_Ctrl[1]), .C(RF_MUX_output) );

    ALU_Control_Unit inst_ALUCU( .ALUop(ID_EX_Ctrl[4:3]),.opcode(ID_EX_opcode), .inst14_12(ID_EX_Func [2:0]) ,.inst30( ID_EX_Func[3]), .ALUselc(lAU_Control_output));

    prv32_ALU inst_LAUC(.a(forwarding_mux_RS1_out), .b(RF_MUX_output), .shamt(IF_ID_Inst[24:20] ), .r(NBit_lAU_output), .zf(LAU_zero_flag),
        .cf(cf),.vf(vf), .sf(sf), .alufn(lAU_Control_output)); // shamt from ID_ID  right? and everthing else taken from inst !!!!!

    control_branches cb(.function3(EX_MEM_func3),.branch(EX_MEM_Cntrl[7]),.zf(EX_MEM_Zero), .cf(EX_MEM_cf),.vf(EX_MEM_vf), .sf(EX_MEM_sf), .control_Branch_output(control_Branch_output), .jal_jalr(EX_MEM_Cntrl[11:10]));
    
    assign pc_src = (control_Branch_output==2'b0)?(1'b0):(1'b1);
    //DataMem inst_DM(.clk(clk),  .MemRead(EX_MEM_Cntrl[6]), .MemWrite(EX_MEM_Cntrl[2]), .fn3_store(EX_MEM_func3) , .addr(EX_MEM_ALU_out[7:2]), .data_in(EX_MEM_RegR2), .data_out(data_memory_output));

   // load_inst_contr load_inst_cont(.opcode_load(EX_MEM_opcode), .load_fn3(EX_MEM_func3), .data_in(data_memory_output), .load_inst_contr_output(load_inst_contr_output));
    Forwarding_unit inst_forwarding(.ID_EX_RegRs1(ID_EX_Rs1), .ID_EX_RegRs2(ID_EX_Rs2), .EX_MEM_RegRd(EX_MEM_Rd), .MEM_WB_RegRd(MEM_WB_Rd), .EX_MEM_RegWrite(EX_MEM_Cntrl[0]), .MEM_Wb_RegWrite(MEM_WB_Ctrl[0]), .forwardA(Forward_A), .forwardB(Forward_B));
    //(input [4:0] ID_EX_RegRs1, ID_EX_RegRs2, EX_MEM_RegRd,  MEM_WB_RegRd,input  EX_MEM_RegWrite, MEM_Wb_RegWrite,
   // output reg [1:0] forwardA, forwardB);
   
   N_BIT_4x1mux mux_RS1(.a(ID_EX_RegR1), .b(writedata_RF),.c(EX_MEM_ALU_out), .d(32'b0) ,.sel(Forward_A), .out(forwarding_mux_RS1_out));
   N_BIT_4x1mux mux_RS2(.a(ID_EX_RegR2), .b(writedata_RF),.c(EX_MEM_ALU_out), .d(32'b0) ,.sel(Forward_B), .out(forwarding_mux_RS2_out));
   //((input[N-1:0] a, input[N-1:0] b,input[N-1:0] c, input[N-1:0] d, input [1:0]sel, output [N-1:0] out );
    assign sum = ID_EX_Imm + ID_EX_PC;

    assign pc_add = 4 + pc_output;

    N_BIT_4x1mux  Data_Mem_MUX(.a(MEM_WB_Load_out), .b(MEM_WB_ALU_out), .c(MEM_WB_pc_add), .d(MEM_WB_BranchAddOut), .sel(MEM_WB_Ctrl[9:8]), .out(writedata_RF)); // incase of error check the order

    N_BIT_4x1mux  pc_mux4x1(  .a(pc_add), .b(EX_MEM_BranchAddOut), .c(EX_MEM_BranchAddOut), .d(EX_MEM_ALU_out), .sel(control_Branch_output), .out(PC_addrs) ); // incase of error check the order

    wire [10:0]selected_addrs = ((clk) ?   pc_output [10:0] : EX_MEM_ALU_out[10:0]);
    
    Single_Ported_Memory singleMem( .clk(clk), .mem_read(EX_MEM_Cntrl[6]), .mem_write(EX_MEM_Cntrl[2]), .fn3(EX_MEM_func3), .addrs( selected_addrs ), .data_in(EX_MEM_RegR2), .data_out(Single_mem_out) );//
    //flushing mux 
    N_bit_MUX  #(12)flushing_mux(.A(0), .B(ID_EX_Ctrl), .sel(pc_src), .C(flushing_mux_out));
    //(input[n-1:0] A, input[n-1:0] B, input sel, output [n-1:0] C );
    assign concat_output= {2'b00,ALUop,lAU_Control_output,LAU_zero_flag, control_Branch_output[1], control_Branch_output[0], memRead, memtoReg, memWrite, ALUsrc, regWrite };

    always@(*)
    begin
        case (ledSel)
            2'b00:  leds_16 = inst_mem_output [15:0];
            2'b01:  leds_16 = inst_mem_output [31:16];
            2'b10:  leds_16 = concat_output ;

            default :  leds_16 = 16'd0;

        endcase
    end
    always@(*)
    begin
        case (ssdSel)
            4'b0000:  ssd_13 = pc_output[12:0];
            4'b0001:  ssd_13 = pc_add[12:0];
            4'b0010:  ssd_13 = sum[12:0];
            4'b0011:  ssd_13 = PC_addrs[12:0];
            4'b0100:  ssd_13 = read_data1[12:0];
            4'b0101:  ssd_13 = read_data2[12:0];
            4'b0110:  ssd_13 = writedata_RF[12:0];
            4'b0111: ssd_13 = immGen_output[12:0];
            4'b1000: ssd_13 = shift_left_output[12:0];
            4'b1001: ssd_13 = RF_MUX_output[12:0];
            4'b1010: ssd_13 = NBit_lAU_output[12:0];
            4'b1011: ssd_13 = data_memory_output[12:0];
            default : ssd_13 = 16'd0;

        endcase
    end

endmodule
