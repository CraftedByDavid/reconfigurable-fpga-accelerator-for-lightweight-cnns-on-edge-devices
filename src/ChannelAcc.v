`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/23/2025 04:38:43 PM
// Design Name: 
// Module Name: ChannelAcc
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


module ChannelAcc(
    input clk,
    input reset,
    input ChannelMemReset,
    input StartChannelSum,
    
    input ChannelSumACK,
    input LastChannel,
    
    input signed [31:0] AccSum0,
    input signed [31:0] AccSum1,
    input signed [31:0] AccSum2,
    input signed [31:0] AccSum3,
    input signed [31:0] AccSum4,
    input signed [31:0] AccSum5,
    input signed [31:0] AccSum6,
    input signed [31:0] AccSum7,
    input signed [31:0] AccSum8,
    input signed [31:0] AccSum9,
    input signed [31:0] AccSum10,
    input signed [31:0] AccSum11,
    input signed [31:0] AccSum12,
    input signed [31:0] AccSum13,
    input signed [31:0] AccSum14,
    input signed [31:0] AccSum15,
    
    input signed  [31:0] Dout_ChAccSum0,
    input signed  [31:0] Dout_ChAccSum1,
    input signed  [31:0] Dout_ChAccSum2,
    input signed  [31:0] Dout_ChAccSum3,
    input signed  [31:0] Dout_ChAccSum4,
    input signed  [31:0] Dout_ChAccSum5,
    input signed  [31:0] Dout_ChAccSum6,
    input signed  [31:0] Dout_ChAccSum7,
    input signed  [31:0] Dout_ChAccSum8,
    input signed  [31:0] Dout_ChAccSum9,
    input signed  [31:0] Dout_ChAccSum10,
    input signed  [31:0] Dout_ChAccSum11,
    input signed  [31:0] Dout_ChAccSum12,
    input signed  [31:0] Dout_ChAccSum13,
    input signed  [31:0] Dout_ChAccSum14,
    input signed  [31:0] Dout_ChAccSum15,
    
    output reg signed [31:0] Din_ChAccSum0,
    output reg signed [31:0] Din_ChAccSum1,
    output reg signed [31:0] Din_ChAccSum2,
    output reg signed [31:0] Din_ChAccSum3,
    output reg signed [31:0] Din_ChAccSum4,
    output reg signed [31:0] Din_ChAccSum5,
    output reg signed [31:0] Din_ChAccSum6,
    output reg signed [31:0] Din_ChAccSum7,
    output reg signed [31:0] Din_ChAccSum8,
    output reg signed [31:0] Din_ChAccSum9,
    output reg signed [31:0] Din_ChAccSum10,
    output reg signed [31:0] Din_ChAccSum11,
    output reg signed [31:0] Din_ChAccSum12,
    output reg signed [31:0] Din_ChAccSum13,
    output reg signed [31:0] Din_ChAccSum14,
    output reg signed [31:0] Din_ChAccSum15,
    
    output reg [31:0] Addr,
    
    
    output reg   signed [31:0] FinalSum0,
    output reg   signed [31:0] FinalSum1,
    output reg   signed [31:0] FinalSum2,
    output reg   signed [31:0] FinalSum3,
    output reg   signed [31:0] FinalSum4,
    output reg   signed [31:0] FinalSum5,
    output reg   signed [31:0] FinalSum6,
    output reg   signed [31:0] FinalSum7,
    output reg   signed [31:0] FinalSum8,
    output reg   signed [31:0] FinalSum9,
    output reg   signed [31:0] FinalSum10,
    output reg   signed [31:0] FinalSum11,
    output reg   signed [31:0] FinalSum12,
    output reg   signed [31:0] FinalSum13,
    output reg   signed [31:0] FinalSum14,
    output reg   signed [31:0] FinalSum15,
    
    output reg FinalWriteValid,
    output reg wea,
    input FinalWriteACk,
    
    
    
    output reg ChannelSumDone,
    output reg ChannelSumValid,
    
    output InternalMemEn
    
    );
    
    parameter [3:0] IDLE = 0;
    parameter [3:0] SETADDR = 1;
    parameter [3:0] READ_MEM = 2;
    parameter [3:0] ACCUMULATE = 3;
    parameter [3:0] WRITE_MEM = 4;
    parameter [3:0] INC_ADDR = 5;
    parameter [3:0] ROUTE = 6;
    parameter [3:0] LAST_CHANNEL = 7;
    parameter [3:0] DONE = 8;
    parameter [3:0] MEMRESET = 9;
    
       
    
    reg signed [31:0] temp_mem0 ;
    reg signed [31:0] temp_mem1 ;
    reg signed [31:0] temp_mem2 ;
    reg signed [31:0] temp_mem3 ;
    reg signed [31:0] temp_mem4 ;
    reg signed [31:0] temp_mem5 ;
    reg signed [31:0] temp_mem6 ;
    reg signed [31:0] temp_mem7 ;
    reg signed [31:0] temp_mem8 ;
    reg signed [31:0] temp_mem9 ;
    reg signed [31:0] temp_mem10;
    reg signed [31:0] temp_mem11;
    reg signed [31:0] temp_mem12;
    reg signed [31:0] temp_mem13;
    reg signed [31:0] temp_mem14;
    reg signed [31:0] temp_mem15;
      
    
    reg [3:0] Latency;
    integer i, j;
    
    reg [3:0] stage ;
    
    reg AddrFlag;
    
    
    always@(posedge clk)begin
        if(reset)begin
            temp_mem0  <= 32'd0;
            temp_mem1  <= 32'd0;
            temp_mem2  <= 32'd0;
            temp_mem3  <= 32'd0;
            temp_mem4  <= 32'd0;
            temp_mem5  <= 32'd0;
            temp_mem6  <= 32'd0;
            temp_mem7  <= 32'd0;
            temp_mem8  <= 32'd0;
            temp_mem9  <= 32'd0;
            temp_mem10 <= 32'd0;
            temp_mem11 <= 32'd0;
            temp_mem12 <= 32'd0;
            temp_mem13 <= 32'd0;
            temp_mem14 <= 32'd0;
            temp_mem15 <= 32'd0;
            if(ChannelMemReset)begin
                    stage <= MEMRESET;
                    Addr <= 32'd0;
                    Latency <= 0;
             end
             else begin    
                Addr <= 32'd0;
                ChannelSumDone <= 1'b0 ; 
                ChannelSumValid <= 1'b0;
                FinalWriteValid <= 1'b0;
                AddrFlag <= 1'b0;
                wea <= 0;
                stage <= IDLE;
             end
                  
        end
        else begin
            case(stage)
                IDLE : begin
                
                            FinalWriteValid <= 1'b0;
                            ChannelSumDone <= 1'b0 ; 
                            ChannelSumValid <= 1'b0;
                            
                            if(StartChannelSum == 1'b1)begin
                                stage <= READ_MEM ;
                            end
                            else begin
                                stage <= IDLE;
                            end
                               
                       end    
               READ_MEM : begin
                            temp_mem0 <= Dout_ChAccSum0;   
                            temp_mem1 <= Dout_ChAccSum1;
                            temp_mem2 <= Dout_ChAccSum2;
                            temp_mem3 <= Dout_ChAccSum3;
                            temp_mem4 <= Dout_ChAccSum4;
                            temp_mem5 <= Dout_ChAccSum5;
                            temp_mem6 <= Dout_ChAccSum6;
                            temp_mem7 <= Dout_ChAccSum7;
                            temp_mem8 <= Dout_ChAccSum8;
                            temp_mem9 <= Dout_ChAccSum9;
                            temp_mem10 <= Dout_ChAccSum10;
                            temp_mem11 <= Dout_ChAccSum11;
                            temp_mem12 <= Dout_ChAccSum12;
                            temp_mem13 <= Dout_ChAccSum13;
                            temp_mem14 <= Dout_ChAccSum14;
                            temp_mem15 <= Dout_ChAccSum15;
                            ChannelSumValid <= 1'b1;
                            stage <= ACCUMULATE;
                           end 
                           
               ACCUMULATE : begin
                              temp_mem0 <= temp_mem0 + AccSum0;
                              temp_mem1 <= temp_mem1 + AccSum1;
                              temp_mem2 <= temp_mem2 + AccSum2;
                              temp_mem3 <= temp_mem3 + AccSum3;
                              temp_mem4 <= temp_mem4 + AccSum4;
                              temp_mem5 <= temp_mem5 + AccSum5;
                              temp_mem6 <= temp_mem6 + AccSum6;
                              temp_mem7 <= temp_mem7 + AccSum7;
                              temp_mem8 <= temp_mem8 + AccSum8;
                              temp_mem9 <= temp_mem9 + AccSum9;
                              temp_mem10 <= temp_mem10 + AccSum10;
                              temp_mem11 <= temp_mem11 + AccSum11;
                              temp_mem12 <= temp_mem12 + AccSum12;
                              temp_mem13 <= temp_mem13 + AccSum13;
                              temp_mem14 <= temp_mem14 + AccSum14;
                              temp_mem15 <= temp_mem15 + AccSum15;
                              stage <= WRITE_MEM;  
                            end            
                                                   
               WRITE_MEM : begin
                            Din_ChAccSum0 <=  temp_mem0;
                            Din_ChAccSum1 <=  temp_mem1;
                            Din_ChAccSum2 <=  temp_mem2;
                            Din_ChAccSum3 <=  temp_mem3;
                            Din_ChAccSum4 <=  temp_mem4;
                            Din_ChAccSum5 <=  temp_mem5;
                            Din_ChAccSum6 <=  temp_mem6;
                            Din_ChAccSum7 <=  temp_mem7;
                            Din_ChAccSum8 <=  temp_mem8;
                            Din_ChAccSum9 <=  temp_mem9;
                            Din_ChAccSum10 <=  temp_mem10;
                            Din_ChAccSum11 <=  temp_mem11;
                            Din_ChAccSum12 <=  temp_mem12;
                            Din_ChAccSum13 <=  temp_mem13;
                            Din_ChAccSum14 <=  temp_mem14;
                            Din_ChAccSum15 <=  temp_mem15;
                            wea <= 1;
                            stage <= INC_ADDR;   
                          end
                          
                INC_ADDR : begin
                            wea <= 0;
                            Addr <= Addr + 1;
                            
                            stage <= ROUTE ;
                          end            
                               
                ROUTE : begin
                            if(LastChannel == 1'b1)begin   
                                stage <= LAST_CHANNEL;
                                ChannelSumValid <= 1'b0;                                 
                            end
                            else begin
                                stage <= IDLE;
                                ChannelSumValid <= 1'b0;                                       
                            end
                           end     
                LAST_CHANNEL : begin 
                                if(FinalWriteACk)begin
                                    stage <= IDLE;    
                                end
                                else begin
                                    FinalSum0 <= temp_mem0;
                                    FinalSum1 <= temp_mem1;
                                    FinalSum2 <= temp_mem2;
                                    FinalSum3 <= temp_mem3;
                                    FinalSum4 <= temp_mem4;
                                    FinalSum5 <= temp_mem5;
                                    FinalSum6 <= temp_mem6;
                                    FinalSum7 <= temp_mem7;
                                    FinalSum8 <= temp_mem8;
                                    FinalSum9 <= temp_mem9;
                                    FinalSum10 <= temp_mem10;
                                    FinalSum11 <= temp_mem11;
                                    FinalSum12 <= temp_mem12;
                                    FinalSum13 <= temp_mem13;
                                    FinalSum14 <= temp_mem14;
                                    FinalSum15 <= temp_mem15;
                                    FinalWriteValid <= 1'b1;
                                    stage <= LAST_CHANNEL;
                                end
                            end      
                            
                            
                      MEMRESET : begin
                                    case(Latency)
                                     4'd0 : begin
                                            if(Addr >= 2048)begin
                                                stage <= IDLE;   
                                                Latency <= 1'd0;      
                                            end
                                            else begin
                                                Din_ChAccSum0  <= 32'd0;
                                                Din_ChAccSum1  <= 32'd0;
                                                Din_ChAccSum2  <= 32'd0;
                                                Din_ChAccSum3  <= 32'd0;
                                                Din_ChAccSum4  <= 32'd0;
                                                Din_ChAccSum5  <= 32'd0;
                                                Din_ChAccSum6  <= 32'd0;
                                                Din_ChAccSum7  <= 32'd0;
                                                Din_ChAccSum8  <= 32'd0;
                                                Din_ChAccSum9  <= 32'd0;
                                                Din_ChAccSum10  <= 32'd0;
                                                Din_ChAccSum11  <= 32'd0;
                                                Din_ChAccSum12  <= 32'd0;
                                                Din_ChAccSum13  <= 32'd0;
                                                Din_ChAccSum14  <= 32'd0;
                                                Din_ChAccSum15  <= 32'd0;
                                                Latency <= 1'd1;   
                                            end 
                                            
                                            end
                                            
                                        4'd1: begin
                                                    Addr <= Addr + 1'b1;
                                                    Latency <= 4'd0;    
                                              end        
                                    endcase      
                                 end                                 
            endcase
        end    
        
        end
    
  assign  InternalMemEn = 1'b1;
    
 endmodule

