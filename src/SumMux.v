`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/27/2025 02:08:34 PM
// Design Name: 
// Module Name: SumMux
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


module SumMux(
    input DepthwiseConvEnb,
    input signed  [31:0] DPWAccSum0,
    input signed  [31:0] DPWAccSum1,
    input signed  [31:0] DPWAccSum2,
    input signed  [31:0] DPWAccSum3,
    input signed  [31:0] DPWAccSum4,
    input signed  [31:0] DPWAccSum5,
    input signed  [31:0] DPWAccSum6,
    input signed  [31:0] DPWAccSum7,
    input signed  [31:0] DPWAccSum8,
    input signed  [31:0] DPWAccSum9,
    input signed  [31:0] DPWAccSum10,
    input signed  [31:0] DPWAccSum11,
    input signed  [31:0] DPWAccSum12,
    input signed  [31:0] DPWAccSum13,
    input signed  [31:0] DPWAccSum14,
    input signed  [31:0] DPWAccSum15,
    
    input signed  [31:0] STDAccSum0,
    input signed  [31:0] STDAccSum1,
    input signed  [31:0] STDAccSum2,
    input signed  [31:0] STDAccSum3,
    input signed  [31:0] STDAccSum4,
    input signed  [31:0] STDAccSum5,
    input signed  [31:0] STDAccSum6,
    input signed  [31:0] STDAccSum7,
    input signed  [31:0] STDAccSum8,
    input signed  [31:0] STDAccSum9,
    input signed  [31:0] STDAccSum10,
    input signed  [31:0] STDAccSum11,
    input signed  [31:0] STDAccSum12,
    input signed  [31:0] STDAccSum13,
    input signed  [31:0] STDAccSum14,
    input signed  [31:0] STDAccSum15,
    
    output signed  [31:0] AccSum0 ,
    output signed  [31:0] AccSum1 ,
    output signed  [31:0] AccSum2 ,
    output signed  [31:0] AccSum3 ,
    output signed  [31:0] AccSum4 ,
    output signed  [31:0] AccSum5 ,
    output signed  [31:0] AccSum6 ,
    output signed  [31:0] AccSum7 ,
    output signed  [31:0] AccSum8 ,
    output signed  [31:0] AccSum9 ,
    output signed  [31:0] AccSum10 ,
    output signed  [31:0] AccSum11 ,
    output signed  [31:0] AccSum12 ,
    output signed  [31:0] AccSum13 ,
    output signed  [31:0] AccSum14 ,
    output signed  [31:0] AccSum15 
    );
    
    assign AccSum0 = (DepthwiseConvEnb == 1'b1) ? DPWAccSum0 : STDAccSum0;
    assign AccSum1 = (DepthwiseConvEnb == 1'b1) ? DPWAccSum1 : STDAccSum1;
    assign AccSum2 = (DepthwiseConvEnb == 1'b1) ? DPWAccSum2 : STDAccSum2;
    assign AccSum3 = (DepthwiseConvEnb == 1'b1) ? DPWAccSum3 : STDAccSum3;
    assign AccSum4 = (DepthwiseConvEnb == 1'b1) ? DPWAccSum4 : STDAccSum4;
    assign AccSum5 = (DepthwiseConvEnb == 1'b1) ? DPWAccSum5 : STDAccSum5;
    assign AccSum6 = (DepthwiseConvEnb == 1'b1) ? DPWAccSum6 : STDAccSum6;
    assign AccSum7 = (DepthwiseConvEnb == 1'b1) ? DPWAccSum7 : STDAccSum7;
    assign AccSum8 = (DepthwiseConvEnb == 1'b1) ? DPWAccSum8 : STDAccSum8;
    assign AccSum9 = (DepthwiseConvEnb == 1'b1) ? DPWAccSum9 : STDAccSum9;
    assign AccSum10 = (DepthwiseConvEnb == 1'b1) ? DPWAccSum10 : STDAccSum10;
    assign AccSum11 = (DepthwiseConvEnb == 1'b1) ? DPWAccSum11 : STDAccSum11;
    assign AccSum12 = (DepthwiseConvEnb == 1'b1) ? DPWAccSum12 : STDAccSum12;
    assign AccSum13 = (DepthwiseConvEnb == 1'b1) ? DPWAccSum13 : STDAccSum13;
    assign AccSum14 = (DepthwiseConvEnb == 1'b1) ? DPWAccSum14 : STDAccSum14;
    assign AccSum15 = (DepthwiseConvEnb == 1'b1) ? DPWAccSum15 : STDAccSum15;
endmodule
