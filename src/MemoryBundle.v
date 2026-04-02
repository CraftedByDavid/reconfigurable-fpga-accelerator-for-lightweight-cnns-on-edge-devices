`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2025 08:35:15 AM
// Design Name: 
// Module Name: MemoryBundle
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


module MemoryBundle(
    input [127:0] ImageMem_1_Douta,
   
    
    input [127:0] KernelMem_1_Douta,
    
    input signed [7:0] Data_Out_Int8_0,
    input signed [7:0] Data_Out_Int8_1,
    input signed [7:0] Data_Out_Int8_2,
    input signed [7:0] Data_Out_Int8_3,
    input signed [7:0] Data_Out_Int8_4,
    input signed [7:0] Data_Out_Int8_5,
    input signed [7:0] Data_Out_Int8_6,
    input signed [7:0] Data_Out_Int8_7,
    input signed [7:0] Data_Out_Int8_8,
    input signed [7:0] Data_Out_Int8_9,
    input signed [7:0] Data_Out_Int8_10,
    input signed [7:0] Data_Out_Int8_11,
    input signed [7:0] Data_Out_Int8_12,
    input signed [7:0] Data_Out_Int8_13,
    input signed [7:0] Data_Out_Int8_14,
    input signed [7:0] Data_Out_Int8_15,
    
    
    
    output signed [7:0] ImageMem_1_Douta_1,
    output signed [7:0] ImageMem_1_Douta_2,
    output signed [7:0] ImageMem_1_Douta_3,
    output signed [7:0] ImageMem_1_Douta_4,
    
    output signed [7:0] ImageMem_2_Douta_1,
    output signed [7:0] ImageMem_2_Douta_2,
    output signed [7:0] ImageMem_2_Douta_3,
    output signed [7:0] ImageMem_2_Douta_4,
    
    output signed [7:0] ImageMem_3_Douta_1,
    output signed [7:0] ImageMem_3_Douta_2,
    output signed [7:0] ImageMem_3_Douta_3,
    output signed [7:0] ImageMem_3_Douta_4,
    
    output signed [7:0] ImageMem_4_Douta_1,
    output signed [7:0] ImageMem_4_Douta_2,
    output signed [7:0] ImageMem_4_Douta_3,
    output signed [7:0] ImageMem_4_Douta_4,    
    
    output signed [7:0] KernelMem_1_Douta_1,
    output signed [7:0] KernelMem_1_Douta_2,
    output signed [7:0] KernelMem_1_Douta_3,
    output signed [7:0] KernelMem_1_Douta_4,
    
    output signed [7:0] KernelMem_2_Douta_1,
    output signed [7:0] KernelMem_2_Douta_2,
    output signed [7:0] KernelMem_2_Douta_3,
    output signed [7:0] KernelMem_2_Douta_4,
    
    output signed [7:0] KernelMem_3_Douta_1,
    output signed [7:0] KernelMem_3_Douta_2,
    output signed [7:0] KernelMem_3_Douta_3,
    output signed [7:0] KernelMem_3_Douta_4,
    
    output signed [7:0] KernelMem_4_Douta_1,
    output signed [7:0] KernelMem_4_Douta_2,
    output signed [7:0] KernelMem_4_Douta_3,
    output signed [7:0] KernelMem_4_Douta_4,
    
    output [127:0] OutputMem_1_Douta,
    
    output  ImageMem_1_Ena,
    output  KernelMem_1_Ena,
    output  OutputMem_1_Ena,
    output [15:0]ImageMem_1_Wea,
    output [15:0] KernelMem_1_Wea,
    input  [27:0] PixelAddr,
    input  [7:0] KernelIndex,
    input [27:0]  OutputAddr,
    output [31:0] OutputMemAddr,
    output [31:0]ImageMemAddr,
    output [11:0]KernelMemAddr    
    //output [3:0] AddrAlign
    
    );
    
    parameter [3:0] AddrAligner = 4'b0000;
    
    assign ImageMem_1_Douta_1 = ImageMem_1_Douta[7:0];
    assign ImageMem_1_Douta_2 = ImageMem_1_Douta[15:8];
    assign ImageMem_1_Douta_3 = ImageMem_1_Douta[23:16];
    assign ImageMem_1_Douta_4 = ImageMem_1_Douta[31:24];
    
    assign ImageMem_2_Douta_1 = ImageMem_1_Douta[39:32];
    assign ImageMem_2_Douta_2 = ImageMem_1_Douta[47:40];
    assign ImageMem_2_Douta_3 = ImageMem_1_Douta[55:48];
    assign ImageMem_2_Douta_4 = ImageMem_1_Douta[63:56];
    
    assign ImageMem_3_Douta_1 = ImageMem_1_Douta[71:64];
    assign ImageMem_3_Douta_2 = ImageMem_1_Douta[79:72];
    assign ImageMem_3_Douta_3 = ImageMem_1_Douta[87:80];
    assign ImageMem_3_Douta_4 = ImageMem_1_Douta[95:88];
    
    assign ImageMem_4_Douta_1 = ImageMem_1_Douta[103:96];
    assign ImageMem_4_Douta_2 = ImageMem_1_Douta[111:104];
    assign ImageMem_4_Douta_3 = ImageMem_1_Douta[119:112];
    assign ImageMem_4_Douta_4 = ImageMem_1_Douta[127:120];
    
    assign KernelMem_1_Douta_1 = KernelMem_1_Douta[7:0];
    assign KernelMem_1_Douta_2 = KernelMem_1_Douta[15:8];
    assign KernelMem_1_Douta_3 = KernelMem_1_Douta[23:16];
    assign KernelMem_1_Douta_4 = KernelMem_1_Douta[31:24];
    
    assign KernelMem_2_Douta_1 = KernelMem_1_Douta[39:32];
    assign KernelMem_2_Douta_2 = KernelMem_1_Douta[47:40];
    assign KernelMem_2_Douta_3 = KernelMem_1_Douta[55:48];
    assign KernelMem_2_Douta_4 = KernelMem_1_Douta[63:56];
    
    assign KernelMem_3_Douta_1 = KernelMem_1_Douta[71:64];
    assign KernelMem_3_Douta_2 = KernelMem_1_Douta[79:72];
    assign KernelMem_3_Douta_3 = KernelMem_1_Douta[87:80];
    assign KernelMem_3_Douta_4 = KernelMem_1_Douta[95:88];
    
    assign KernelMem_4_Douta_1 = KernelMem_1_Douta[103:96];
    assign KernelMem_4_Douta_2 = KernelMem_1_Douta[111:104];
    assign KernelMem_4_Douta_3 = KernelMem_1_Douta[119:112];
    assign KernelMem_4_Douta_4 = KernelMem_1_Douta[127:120];
    
    assign  ImageMem_1_Ena = 1'b1;
    
    assign  KernelMem_1_Ena = 1'b1;
    assign  OutputMem_1_Ena = 1'b1;
    
    
    assign  ImageMem_1_Wea = 16'd0;
    
    assign  KernelMem_1_Wea = 16'd0;
    
    assign AddrAlign = 4'd0;
    
    assign OutputMem_1_Douta = {
                                    Data_Out_Int8_15,
                                    Data_Out_Int8_14,
                                    Data_Out_Int8_13,
                                    Data_Out_Int8_12,
                                    Data_Out_Int8_11,
                                    Data_Out_Int8_10,
                                    Data_Out_Int8_9,
                                    Data_Out_Int8_8,
                                    Data_Out_Int8_7,
                                    Data_Out_Int8_6,
                                    Data_Out_Int8_5,
                                    Data_Out_Int8_4,
                                    Data_Out_Int8_3,
                                    Data_Out_Int8_2,
                                    Data_Out_Int8_1,
                                    Data_Out_Int8_0
                                };
                                
       assign ImageMemAddr = {PixelAddr,AddrAligner};
       assign KernelMemAddr = {KernelIndex,AddrAligner};
       assign OutputMemAddr = {OutputAddr,AddrAligner};
endmodule
