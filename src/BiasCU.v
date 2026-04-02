`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2025 10:06:31 AM
// Design Name: 
// Module Name: BiasCU
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


module BiasCU(
    input  clk,
    input  reset,
    input BiasEn,
    
    input signed [31:0] AXI_BiasVal0,
    input signed [31:0] AXI_BiasVal1,
    input signed [31:0] AXI_BiasVal2,
    input signed [31:0] AXI_BiasVal3,
    input signed [31:0] AXI_BiasVal4,
    input signed [31:0] AXI_BiasVal5,
    input signed [31:0] AXI_BiasVal6,
    input signed [31:0] AXI_BiasVal7,
    input signed [31:0] AXI_BiasVal8,
    input signed [31:0] AXI_BiasVal9,
    input signed [31:0] AXI_BiasVal10,
    input signed [31:0] AXI_BiasVal11,
    input signed [31:0] AXI_BiasVal12,
    input signed [31:0] AXI_BiasVal13,
    input signed [31:0] AXI_BiasVal14,
    input signed [31:0] AXI_BiasVal15,
    
    
    output reg signed [31:0] BiasVal0,
    output reg signed [31:0] BiasVal1,
    output reg signed [31:0] BiasVal2,
    output reg signed [31:0] BiasVal3,
    output reg signed [31:0] BiasVal4,
    output reg signed [31:0] BiasVal5,
    output reg signed [31:0] BiasVal6,
    output reg signed [31:0] BiasVal7,
    output reg signed [31:0] BiasVal8,
    output reg signed [31:0] BiasVal9,
    output reg signed [31:0] BiasVal10,
    output reg signed [31:0] BiasVal11,
    output reg signed [31:0] BiasVal12,
    output reg signed [31:0] BiasVal13,
    output reg signed [31:0] BiasVal14,
    output reg signed [31:0] BiasVal15
    
    );
    
    reg signed [31:0] Temp_1_BiasVal [15:0];
    reg signed [31:0] Temp_2_BiasVal [15:0];
    integer i;
    reg [1:0] latency;
    
    always@(posedge clk)begin
        if(reset)begin
            BiasVal0 <= 32'd0;
            BiasVal1 <= 32'd0;
            BiasVal2 <= 32'd0;
            BiasVal3 <= 32'd0;
            BiasVal4 <= 32'd0;
            BiasVal5 <= 32'd0;
            BiasVal6 <= 32'd0;
            BiasVal7 <= 32'd0;
            BiasVal8 <= 32'd0;
            BiasVal9 <= 32'd0;
            BiasVal10 <= 32'd0;
            BiasVal11 <= 32'd0;
            BiasVal12 <= 32'd0;
            BiasVal13 <= 32'd0;
            BiasVal14 <= 32'd0;
            BiasVal15 <= 32'd0;
           for( i = 0; i < 15 ;i = i+1)begin
                Temp_1_BiasVal[i] <= 32'd0;
                Temp_2_BiasVal[i] <= 32'd0;  
           end
           latency <= 2'd0;
        end
        else begin
            if(BiasEn == 1'b1)begin
                case(latency)
                    2'b0 :  begin 
                                Temp_1_BiasVal[0] <= AXI_BiasVal0;
                                Temp_1_BiasVal[1] <= AXI_BiasVal1;
                                Temp_1_BiasVal[2] <= AXI_BiasVal2;
                                Temp_1_BiasVal[3] <= AXI_BiasVal3;
                                Temp_1_BiasVal[4] <= AXI_BiasVal4;
                                Temp_1_BiasVal[5] <= AXI_BiasVal5;
                                Temp_1_BiasVal[6] <= AXI_BiasVal6;
                                Temp_1_BiasVal[7] <= AXI_BiasVal7;
                                Temp_1_BiasVal[8] <= AXI_BiasVal8;
                                Temp_1_BiasVal[9] <= AXI_BiasVal9;
                                Temp_1_BiasVal[10] <= AXI_BiasVal10;
                                Temp_1_BiasVal[11] <= AXI_BiasVal11;
                                Temp_1_BiasVal[12] <= AXI_BiasVal12;
                                Temp_1_BiasVal[13] <= AXI_BiasVal13;
                                Temp_1_BiasVal[14] <= AXI_BiasVal14;
                                Temp_1_BiasVal[15] <= AXI_BiasVal15; 
                                latency <= 1; 
                            end
                            
                    2'b1 :  begin 
                                Temp_2_BiasVal[0] <= Temp_1_BiasVal[0];
                                Temp_2_BiasVal[1] <= Temp_1_BiasVal[1];
                                Temp_2_BiasVal[2] <= Temp_1_BiasVal[2];
                                Temp_2_BiasVal[3] <= Temp_1_BiasVal[3];
                                Temp_2_BiasVal[4] <= Temp_1_BiasVal[4];
                                Temp_2_BiasVal[5] <= Temp_1_BiasVal[5];
                                Temp_2_BiasVal[6] <= Temp_1_BiasVal[6];
                                Temp_2_BiasVal[7] <= Temp_1_BiasVal[7];
                                Temp_2_BiasVal[8] <= Temp_1_BiasVal[8];
                                Temp_2_BiasVal[9] <= Temp_1_BiasVal[9];
                                Temp_2_BiasVal[10] <= Temp_1_BiasVal[10];
                                Temp_2_BiasVal[11] <= Temp_1_BiasVal[11];
                                Temp_2_BiasVal[12] <= Temp_1_BiasVal[12];
                                Temp_2_BiasVal[13] <= Temp_1_BiasVal[13];
                                Temp_2_BiasVal[14] <= Temp_1_BiasVal[14];
                                Temp_2_BiasVal[15] <= Temp_1_BiasVal[15];
                                latency <= 2;        
                            end       
                            
                       2'd2 :  begin 
                                BiasVal0 <= AXI_BiasVal0;
                                BiasVal1 <= AXI_BiasVal1;
                                BiasVal2 <= AXI_BiasVal2;
                                BiasVal3 <= AXI_BiasVal3;
                                BiasVal4 <= AXI_BiasVal4;
                                BiasVal5 <= AXI_BiasVal5;
                                BiasVal6 <= AXI_BiasVal6;
                                BiasVal7 <= AXI_BiasVal7;
                                BiasVal8 <= AXI_BiasVal8;
                                BiasVal9 <= AXI_BiasVal9;
                                BiasVal10 <= AXI_BiasVal10;
                                BiasVal11 <= AXI_BiasVal11;
                                BiasVal12 <= AXI_BiasVal12;
                                BiasVal13 <= AXI_BiasVal13;
                                BiasVal14 <= AXI_BiasVal14;
                                BiasVal15 <= AXI_BiasVal15;
                                latency <= 2;        
                            end          
            endcase
            end
            else begin
                BiasVal0 <= 32'd0;
                BiasVal1 <= 32'd0;
                BiasVal2 <= 32'd0;
                BiasVal3 <= 32'd0;
                BiasVal4 <= 32'd0;
                BiasVal5 <= 32'd0;
                BiasVal6 <= 32'd0;
                BiasVal7 <= 32'd0;
                BiasVal8 <= 32'd0;
                BiasVal9 <= 32'd0;
                BiasVal10 <= 32'd0;
                BiasVal11 <= 32'd0;
                BiasVal12 <= 32'd0;
                BiasVal13 <= 32'd0;
                BiasVal14 <= 32'd0;
                BiasVal15 <= 32'd0;  
            end
                
        end
    end
    
    
endmodule
