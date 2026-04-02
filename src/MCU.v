
`timescale 1ns / 1ps
// MCU - Memory Control Unit

module MCU(
    input clk,          
    input start,  
    input [3:0]Stride,
    input reset,
    input [9:0]SlideHorizontalSize,
    input [9:0] SlideVerticalSize,
    input [7:0]KernelSize,
    input [7:0] ImageSize,
    input DepthwiseConvEnb,
    
    input StartChannelSum,
    input LastChannel,
    input FinalWriteAck,
    //input FinalValid,
    
    
    input MaxPoolEn,
    input MaxPoolAck,
    output reg MaxPoolStart,
    output reg MaxPoolEnd,
    output reg MaxPoolReset,
    
    output DspEnable1_1,
    output DspEnable1_2,
    output DspEnable1_3,
    output DspEnable1_4,
    output DspEnable1_5,
    output DspEnable1_6,
    output DspEnable1_7,
    output DspEnable1_8,
    output DspEnable2_1,
    output DspEnable2_2,
    output DspEnable2_3,
    output DspEnable2_4,
    output DspEnable2_5,
    output DspEnable2_6,
    output DspEnable2_7,
    output DspEnable2_8,
     
    
    output reg [7:0]KernelIndex,   
    output reg done,
    output reg [27:0] PixelAddr,
    
    
    output reg patch_procesing_done,
    input DataWriteAck,
    output reg DataWriteValid, 
    output reg StartAcc,
    output reg ChannelConvDone,
   
    output reg [7:0] OffsetAddr
);
 //FSM_stages
    parameter [3:0] IDLE = 4'b0000;
    parameter [3:0] PATCH_PROCESSING = 4'b0011;
    parameter [3:0] SET_HORIZONTAL = 4'b0010;
    parameter [3:0] SET_VERTICAL = 4'b0001;
    parameter [3:0] DEPTHWISE_WRITE = 4'b1000; 
    parameter [3:0] STDCONV_WRITE = 4'b1001;
    parameter [3:0] MAXPOOL = 4'b1010; 
    parameter [3:0] DONE = 4'b1011;  
    
    wire [7:0]PatchCount;
    wire [17:0] Stage1 ;
    
     
    reg [3:0] PS, NS;
    reg [15:0] Offset;
    reg [15:0] HorizontalSlide;
    reg [15:0] VerticalSlide;
    reg [7:0] VerticalCount;
    reg [7:0] HorizontalCount;
    reg [2:0]Latency;
    reg KernelIndexFlag;  
    reg useless;
    reg WrtFlg;
    reg [15:0]DspEnable;
    
    
   
    
     
    //add onter always blocks as below for other kernesl
    always @(*) begin
            Offset = 16'd0;
        case (KernelSize)

        8'd1: begin
            case (OffsetAddr)
                8'd0: begin Offset = 0; end
                default: begin Offset = 0; end
            endcase
        end
        
        8'd2 : begin
             case (OffsetAddr)
                8'd0: begin Offset = 0; end
                8'd1: begin Offset = 1; end
                8'd2: begin Offset = ImageSize; end
                8'd3: begin Offset = ImageSize+1; end
                default: begin Offset = 0; end
            endcase       
            
               end
    
        8'd3: begin // this case block is used for a 3x3 kernel
            case (OffsetAddr)
                8'd0: begin Offset = 0; end
                8'd1: begin Offset = 1; end
                8'd2: begin Offset = 2; end
                8'd3: begin Offset = ImageSize; end
                8'd4: begin Offset = ImageSize+1; end
                8'd5: begin Offset = ImageSize+2; end
                8'd6: begin Offset = (ImageSize*2); end
                8'd7: begin Offset = (ImageSize*2)+1; end
                8'd8: begin Offset = (ImageSize*2)+2; end
                default: begin Offset = 0; end
            endcase
        end
    
        8'd5: begin // this case block is used for a 5x5 kernel
            case (OffsetAddr)
                8'd0: begin Offset = 0; end
                8'd1: begin Offset = 1; end
                8'd2: begin Offset = 2; end
                8'd3: begin Offset = 3; end
                8'd4: begin Offset = 4; end
                8'd5: begin Offset = ImageSize; end
                8'd6: begin Offset = ImageSize+1; end
                8'd7: begin Offset = ImageSize+2; end
                8'd8: begin Offset = ImageSize+3; end
                8'd9: begin Offset = ImageSize+4; end
                8'd10: begin Offset = (ImageSize*2); end
                8'd11: begin Offset = (ImageSize*2)+1; end
                8'd12: begin Offset = (ImageSize*2)+2; end
                8'd13: begin Offset = (ImageSize*2)+3; end
                8'd14: begin Offset = (ImageSize*2)+4; end
                8'd15: begin Offset = (ImageSize*3); end
                8'd16: begin Offset = (ImageSize*3)+1; end
                8'd17: begin Offset = (ImageSize*3)+2; end
                8'd18: begin Offset = (ImageSize*3)+3; end
                8'd19: begin Offset = (ImageSize*3)+4; end
                8'd20: begin Offset = (ImageSize*4); end
                8'd21: begin Offset = (ImageSize*4)+1; end
                8'd22: begin Offset = (ImageSize*4)+2; end
                8'd23: begin Offset = (ImageSize*4)+3; end
                8'd24: begin Offset = (ImageSize*4)+4; end
                default: begin Offset = 0; end
            endcase
        end
    
        8'd7: begin // this case block is used for a 7x7 kernel
            case (OffsetAddr)
                8'd0: begin Offset = 0; end
                8'd1: begin Offset = 1; end
                8'd2: begin Offset = 2; end
                8'd3: begin Offset = 3; end
                8'd4: begin Offset = 4; end
                8'd5: begin Offset = 5; end
                8'd6: begin Offset = 6; end
    
                8'd7: begin Offset = ImageSize; end
                8'd8: begin Offset = ImageSize+1; end
                8'd9: begin Offset = ImageSize+2; end
                8'd10: begin Offset = ImageSize+3; end
                8'd11: begin Offset = ImageSize+4; end
                8'd12: begin Offset = ImageSize+5; end
                8'd13: begin Offset = ImageSize+6; end
    
                8'd14: begin Offset = (ImageSize*2); end
                8'd15: begin Offset = (ImageSize*2)+1; end
                8'd16: begin Offset = (ImageSize*2)+2; end
                8'd17: begin Offset = (ImageSize*2)+3; end
                8'd18: begin Offset = (ImageSize*2)+4; end
                8'd19: begin Offset = (ImageSize*2)+5; end
                8'd20: begin Offset = (ImageSize*2)+6; end
    
                8'd21: begin Offset = (ImageSize*3); end
                8'd22: begin Offset = (ImageSize*3)+1; end
                8'd23: begin Offset = (ImageSize*3)+2; end
                8'd24: begin Offset = (ImageSize*3)+3; end
                8'd25: begin Offset = (ImageSize*3)+4; end
                8'd26: begin Offset = (ImageSize*3)+5; end
                8'd27: begin Offset = (ImageSize*3)+6; end
    
                8'd28: begin Offset = (ImageSize*4); end
                8'd29: begin Offset = (ImageSize*4)+1; end
                8'd30: begin Offset = (ImageSize*4)+2; end
                8'd31: begin Offset = (ImageSize*4)+3; end
                8'd32: begin Offset = (ImageSize*4)+4; end
                8'd33: begin Offset = (ImageSize*4)+5; end
                8'd34: begin Offset = (ImageSize*4)+6; end
    
                8'd35: begin Offset = (ImageSize*5); end
                8'd36: begin Offset = (ImageSize*5)+1; end
                8'd37: begin Offset = (ImageSize*5)+2; end
                8'd38: begin Offset = (ImageSize*5)+3; end
                8'd39: begin Offset = (ImageSize*5)+4; end
                8'd40: begin Offset = (ImageSize*5)+5; end
                8'd41: begin Offset = (ImageSize*5)+6; end
    
                8'd42: begin Offset = (ImageSize*6); end
                8'd43: begin Offset = (ImageSize*6)+1; end
                8'd44: begin Offset = (ImageSize*6)+2; end
                8'd45: begin Offset = (ImageSize*6)+3; end
                8'd46: begin Offset = (ImageSize*6)+4; end
                8'd47: begin Offset = (ImageSize*6)+5; end
                8'd48: begin Offset = (ImageSize*6)+6; end
    
                default: begin Offset = 0; end
            endcase
        end  
    endcase   
end


always @(posedge clk) begin
    if (reset) begin
        PS <= IDLE;
    end
     
    else begin
        PS <= NS;
    end
end

always @(*) begin
    NS = PS;
        case (PS)
            IDLE: begin
                if (start) begin
                    NS = PATCH_PROCESSING;
                end
                else begin
                    NS = IDLE;
                end
           end
           MAXPOOL :begin
                        if(OffsetAddr == 1'b0)begin 
                            if(MaxPoolAck == 1'b1) begin
                                NS =  PATCH_PROCESSING ;    
                            end
                            else begin
                                NS = MAXPOOL; 
                                
                            end        
                        end
                        else begin
                            NS =  PATCH_PROCESSING ;   
                        end    
                    end 
           
           DEPTHWISE_WRITE : begin  
                if(OffsetAddr == 1'b0)begin
                    if((DataWriteAck == 1'b1) && (DataWriteValid == 1'b1))begin
                        NS =  PATCH_PROCESSING;
                    end
                    else begin
                        NS =  DEPTHWISE_WRITE;
                    end  
                end
                else begin
                    NS =  PATCH_PROCESSING ; 
                end 
           end
           
           STDCONV_WRITE : begin  
                if(OffsetAddr == 1'b0)begin
                   if(Latency == 2)begin
                        if(LastChannel == 1'b1)begin
                       //     if(StartChannelSum)begin
                                if(FinalWriteAck == 1'b1)begin
                                   // NS =  PATCH_PROCESSING;
                                   NS =  DEPTHWISE_WRITE;     
                                end    
                                else begin
                                    NS =  STDCONV_WRITE;
                                end 
                       //     end
                         //   else begin
                       //         NS =  STDCONV_WRITE;
                       //     end    
                        end
                        else begin
                            if(StartChannelSum)begin
                                NS =  PATCH_PROCESSING;     
                            end
                            else begin
                                NS =  STDCONV_WRITE;
                            end
                        end
                   end
                   else begin
                        NS =  STDCONV_WRITE ;
                   end
                end    
                   
                else begin
                    NS =  PATCH_PROCESSING ; 
                end 
           
           end
           
           SET_VERTICAL: begin
                if(MaxPoolEn == 1'b1)begin
                   NS = MAXPOOL;
                end
                else begin
                    if(DepthwiseConvEnb == 1'b1)begin
                         NS =  DEPTHWISE_WRITE;                    
                    end
                    else begin
                         NS =  STDCONV_WRITE;   
                    end
                     
                end
                
           end
           
           SET_HORIZONTAL:  begin
               NS =  SET_VERTICAL;      
           end
           
           PATCH_PROCESSING : begin
                if(VerticalCount >= SlideVerticalSize) begin
                    NS = DONE;
                end
                else begin
                    NS =  SET_HORIZONTAL;  
                end      
           end
           
           DONE :begin
                if (done) begin
                    //NS = IDLE;
                    $finish;
                end 
           end
           
           default : NS = IDLE;
       endcase    
     end
 
 
 always @(posedge clk) begin
    if (reset) begin
         OffsetAddr <=0;
         HorizontalSlide <= 0;
         VerticalSlide <= 0;
         PixelAddr <= 0;
         Latency <=0;
         done <=0 ; 
         patch_procesing_done <= 0;
         DspEnable <= 16'b0;
         KernelIndexFlag <= 0;
         KernelIndex <= 8'd0;
         VerticalCount <= 0;
         HorizontalCount <= 0;
         StartAcc <= 0;
         MaxPoolStart <= 0;
         MaxPoolEnd <= 0;
         MaxPoolReset <= 0;
         ChannelConvDone <= 1'b0;
    end
     
    else begin
    case (PS)
           IDLE: begin
                 OffsetAddr <=0;
                 HorizontalSlide <= 0;
                 VerticalSlide <= 0;
                 KernelIndex <= 8'd0;
                 PixelAddr <= 0;
                 Latency <=0;
                 patch_procesing_done <= 0;
                 DspEnable <= 16'b0;
                 done <=0 ; 
                 KernelIndexFlag <= 0;
                 VerticalCount <= 0;
                 HorizontalCount <= 0;
                 StartAcc <= 0;
                 MaxPoolStart <= 0;
                 MaxPoolEnd <= 0;
                 MaxPoolReset <= 0;
           end
           
           
           MAXPOOL :begin
                        if(OffsetAddr == 1'b0)begin 
                            if(MaxPoolAck == 1'b1) begin
                              MaxPoolStart <= 1'b0; 
                              MaxPoolEnd <= 1'b0;
                              MaxPoolReset <= 1'b1;   
                            end
                            else begin
                              MaxPoolStart <= 1'b0; 
                              MaxPoolEnd <= 1'b1;
                              MaxPoolReset <= 1'b0;  
                                
                            end        
                        end
                        else begin
                            MaxPoolStart <= 1'b1; 
                            MaxPoolEnd <= 1'b0;
                            MaxPoolReset <= 1'b0;  
                        end
                       
                    end
  
           
           DEPTHWISE_WRITE : begin
                 if(OffsetAddr == 1'b0)begin  
                    case(Latency)
                        3'd0 : begin
                                StartAcc <= 1;
                                DspEnable <= 16'b0;  
                                Latency <= 3'd1;
                               end 
                        3'd1 : begin
                                 StartAcc <= 0;
                                 Latency <= 3'd2;
                                 patch_procesing_done <= 1;
                               end
                        3'd2 : begin
                                 DataWriteValid <= 1;
                                 patch_procesing_done <= 0;
                                 if(DataWriteAck == 1'b1)begin
                                    Latency <= 3'd0;
                                 end
                               end
                        endcase                  
                end
                else begin
                    DspEnable <= 16'b0; 
                    StartAcc <= 1;
                end    
           end
           
           
           STDCONV_WRITE : begin
                if(OffsetAddr == 1'b0)begin 
                    case(Latency)
                        3'd0: begin
                                StartAcc <= 1;
                                DspEnable <= 16'b0; 
                                Latency <= 3'd1; 
                              end
                          
                        3'd1 : begin
                                 StartAcc <= 0;
                                 Latency <= 3'd2;
                                 patch_procesing_done <= 1;
                               end 
                        3'd2 : begin
                                patch_procesing_done <= 0;
                                if(LastChannel == 1'b1)begin
                                     if(StartChannelSum)begin
                                        if(FinalWriteAck == 1'b1)begin
                                           // NS =  PATCH_PROCESSING; 
                                            Latency <= 3'd0;   
                                        end    
                                        else begin
                                            //NS =  STDCONV_WRITE;
                                            Latency <= 3'd2;
                                        end 
                                    end
                                    else begin
                                        //NS =  STDCONV_WRITE;
                                        Latency <= 3'd2;
                                    end    
                                end
                                else begin
                                     if(StartChannelSum)begin
                                    //    NS =  PATCH_PROCESSING; 
                                     Latency <= 3'd0;    
                                    end
                                    else begin
                                    //    NS =  STDCONV_WRITE;
                                    Latency <= 3'd2;
                                    end    
                                end              
                               end  
                       
                                                      
                                            
                    endcase 
                   
                end
                else begin
                    DspEnable <= 16'b0; 
                    StartAcc <= 1;
                end    
           end
           
           SET_VERTICAL: begin
                if(HorizontalCount >= SlideHorizontalSize) begin
                    VerticalSlide <=  VerticalSlide + Stride;
                    VerticalCount <= VerticalCount + 1'b1;
                    HorizontalCount <= 0;
                    HorizontalSlide <= 0;
                end
                else begin
                    VerticalSlide <=  VerticalSlide ; 
                    VerticalCount <= VerticalCount ; 
                end
                 if(MaxPoolEn == 1'b1)begin
                    DspEnable <= 16'h0000;
                 end
                 else begin                
                    DspEnable <= 16'hFFFF;
                 end        
           end 
           
           SET_HORIZONTAL:  begin
                if(OffsetAddr >= (PatchCount - 1))begin
                    HorizontalSlide <= HorizontalSlide + Stride;
                    HorizontalCount <= HorizontalCount + 1'b1; 
                    KernelIndexFlag <= 1'b0;
                    OffsetAddr <=0;
                end
                else begin
                    HorizontalSlide <= HorizontalSlide;
                    HorizontalCount <= HorizontalCount;
                    OffsetAddr <= OffsetAddr + 1;
                    if(MaxPoolEn == 1'b1)begin
                        MaxPoolStart <= 1'b1;
                    end
                end   
           end
            
           PATCH_PROCESSING : begin
                    if( HorizontalCount < SlideHorizontalSize && VerticalCount < SlideVerticalSize) begin
                        if(MaxPoolEn == 1'b1)begin
                            //logic space for maxpool
                        end
                        else if(MaxPoolEn == 1'b0) begin
                            if(KernelIndexFlag == 1'b0)begin
                                KernelIndex <= 1'b0;
                                KernelIndexFlag <= 1'b1;
                            end
                            if(KernelIndexFlag == 1'b1)begin 
                                KernelIndex <= KernelIndex + 1'b1;
                            end
                            DspEnable <= 16'b0; 
                            StartAcc <= 0;  
                            DataWriteValid <= 0;
                        end
                        PixelAddr <= (Offset + HorizontalSlide) + Stage1 ;
                            
                        
                    end
                    if( VerticalCount >= SlideVerticalSize) begin
                         VerticalCount <= 0;
                         VerticalSlide <= 0;      
                    end              
           end
           
           DONE: begin
                    done <= 1'b1;
                                        
                 end
             
           default : begin
                        done <=0 ; 
                     end      
    endcase
  end
end

    reg [63:0] clock_cycle = 64'd0;
    always@(posedge clk) begin
        if(reset) begin
            clock_cycle <= 64'd0; 
        end
        else begin
            if(start && !done) begin
                clock_cycle <= clock_cycle + 1;
            end
            else begin
                clock_cycle <= clock_cycle;
            end
        end
    end
    
 assign PatchCount = KernelSize*KernelSize;
 assign Stage1 = (VerticalSlide*ImageSize);
 
 //for the dsp enable signals
 assign DspEnable1_1 = DspEnable[0];
 assign DspEnable1_2 = DspEnable[1];
 assign DspEnable1_3 = DspEnable[3];
 assign DspEnable1_4 = DspEnable[3];
 assign DspEnable1_5 = DspEnable[4];
 assign DspEnable1_6 = DspEnable[5];
 assign DspEnable1_7 = DspEnable[6];
 assign DspEnable1_8 = DspEnable[7];
 assign DspEnable2_1 = DspEnable[8];
 assign DspEnable2_2 = DspEnable[9];
 assign DspEnable2_3 = DspEnable[10];
 assign DspEnable2_4 = DspEnable[11];
 assign DspEnable2_5 = DspEnable[12];
 assign DspEnable2_6 = DspEnable[13];
 assign DspEnable2_7 = DspEnable[14];
 assign DspEnable2_8 = DspEnable[15];


           
endmodule       

   
   
   
   
   
   
   
 
