`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2025 11:34:32 AM
// Design Name: 
// Module Name: UniversalACC
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


module UniversalACC(
  input clk,
    input reset,
    input DepthwiseConvEnb,
    input LastChannel,
    input ChannelConvDone,
    input StartAcc,
    input patch_procesing_done,
    input AccSumAck,
    output reg AccSumValid,
    
    output reg ChannelSumACK,
    output reg StartChannelSum,
    input ChannelSumValid,
    
    input signed [15:0] ParPrdt0,
    input signed [15:0] ParPrdt1,
    input signed [15:0] ParPrdt2,
    input signed [15:0] ParPrdt3,
    input signed [15:0] ParPrdt4,
    input signed [15:0] ParPrdt5,
    input signed [15:0] ParPrdt6,
    input signed [15:0] ParPrdt7,
    input signed [15:0] ParPrdt8,
    input signed [15:0] ParPrdt9,
    input signed [15:0] ParPrdt10,
    input signed [15:0] ParPrdt11,
    input signed [15:0] ParPrdt12,
    input signed [15:0] ParPrdt13,
    input signed [15:0] ParPrdt14,
    input signed [15:0] ParPrdt15,
    
    
    input signed [31:0] BiasVal0,
    input signed [31:0] BiasVal1,
    input signed [31:0] BiasVal2,
    input signed [31:0] BiasVal3,
    input signed [31:0] BiasVal4,
    input signed [31:0] BiasVal5,
    input signed [31:0] BiasVal6,
    input signed [31:0] BiasVal7,
    input signed [31:0] BiasVal8,
    input signed [31:0] BiasVal9,
    input signed [31:0] BiasVal10,
    input signed [31:0] BiasVal11,
    input signed [31:0] BiasVal12,
    input signed [31:0] BiasVal13,
    input signed [31:0] BiasVal14,
    input signed [31:0] BiasVal15,
         
    output reg signed  [31:0] AccSum0 =0,
    output reg signed  [31:0] AccSum1 =0,
    output reg signed  [31:0] AccSum2 =0,
    output reg signed  [31:0] AccSum3 =0,
    output reg signed  [31:0] AccSum4 =0,
    output reg signed  [31:0] AccSum5 =0,
    output reg signed  [31:0] AccSum6 =0,
    output reg signed  [31:0] AccSum7 =0,
    output reg signed  [31:0] AccSum8 =0,
    output reg signed  [31:0] AccSum9 =0,
    output reg signed  [31:0] AccSum10 =0,
    output reg signed  [31:0] AccSum11 =0,
    output reg signed  [31:0] AccSum12 =0,
    output reg signed  [31:0] AccSum13 =0,
    output reg signed  [31:0] AccSum14 =0,
    output reg signed  [31:0] AccSum15 =0,
    
    output reg FinalWriteAck,
    input FinalWriteValid
    
    
    );
    
    parameter [3:0]IDLE = 0;
    parameter [3:0] PATCHSUM = 1;
    parameter [3:0] ADDBIAS = 2;
    parameter [3:0] CHANNELSUM = 3;
    parameter [3:0] WRITEDATA = 4;
    parameter [3:0] FINALWRITE = 5;
    
    reg [3:0] stage;
    reg [31:0] CountChannel;
   
    
    always @(posedge clk)begin
        if(reset)begin
            stage <= IDLE;
            CountChannel <= 32'd0;
        end
        else begin
        case (stage)
            IDLE : begin
                        AccSum0 <= 0;
                        AccSum1 <= 0;
                        AccSum2 <= 0;
                        AccSum3 <= 0;  
                        AccSum4 <= 0;
                        AccSum5 <= 0;
                        AccSum6 <= 0;
                        AccSum7 <= 0;
                        AccSum8 <= 0;
                        AccSum9 <= 0;
                        AccSum10 <= 0;
                        AccSum11 <= 0;  
                        AccSum12 <= 0;
                        AccSum13 <= 0;
                        AccSum14 <= 0;
                        AccSum15 <= 0;  
                        
                        AccSumValid <= 0; 
                        StartChannelSum <= 1'b0; 
                        FinalWriteAck <= 1'b0;
                        stage <= PATCHSUM;   
                   end
               
            PATCHSUM : begin
                            if((patch_procesing_done == 1'b0)) begin 
                                if(StartAcc)begin
                                    AccSum0 <= AccSum0 + ParPrdt0;
                                    AccSum1 <= AccSum1 + ParPrdt1;
                                    AccSum2 <= AccSum2 + ParPrdt2;
                                    AccSum3 <= AccSum3 + ParPrdt3;
                                    AccSum4 <= AccSum4 + ParPrdt4;
                                    AccSum5 <= AccSum5 + ParPrdt5;
                                    AccSum6 <= AccSum6 + ParPrdt6;
                                    AccSum7 <= AccSum7 + ParPrdt7;
                                    AccSum8 <= AccSum8 + ParPrdt8;
                                    AccSum9 <= AccSum9 + ParPrdt9;
                                    AccSum10 <= AccSum10 + ParPrdt10;
                                    AccSum11 <= AccSum11 + ParPrdt11;
                                    AccSum12 <= AccSum12 + ParPrdt12;
                                    AccSum13 <= AccSum13 + ParPrdt13;
                                    AccSum14 <= AccSum14 + ParPrdt14;
                                    AccSum15 <= AccSum15 + ParPrdt15; 
                                    
                                end
                                else begin
                                    AccSum0 <= AccSum0 ;
                                    AccSum1 <= AccSum1 ;
                                    AccSum2 <= AccSum2 ;
                                    AccSum3 <= AccSum3 ;
                                    AccSum4 <= AccSum4 ;
                                    AccSum5 <= AccSum5 ;
                                    AccSum6 <= AccSum6 ;
                                    AccSum7 <= AccSum7 ;
                                    AccSum8 <= AccSum8 ;
                                    AccSum9 <= AccSum9 ;
                                    AccSum10 <= AccSum10 ;
                                    AccSum11 <= AccSum11 ;
                                    AccSum12 <= AccSum12 ;
                                    AccSum13 <= AccSum13 ;
                                    AccSum14 <= AccSum14 ;
                                    AccSum15 <= AccSum15 ;
                                end
                                stage <= PATCHSUM;
                            end
                            else begin
                                stage <= ADDBIAS;
                                            
                            end           
                       end
                                       
            ADDBIAS : begin
                        if(DepthwiseConvEnb == 1'b0)begin
                            if(LastChannel == 1'b1)begin
                                AccSum0 <= AccSum0 + BiasVal0;
                                AccSum1 <= AccSum1 + BiasVal1;
                                AccSum2 <= AccSum2 + BiasVal2;
                                AccSum3 <= AccSum3 + BiasVal3;
                                AccSum4 <= AccSum4 + BiasVal4;
                                AccSum5 <= AccSum5 + BiasVal5;
                                AccSum6 <= AccSum6 + BiasVal6;
                                AccSum7 <= AccSum7 + BiasVal7;
                                AccSum8 <= AccSum8 + BiasVal8;
                                AccSum9 <= AccSum9 + BiasVal9;
                                AccSum10 <= AccSum10 + BiasVal10;
                                AccSum11 <= AccSum11 + BiasVal11;
                                AccSum12 <= AccSum12 + BiasVal12;
                                AccSum13 <= AccSum13 + BiasVal13;
                                AccSum14 <= AccSum14 + BiasVal14;
                                AccSum15 <= AccSum15 + BiasVal15;    
                            end
                            else begin
                                AccSum0 <= AccSum0;
                                AccSum1 <= AccSum1;
                                AccSum2 <= AccSum2;
                                AccSum3 <= AccSum3;
                                AccSum4 <= AccSum4;
                                AccSum5 <= AccSum5;
                                AccSum6 <= AccSum6;
                                AccSum7 <= AccSum7;
                                AccSum8 <= AccSum8;
                                AccSum9 <= AccSum9;
                                AccSum10 <= AccSum10;
                                AccSum11 <= AccSum11;
                                AccSum12 <= AccSum12;
                                AccSum13 <= AccSum13;
                                AccSum14 <= AccSum14;
                                AccSum15 <= AccSum15;
                            end
                            stage <= CHANNELSUM;
                            
                        end
                        else begin
                            AccSum0 <= AccSum0 + BiasVal0;
                            AccSum1 <= AccSum1 + BiasVal1;
                            AccSum2 <= AccSum2 + BiasVal2;
                            AccSum3 <= AccSum3 + BiasVal3;
                            AccSum4 <= AccSum4 + BiasVal4;
                            AccSum5 <= AccSum5 + BiasVal5;
                            AccSum6 <= AccSum6 + BiasVal6;
                            AccSum7 <= AccSum7 + BiasVal7;
                            AccSum8 <= AccSum8 + BiasVal8;
                            AccSum9 <= AccSum9 + BiasVal9;
                            AccSum10 <= AccSum10 + BiasVal10;
                            AccSum11 <= AccSum11 + BiasVal11;
                            AccSum12 <= AccSum12 + BiasVal12;
                            AccSum13 <= AccSum13 + BiasVal13;
                            AccSum14 <= AccSum14 + BiasVal14;
                            AccSum15 <= AccSum15 + BiasVal15;
                            stage <= WRITEDATA;
                            
                        end  
                        
                     end  
                     
            CHANNELSUM : begin
                            if(LastChannel == 1'b1)begin
                                if(ChannelSumValid == 1'b0)begin
                                    StartChannelSum <= 1'b1;    
                                    stage <= CHANNELSUM;        
                                end
                                else begin
                                    StartChannelSum <= 1'b0; //2
                                    stage <= FINALWRITE;    
                                end    
                            end
                            else begin 
                                if(ChannelSumValid == 1'b0)begin
                                    StartChannelSum <= 1'b1;       
                                    stage <= CHANNELSUM;        
                                end
                                else begin
                                    StartChannelSum <= 1'b0;
                                    stage <= IDLE;    
                                end                                
                                end
                                    
                         end       
                                             
            WRITEDATA :begin
                            if(AccSumAck == 1'b1)begin
                                
                                stage <= IDLE;
                                   
                            end
                            else begin
                               // FinalWriteAck <= 1'b1; 
                                //StartChannelSum <= 1'b0; 
                                AccSumValid <= 1'b1;
                                stage <= WRITEDATA;
                            end
                                  
                       end  
            FINALWRITE: begin
                            if(FinalWriteValid == 1'b1) begin 
                                stage <= WRITEDATA; 
                                FinalWriteAck <= 1'b1; //1
                            end
                            else begin
                               stage <= FINALWRITE; 
                            end
                        end                                            
        endcase
        end
    end
    

    
    endmodule