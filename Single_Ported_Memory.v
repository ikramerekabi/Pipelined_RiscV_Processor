`timescale 1ns / 1ps
`include "defines.vh"


//(input clk, input MemRead, input MemWrite, input [2:0]fn3_store , input [5:0] addr, input [31:0] data_in, 
// output reg [31:0] data_out);
module Single_Ported_Memory(input clk, mem_read, mem_write, input [2:0]fn3, input [10:0] addrs,input [31:0] data_in,  output reg [31:0]  data_out );
    
    reg [7:0] mem [0:255];
    wire [10:0] offset = 11'd128;
    wire [10:0] data_address=offset+addrs;
    
    initial begin
        /*
        mem[0]=32'd17;
        mem[1]=32'd9;
        mem[2]=32'd25;
        mem[3]= 32'd1;
        mem[4]= 32'd0;
        mem[5]= 32'd22;
*/
       {mem[131],mem[130],mem[129],mem[128]}=32'd17;
       {mem[135],mem[134],mem[133],mem[132]}=32'd9;
       {mem[139],mem[138],mem[137],mem[136]}=32'd25;
//       {mem[143],mem[142],mem[141],mem[140]}=32'd1;
//       {mem[147],mem[146],mem[145],mem[144]}=32'd0;
//       {mem[151],mem[150],mem[149],mem[148]}=32'd22;
//       {mem[155],mem[154],mem[153],mem[152]}=32'd0;
//       {mem[159],mem[158],mem[157],mem[156]}=32'd0;
//       {mem[163],mem[162],mem[161],mem[160]}=32'd25;
//       {mem[167],mem[166],mem[165],mem[164]}=32'd0;
//       {mem[171],mem[170],mem[169],mem[168]}=32'd0;
//       {mem[175],mem[174],mem[173],mem[172]}=32'd0;
       // mem[140]=8'd0;

    end

    initial begin
       
        //Test Case 1
        /*
        {mem[3], mem[2], mem[1], mem[0]}=32'b000000000000_00000_000_00000_0110011 ; //add x0, x0, x0
        {mem[7], mem[6], mem[5], mem[4]}=32'b000000000000_00000_010_00001_0000011 ; //lw x1, 0(x0)
        {mem[11], mem[10], mem[9], mem[8]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
        {mem[15], mem[14], mem[13], mem[12]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0   
        {mem[19], mem[18], mem[17], mem[16]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0   
        {mem[23], mem[22], mem[21], mem[20]}=32'b000000000100_00000_010_00010_0000011 ; //lw x2, 4(x0)      
        {mem[27], mem[26], mem[25], mem[24]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0   
        {mem[31], mem[30], mem[29], mem[28]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0   
        {mem[35], mem[34], mem[33], mem[32]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0   
        {mem[39], mem[38], mem[37], mem[36]}=32'b000000001000_00000_010_00011_0000011 ; //lw x3, 8(x0)      
        {mem[43], mem[42], mem[41], mem[40]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0  
        {mem[47], mem[46], mem[45], mem[44]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0  
        {mem[51], mem[50], mem[49], mem[48]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0  
        {mem[55], mem[54], mem[53], mem[52]}=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2   
        {mem[59], mem[58], mem[57], mem[56]}=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2   
        {mem[63], mem[62], mem[61], mem[60]}=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2   
        {mem[67], mem[66], mem[65], mem[64]}=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2   
        {mem[71], mem[70], mem[69], mem[68]}=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2   
        {mem[75], mem[74], mem[73], mem[72]}=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2   
        {mem[79], mem[78], mem[77], mem[76]}=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2   
        {mem[83], mem[82], mem[81], mem[80]}=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2   
        {mem[87], mem[86], mem[85], mem[84]}=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2   
        {mem[91],mem[90],mem[89],mem[88]} =32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2   
        */
        
        /*
        
          {mem[3],mem[2],mem[1],mem[0]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0                
                 {mem[7],mem[6],mem[5],mem[4]}=32'b000000000000_00000_010_00001_0000011 ; //lw x1, 0(x0)                    
               {mem[11],mem[10],mem[9],mem[8]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0                
            {mem[15],mem[14],mem[13],mem[12]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0             
            {mem[19],mem[18],mem[17],mem[16]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0             
            {mem[23],mem[22],mem[21],mem[20]}=32'b000000000100_00000_010_00010_0000011 ; //lw x2, 4(x0)                
            {mem[27],mem[26],mem[25],mem[24]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0             
             {mem[35],mem[34],mem[33],mem[32]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0             
             {mem[39],mem[38],mem[37],mem[36]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0             
             {mem[43],mem[42],mem[41],mem[40]}=32'b000000001000_00000_010_00011_0000011 ; //lw x3, 8(x0)                
             {mem[47],mem[46],mem[45],mem[44]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0             
             {mem[51],mem[50],mem[49],mem[48]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0             
             {mem[55],mem[54],mem[53],mem[52]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0             
             {mem[59],mem[58],mem[57],mem[56]}=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2              
             {mem[63],mem[62],mem[61],mem[60]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0             
             {mem[67],mem[66],mem[65],mem[64]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0             
             {mem[71],mem[70],mem[69],mem[68]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0             
             {mem[75],mem[74],mem[73],mem[72]}=32'b0_000001_00011_00100_000_0000_0_1100011; //beq x4, x3, 16            
            {mem[79],mem[78],mem[77],mem[76]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0   76            
             {mem[83],mem[82],mem[81],mem[80]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0             
            {mem[87],mem[86],mem[85],mem[84]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
             {mem[91],mem[90],mem[89],mem[88]}=32'b0000000_00010_00001_000_00011_0110011 ; //add x3, x1, x2  
             {mem[95],mem[94],mem[93],mem[92]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0 
             {mem[99],mem[98],mem[97],mem[96]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0   
             {mem[103],mem[102],mem[101],mem[100]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0               
         {mem[107],mem[106],mem[105],mem[104]}=32'b0000000_00010_00011_000_00101_0110011 ; //add x5, x3, x2             
         {mem[111],mem[110],mem[109],mem[108]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0             
         {mem[115],mem[114],mem[113],mem[112]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0             
         {mem[119],mem[118],mem[117],mem[116]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0             
         {mem[123],mem[122],mem[121],mem[120]}=32'b0000000_00101_00000_010_01100_0100011; //sw x5, 12(x0) 
         */
       
  // the lab test inst  
  
        {mem[3],mem[2],mem[1],mem[0]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0                
        {mem[7],mem[6],mem[5],mem[4]}=32'b000000000000_00000_010_00001_0000011 ; //lw x1, 0(x0)            
        {mem[11],mem[10],mem[9],mem[8]}=32'b000000000100_00000_010_00010_0000011 ; //lw x2, 4(x0)                          
        {mem[15],mem[14],mem[13],mem[12]}=32'b000000001000_00000_010_00011_0000011 ; //lw x3, 8(x0)                        
        {mem[19],mem[18],mem[17],mem[16]}=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2                          
        {mem[23],mem[22],mem[21],mem[20]}=32'b0_000000_00011_00100_000_0110_0_1100011; //beq x4, x3, 8  
//         {mem[27],mem[26],mem[25],mem[24]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0            
//         {mem[31],mem[30],mem[29],mem[28]}=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0            
//        {mem[35],mem[34],mem[33],mem[32]}          
         {mem[27],mem[26],mem[25],mem[24]}             =32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0           
         {mem[31],mem[30],mem[29],mem[28]}=32'b0000000_00010_00001_000_00011_0110011 ; //add x3, x1, x2   
         {mem[35],mem[34],mem[33],mem[32]}=32'b0000000_00010_00011_000_00101_0110011 ; //add x5, x3, x2   
         {mem[39],mem[38],mem[37],mem[36]}=32'b0000000_00101_00000_010_01100_0100011; //sw x5, 12(x0)     
         {mem[43],mem[42],mem[41],mem[40]}=32'b000000001100_00000_010_00110_0000011 ; //lw x6, 12(x0)     
         {mem[47],mem[46],mem[45],mem[44]}=32'b0000000_00001_00110_111_00111_0110011 ; //and x7, x6, x1   
         {mem[51],mem[50],mem[49],mem[48]}=32'b0100000_00010_00001_000_01000_0110011 ; //sub x8, x1, x2   
         {mem[55],mem[54],mem[53],mem[52]}=32'b0000000_00010_00001_000_00000_0110011 ; //add x0, x1, x2   
         {mem[59],mem[58],mem[57],mem[56]}=32'b0000000_00001_00000_000_01001_0110011 ; //add x9, x0       
 
      
      // {mem[3], mem[2], mem[1], mem[0]} =32'b000000000000_00000_000_00000_0110011 ; //add x0, x0, x0
        //added to be skipped since PC starts with 4 after reset
      // {mem[7], mem[6], mem[5], mem[4]}= 32'b000000000000_00000_010_00001_0000011 ; //lw x1, 0(x0)
       /*
        mem[2]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
        mem[3]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
        mem[4]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
        mem[5]=32'b000000000100_00000_010_00010_0000011 ; //lw x2, 4(x0)
        mem[6]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
        mem[7]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
        mem[8]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
        mem[9]=32'b000000001000_00000_010_00011_0000011 ; //lw x3, 8(x0)
        mem[10]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
        mem[11]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
        mem[12]=32'b0000000_00000_00000_000_00000_0110011 ; //add x0, x0, x0
        mem[13]=32'b0000000_00010_00001_110_00100_0110011 ; //or x4, x1, x2
        */
  /*      
       // seif test 
        {mem[3],mem[2],mem[1],mem[0]}=32'h00000033;    
        {mem[7],mem[6],mem[5],mem[4]}=32'h00300413;
        {mem[11],mem[10],mem[9],mem[8]}=32'h00000293;
        {mem[15],mem[14],mem[13],mem[12]}=32'h008484b3;
        {mem[19],mem[18],mem[17],mem[16]}=32'h00128293;
        {mem[23],mem[22],mem[21],mem[20]}=32'hfe82cce3;
        {mem[27],mem[26],mem[25],mem[24]}=32'h00300313;
        {mem[31],mem[30],mem[29],mem[28]}=32'h06629863;
        {mem[35],mem[34],mem[33],mem[32]}=32'h00000413;
        {mem[39],mem[38],mem[37],mem[36]}=32'h00300293;
        {mem[43],mem[42],mem[41],mem[40]}=32'h008484b3;
        {mem[47],mem[46],mem[45],mem[44]}=32'hfff28293;
        {mem[51],mem[50],mem[49],mem[48]}=32'hfe82dce3;
        {mem[55],mem[54],mem[53],mem[52]}=32'hfff00393;
        {mem[59],mem[58],mem[57],mem[56]}=32'h04729a63  ;
        {mem[63],mem[62],mem[61],mem[60]}=32'h00000413  ;
        {mem[67],mem[66],mem[65],mem[64]}=32'h00300293  ;
        {mem[71],mem[70],mem[69],mem[68]}=32'h008484b3  ;
        {mem[75],mem[74],mem[73],mem[72]}=32'hfff28293  ;
        {mem[79],mem[78],mem[77],mem[76]}=32'hfe829ce3  ;
        {mem[83],mem[82],mem[81],mem[80]}=32'h02029e63  ;
        {mem[87],mem[86],mem[85],mem[84]}=32'h00000413  ;
        {mem[91],mem[90],mem[89],mem[88]}=32'h00300293  ;
        {mem[95],mem[94],mem[93],mem[92]}=32'h008484b3  ;
        {mem[99],mem[98],mem[97],mem[96]}=32'hfff28293  ;
        {mem[103],mem[102],mem[101],mem[100]}= 32'h00828463  ;
        {mem[107],mem[106],mem[105],mem[104]}= 32'hfe000ae3  ;
        {mem[111],mem[110],mem[109],mem[108]}= 32'h02029063  ;
        {mem[115],mem[114],mem[113],mem[112]}= 32'hfff00413  ;
        {mem[119],mem[118],mem[117],mem[116]}= 32'h7ff00293  ;
        {mem[123],mem[122],mem[121],mem[120]}= 32'h00546a63  ;
        {mem[127],mem[126],mem[125],mem[124]}= 32'hfff00413  ;
        {mem[131],mem[130],mem[129],mem[128]}= 32'h7ff00293  ;
        {mem[135],mem[134],mem[133],mem[132]}= 32'h0082f463  ;
        {mem[139],mem[138],mem[137],mem[136]}= 32'h00000033  ;
        {mem[143],mem[142],mem[141],mem[140]}= 32'h00000073  ;
     */                                          
                                               
  /////                                             
                                               
        
        
        
        
        
        
        
        
        
    end
    // Posedge clk?
    always @(*)
    begin 
     if(mem_write == 1'b1)
         begin
             if(fn3==3'b010) // sw 
                 {mem[data_address+3],mem[data_address+2],mem[data_address+1],mem[data_address]}= data_in;
             else  if(fn3==3 'b000) //sb 
                 mem[data_address]= data_in[7:0];
             else  if(fn3==3'b001) //sh
                 {mem[data_address+1],mem[data_address]}= data_in[15:0];
    end 
    end
    
    always@(*)
    begin
        if(clk)
            begin
                data_out= {mem[addrs+3],mem[addrs+2],mem[addrs+1],mem[addrs]}; // addr of instruction 
            end

        else
            begin
                if(mem_read == 1'b1)
                begin
                    if(fn3==`F3_LW) // lw 
                        data_out= {mem[data_address+3],mem[data_address+2],mem[data_address+1],mem[data_address]};
                    else  if(fn3==`F3_LB) //lb 
                        data_out= {{24{mem[data_address][7]}}, mem[data_address]} ;
              
                    else  if(fn3==`F3_LH ) //lh
                        data_out= {{16{mem[data_address+1][7]}},mem[data_address+1], mem[data_address]} ;
                    else if(fn3== `F3_lBU) //lbu 
                        data_out = {24'b0, mem[data_address]} ;
                    else if (fn3 == `F3_LHU ) //lhu
                        data_out = {16'b0,mem[data_address+1], mem[data_address]} ;
                end
                
               
            end


    end

endmodule
