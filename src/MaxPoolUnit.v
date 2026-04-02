`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2025 08:33:13 PM
// Design Name: 
// Module Name: MaxPoolUnit
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


module MaxPoolUnit(
    input clk,
    input reset,
    input MaxPoolEn,
    input MaxPoolAck,
    input [7:0] OffsetAddr,
    input MaxPoolStart,
    input MaxPoolEnd,
    input MaxPoolReset,
    
    input signed [7:0] ImageMem_1_Douta_1,
    input signed [7:0] ImageMem_1_Douta_2,
    input signed [7:0] ImageMem_1_Douta_3,
    input signed [7:0] ImageMem_1_Douta_4,
    
    input signed [7:0] ImageMem_2_Douta_1,
    input signed [7:0] ImageMem_2_Douta_2,
    input signed [7:0] ImageMem_2_Douta_3,
    input signed [7:0] ImageMem_2_Douta_4,
    
    input signed [7:0] ImageMem_3_Douta_1,
    input signed [7:0] ImageMem_3_Douta_2,
    input signed [7:0] ImageMem_3_Douta_3,
    input signed [7:0] ImageMem_3_Douta_4,
    
    input signed [7:0] ImageMem_4_Douta_1,
    input signed [7:0] ImageMem_4_Douta_2,
    input signed [7:0] ImageMem_4_Douta_3,
    input signed [7:0] ImageMem_4_Douta_4,
    
     output reg signed [7:0] Data_Out_Maxpool_0,
     output reg signed [7:0] Data_Out_Maxpool_1,
     output reg signed [7:0] Data_Out_Maxpool_2,
     output reg signed [7:0] Data_Out_Maxpool_3,
     output reg signed [7:0] Data_Out_Maxpool_4,
     output reg signed [7:0] Data_Out_Maxpool_5,
     output reg signed [7:0] Data_Out_Maxpool_6,
     output reg signed [7:0] Data_Out_Maxpool_7,
     output reg signed [7:0] Data_Out_Maxpool_8,
     output reg signed [7:0] Data_Out_Maxpool_9,
     output reg signed [7:0] Data_Out_Maxpool_10,
     output reg signed [7:0] Data_Out_Maxpool_11,
     output reg signed [7:0] Data_Out_Maxpool_12,
     output reg signed [7:0] Data_Out_Maxpool_13,
     output reg signed [7:0] Data_Out_Maxpool_14,
     output reg signed [7:0] Data_Out_Maxpool_15,
     
     output reg MaxPoolValid
     
    );
    
    localparam signed [7:0] MinVal = -128;
    
    
    reg signed [7:0] TempMax [15:0];
    reg flag;
   
    integer i;
    
    always@(posedge clk)begin
        if(reset)begin
            for(i = 0; i < 16 ;i = i+1)begin
                TempMax[i] <=  MinVal;   
            end
            MaxPoolValid <= 1'b0;
            flag <= 1'b0;
            Data_Out_Maxpool_0 <= MinVal;
            Data_Out_Maxpool_1 <= MinVal;
            Data_Out_Maxpool_2 <= MinVal;
            Data_Out_Maxpool_3 <= MinVal;
            Data_Out_Maxpool_4 <= MinVal;
            Data_Out_Maxpool_5 <= MinVal;
            Data_Out_Maxpool_6 <= MinVal;
            Data_Out_Maxpool_7 <= MinVal;
            Data_Out_Maxpool_8 <= MinVal;
            Data_Out_Maxpool_9 <= MinVal;
            Data_Out_Maxpool_10 <= MinVal;
            Data_Out_Maxpool_11 <= MinVal;
            Data_Out_Maxpool_12 <= MinVal;
            Data_Out_Maxpool_13 <= MinVal;
            Data_Out_Maxpool_14 <= MinVal;
            Data_Out_Maxpool_15 <= MinVal;  
        end
        else begin
            if((MaxPoolEn == 1'b1)) begin
                case({MaxPoolStart,MaxPoolEnd,MaxPoolReset})
                3'b100: begin
                            flag <= 1'b0;  
                            if(ImageMem_1_Douta_1 > TempMax[0])  TempMax[0] <=  ImageMem_1_Douta_1;   
                            else                                 TempMax[0] <= TempMax[0];   
                            if(ImageMem_1_Douta_2 > TempMax[1])  TempMax[1] <=  ImageMem_1_Douta_2;
                            else                                 TempMax[1] <= TempMax[1];   
                            if(ImageMem_1_Douta_3 > TempMax[2])  TempMax[2] <=  ImageMem_1_Douta_3;   
                            else                                 TempMax[2] <= TempMax[2];   
                            if(ImageMem_1_Douta_4 > TempMax[3])  TempMax[3] <=  ImageMem_1_Douta_4;   
                            else                                 TempMax[3] <= TempMax[3];   
                            
                            if(ImageMem_2_Douta_1 > TempMax[4])  TempMax[4] <=  ImageMem_2_Douta_1;   
                            else                                 TempMax[4] <= TempMax[4];   
                            if(ImageMem_2_Douta_2 > TempMax[5])  TempMax[5] <=  ImageMem_2_Douta_2;
                            else                                 TempMax[5] <= TempMax[5];   
                            if(ImageMem_2_Douta_3 > TempMax[6])  TempMax[6] <=  ImageMem_2_Douta_3;   
                            else                                 TempMax[6] <= TempMax[6];   
                            if(ImageMem_2_Douta_4 > TempMax[7])  TempMax[7] <=  ImageMem_2_Douta_4;   
                            else                                 TempMax[7] <= TempMax[7];
                            
                            if(ImageMem_3_Douta_1 > TempMax[8])  TempMax[8] <=  ImageMem_3_Douta_1;   
                            else                                 TempMax[8] <= TempMax[8];   
                            if(ImageMem_3_Douta_2 > TempMax[9])  TempMax[9] <=  ImageMem_3_Douta_2;
                            else                                 TempMax[9] <= TempMax[9];   
                            if(ImageMem_3_Douta_3 > TempMax[10])  TempMax[10] <=  ImageMem_3_Douta_3;   
                            else                                 TempMax[10] <= TempMax[10];   
                            if(ImageMem_3_Douta_4 > TempMax[11])  TempMax[11] <=  ImageMem_3_Douta_4;   
                            else                                 TempMax[11] <= TempMax[11];
                            
                            if(ImageMem_4_Douta_1 > TempMax[12])  TempMax[12] <=  ImageMem_4_Douta_1;   
                            else                                 TempMax[12] <= TempMax[12];   
                            if(ImageMem_4_Douta_2 > TempMax[13])  TempMax[13] <=  ImageMem_4_Douta_2;
                            else                                 TempMax[13] <= TempMax[13];   
                            if(ImageMem_4_Douta_3 > TempMax[14])  TempMax[14] <=  ImageMem_4_Douta_3;   
                            else                                 TempMax[14] <= TempMax[14];   
                            if(ImageMem_4_Douta_4 > TempMax[15])  TempMax[15] <=  ImageMem_4_Douta_4;   
                            else                                 TempMax[15] <= TempMax[15];  
                       end
                  3'b010: begin
                            Data_Out_Maxpool_0 <= TempMax[0];  
                            Data_Out_Maxpool_1 <= TempMax[1]; 
                            Data_Out_Maxpool_2 <= TempMax[2]; 
                            Data_Out_Maxpool_3 <= TempMax[3];
                                           
                            Data_Out_Maxpool_4 <= TempMax[4];  
                            Data_Out_Maxpool_5 <= TempMax[5]; 
                            Data_Out_Maxpool_6 <= TempMax[6]; 
                            Data_Out_Maxpool_7 <= TempMax[7];
                                            
                            Data_Out_Maxpool_8 <= TempMax[8];  
                            Data_Out_Maxpool_9 <= TempMax[9]; 
                            Data_Out_Maxpool_10 <= TempMax[10]; 
                            Data_Out_Maxpool_11 <= TempMax[11];
                                            
                            Data_Out_Maxpool_12 <= TempMax[12];  
                            Data_Out_Maxpool_13 <= TempMax[13]; 
                            Data_Out_Maxpool_14 <= TempMax[14]; 
                            Data_Out_Maxpool_15 <= TempMax[15]; 
                            if(flag == 1'b0)begin
                                MaxPoolValid <= 1'b1;
                                flag <= 1'b1;    
                            end
                            if(flag == 1'b1)begin
                                MaxPoolValid <= 1'b0;
                            end
                          end 
                  3'b001: begin
                            TempMax[0] <=  MinVal;
                            TempMax[1] <=  MinVal;
                            TempMax[2] <=  MinVal;
                            TempMax[3] <=  MinVal;
                            TempMax[4] <=  MinVal;
                            TempMax[5] <=  MinVal;
                            TempMax[6] <=  MinVal;
                            TempMax[7] <=  MinVal;
                            TempMax[8] <=  MinVal;
                            TempMax[9] <=  MinVal;
                            TempMax[10] <=  MinVal;
                            TempMax[11] <=  MinVal;
                            TempMax[12] <=  MinVal;
                            TempMax[13] <=  MinVal;
                            TempMax[14] <=  MinVal;
                            TempMax[15] <=  MinVal;   
                            MaxPoolValid <= 1'b0;      
                          end            
                endcase
            end
        end
      end  
endmodule
