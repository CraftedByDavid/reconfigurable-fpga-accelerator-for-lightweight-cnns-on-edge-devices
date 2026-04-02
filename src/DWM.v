`timescale 1ns / 1ps

module DWM(
    input clk,
    input reset,
 
    input MaxPoolEn,
    input MaxPoolValid,
    output reg MaxPoolAck,
    
    input signed [7:0] Data_Out_Maxpool_0,
    input signed [7:0] Data_Out_Maxpool_1,
    input signed [7:0] Data_Out_Maxpool_2,
    input signed [7:0] Data_Out_Maxpool_3,
    input signed [7:0] Data_Out_Maxpool_4,
    input signed [7:0] Data_Out_Maxpool_5,
    input signed [7:0] Data_Out_Maxpool_6,
    input signed [7:0] Data_Out_Maxpool_7,
    input signed [7:0] Data_Out_Maxpool_8,
    input signed [7:0] Data_Out_Maxpool_9,
    input signed [7:0] Data_Out_Maxpool_10,
    input signed [7:0] Data_Out_Maxpool_11,
    input signed [7:0] Data_Out_Maxpool_12,
    input signed [7:0] Data_Out_Maxpool_13,
    input signed [7:0] Data_Out_Maxpool_14,
    input signed [7:0] Data_Out_Maxpool_15,
    
    input AccSumValid,
    input DataWriteValid,
    input ReluEn,
    output reg AccSumAck,
    output reg DataWriteAck,
    
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
     
   
    output reg signed [7:0] Data_Out_Int8_0,
    output reg signed [7:0] Data_Out_Int8_1,
    output reg signed [7:0] Data_Out_Int8_2,
    output reg signed [7:0] Data_Out_Int8_3,
    output reg signed [7:0] Data_Out_Int8_4,
    output reg signed [7:0] Data_Out_Int8_5,
    output reg signed [7:0] Data_Out_Int8_6,
    output reg signed [7:0] Data_Out_Int8_7,
    output reg signed [7:0] Data_Out_Int8_8,
    output reg signed [7:0] Data_Out_Int8_9,
    output reg signed [7:0] Data_Out_Int8_10,
    output reg signed [7:0] Data_Out_Int8_11,
    output reg signed [7:0] Data_Out_Int8_12,
    output reg signed [7:0] Data_Out_Int8_13,
    output reg signed [7:0] Data_Out_Int8_14,
    output reg signed [7:0] Data_Out_Int8_15,
    
    output reg [27:0] address_out = 28'd0,
    output reg [15:0] WriteEnable = 16'd0
    );
     
    localparam Stage0 = 0, Stage1 = 1, Stage2 = 2, Stage3 = 3, Stage4 = 4, Stage5 = 5,Stage6 = 6, IDLE = 7 ;
    localparam ScaleFactor = 16'sd258;
    localparam RoundFactor = 48'd16384;
    localparam signed [7:0] MIN_VAL = -128;

    reg [3:0]Stage;
    reg Valid;
    // registers for storing the 16 Int32 accumulated values
    reg signed[31:0] AccValue0, AccValue1, AccValue2, AccValue3;
    reg signed[31:0] AccValue4, AccValue5, AccValue6, AccValue7;
    reg signed[31:0] AccValue8, AccValue9, AccValue10, AccValue11;
    reg signed[31:0] AccValue12, AccValue13, AccValue14, AccValue15;
   
    // registers for storing the 16 scaled values
    reg signed[47:0] ScaledValue0, ScaledValue1, ScaledValue2, ScaledValue3;
    reg signed[47:0] ScaledValue4, ScaledValue5, ScaledValue6, ScaledValue7;
    reg signed[47:0] ScaledValue8, ScaledValue9, ScaledValue10, ScaledValue11;
    reg signed[47:0] ScaledValue12, ScaledValue13, ScaledValue14, ScaledValue15;
   
    // registers for storing 16 rounded values
    reg signed[47:0] RoundValue0, RoundValue1, RoundValue2, RoundValue3;
    reg signed[47:0] RoundValue4, RoundValue5, RoundValue6, RoundValue7;
    reg signed[47:0] RoundValue8, RoundValue9, RoundValue10, RoundValue11;
    reg signed[47:0] RoundValue12, RoundValue13, RoundValue14, RoundValue15;

    // registers for storing 16 right shifted values
    reg signed[47:0] ShiftReg0, ShiftReg1, ShiftReg2, ShiftReg3;
    reg signed[47:0] ShiftReg4, ShiftReg5, ShiftReg6, ShiftReg7;
    reg signed[47:0] ShiftReg8, ShiftReg9, ShiftReg10, ShiftReg11;
    reg signed[47:0] ShiftReg12, ShiftReg13, ShiftReg14, ShiftReg15;
   
    // registers for storing the int8 output accumulated values
    reg signed[7:0] accsum0, accsum1, accsum2, accsum3;
    reg signed[7:0] accsum4, accsum5, accsum6, accsum7;
    reg signed[7:0] accsum8, accsum9, accsum10, accsum11;
    reg signed[7:0] accsum12, accsum13, accsum14, accsum15;
        
    reg WriteFlag = 1'b0;
    reg useless = 1'b0;//this register is used to make sure that the during maxpool valid is only high for one clock cycle
    
    
   
    always@(posedge clk) begin
        if(reset) begin
            Stage <= IDLE;
            Data_Out_Int8_0 <= 0;
            Data_Out_Int8_1 <= 0;
            Data_Out_Int8_2 <= 0;
            Data_Out_Int8_3 <= 0;
            Data_Out_Int8_4 <= 0;
            Data_Out_Int8_5 <= 0;
            Data_Out_Int8_6 <= 0;
            Data_Out_Int8_7 <= 0;
            Data_Out_Int8_8 <= 0;
            Data_Out_Int8_9 <= 0;
            Data_Out_Int8_10 <= 0;
            Data_Out_Int8_11 <= 0;
            Data_Out_Int8_12 <= 0;
            Data_Out_Int8_13 <= 0;
            Data_Out_Int8_14 <= 0;
            Data_Out_Int8_15 <= 0;
            Valid <= 1'b0;  
            useless <= 0;
            MaxPoolAck <= 1'b0;
            WriteEnable <= 16'd0;
            
        end
        else begin
            if(MaxPoolEn == 1'b0)begin
                case(Stage)
                    IDLE: begin
                        AccValue0 <= 0;  AccValue1 <= 0;  AccValue2 <= 0;  AccValue3 <= 0;
                        AccValue4 <= 0;  AccValue5 <= 0;  AccValue6 <= 0;  AccValue7 <= 0;
                        AccValue8 <= 0;  AccValue9 <= 0;  AccValue10 <= 0; AccValue11 <= 0;
                        AccValue12 <= 0; AccValue13 <= 0; AccValue14 <= 0; AccValue15 <= 0;
                        Valid  <= 1'b0;
                        WriteEnable <= 16'd0;
                        AccSumAck <= 1'b0;
                        DataWriteAck <= 1'b0;
                        if (AccSumValid) begin
                            Stage <= Stage0;
                        end
                        else begin
                            Stage <= IDLE;
                        end  
                    end
                    Stage0: begin
                    
                        AccValue0  <= AccSum0 ;   AccValue1  <= AccSum1 ;
                        AccValue2  <= AccSum2 ;   AccValue3  <= AccSum3;
                        AccValue4  <= AccSum4 ;   AccValue5  <= AccSum5;
                        AccValue6  <= AccSum6 ;   AccValue7  <= AccSum7 ;
                        AccValue8  <= AccSum8 ;   AccValue9  <= AccSum9 ;
                        AccValue10 <= AccSum10 ;  AccValue11 <= AccSum11 ;
                        AccValue12 <= AccSum12 ;  AccValue13 <= AccSum13 ;
                        AccValue14 <= AccSum14 ;  AccValue15 <= AccSum15 ;
                        
                        if(DataWriteValid)  begin
                            Stage <= Stage1;
                            AccSumAck <= 1;
                        end
                        else begin
                            Stage <= Stage0;
                        end
                    end
    
                    Stage1: begin
                        DataWriteAck <= 1;
                        AccSumAck <= 0;
                        ScaledValue0  <= (AccValue0  * ScaleFactor);
                        ScaledValue1  <= (AccValue1  * ScaleFactor);
                        ScaledValue2  <= (AccValue2  * ScaleFactor);
                        ScaledValue3  <= (AccValue3  * ScaleFactor);
                        ScaledValue4  <= (AccValue4  * ScaleFactor);
                        ScaledValue5  <= (AccValue5  * ScaleFactor);
                        ScaledValue6  <= (AccValue6  * ScaleFactor);
                        ScaledValue7  <= (AccValue7  * ScaleFactor);
                        ScaledValue8  <= (AccValue8  * ScaleFactor);
                        ScaledValue9  <= (AccValue9  * ScaleFactor);
                        ScaledValue10 <= (AccValue10 * ScaleFactor);
                        ScaledValue11 <= (AccValue11 * ScaleFactor);
                        ScaledValue12 <= (AccValue12 * ScaleFactor);
                        ScaledValue13 <= (AccValue13 * ScaleFactor);
                        ScaledValue14 <= (AccValue14 * ScaleFactor);
                        ScaledValue15 <= (AccValue15 * ScaleFactor);
                        Stage <= Stage2;
                    end
    
                    Stage2: begin
                        DataWriteAck <= 0;
                        RoundValue0  <= ScaledValue0  + RoundFactor;
                        RoundValue1  <= ScaledValue1  + RoundFactor;
                        RoundValue2  <= ScaledValue2  + RoundFactor;
                        RoundValue3  <= ScaledValue3  + RoundFactor;
                        RoundValue4  <= ScaledValue4  + RoundFactor;
                        RoundValue5  <= ScaledValue5  + RoundFactor;
                        RoundValue6  <= ScaledValue6  + RoundFactor;
                        RoundValue7  <= ScaledValue7  + RoundFactor;
                        RoundValue8  <= ScaledValue8  + RoundFactor;
                        RoundValue9  <= ScaledValue9  + RoundFactor;
                        RoundValue10 <= ScaledValue10 + RoundFactor;
                        RoundValue11 <= ScaledValue11 + RoundFactor;
                        RoundValue12 <= ScaledValue12 + RoundFactor;
                        RoundValue13 <= ScaledValue13 + RoundFactor;
                        RoundValue14 <= ScaledValue14 + RoundFactor;
                        RoundValue15 <= ScaledValue15 + RoundFactor;
                        Stage <= Stage3;
                    end
    
                    Stage3: begin
                        ShiftReg0  <= (RoundValue0  >>> 15);
                        ShiftReg1  <= (RoundValue1  >>> 15);
                        ShiftReg2  <= (RoundValue2  >>> 15);
                        ShiftReg3  <= (RoundValue3  >>> 15);
                        ShiftReg4  <= (RoundValue4  >>> 15);
                        ShiftReg5  <= (RoundValue5  >>> 15);
                        ShiftReg6  <= (RoundValue6  >>> 15);
                        ShiftReg7  <= (RoundValue7  >>> 15);
                        ShiftReg8  <= (RoundValue8  >>> 15);
                        ShiftReg9  <= (RoundValue9  >>> 15);
                        ShiftReg10 <= (RoundValue10 >>> 15);
                        ShiftReg11 <= (RoundValue11 >>> 15);
                        ShiftReg12 <= (RoundValue12 >>> 15);
                        ShiftReg13 <= (RoundValue13 >>> 15);
                        ShiftReg14 <= (RoundValue14 >>> 15);
                        ShiftReg15 <= (RoundValue15 >>> 15);
                        Stage <= Stage4;
                    end  
    
                    Stage4: begin
                        if(ShiftReg0 <= -128)        accsum0 <= -128;
                        else if(ShiftReg0 >= 127)   accsum0 <= 127;
                        else                        accsum0 <= ShiftReg0[7:0];
    
                        if(ShiftReg1 <= -128)        accsum1 <= -128;
                        else if(ShiftReg1 >= 127)   accsum1 <= 127;
                        else                        accsum1 <= ShiftReg1[7:0];
    
                        if(ShiftReg2 <= -128)        accsum2 <= -128;
                        else if(ShiftReg2 >= 127)   accsum2 <= 127;
                        else                        accsum2 <= ShiftReg2[7:0];
    
                        if(ShiftReg3 <= -128)        accsum3 <= -128;
                        else if(ShiftReg3 >= 127)   accsum3 <= 127;
                        else                        accsum3 <= ShiftReg3[7:0];
    
                        if(ShiftReg4 <= -128)        accsum4 <= -128;
                        else if(ShiftReg4 >= 127)   accsum4 <= 127;
                        else                        accsum4 <= ShiftReg4[7:0];
    
                        if(ShiftReg5 <= -128)        accsum5 <= -128;
                        else if(ShiftReg5 >= 127)   accsum5 <= 127;
                        else                        accsum5 <= ShiftReg5[7:0];
    
                        if(ShiftReg6 <= -128)        accsum6 <= -128;
                        else if(ShiftReg6 >= 127)   accsum6 <= 127;
                        else                        accsum6 <= ShiftReg6[7:0];
    
                        if(ShiftReg7 <= -128)        accsum7 <= -128;
                        else if(ShiftReg7 >= 127)   accsum7 <= 127;
                        else                        accsum7 <= ShiftReg7[7:0];
    
                        if(ShiftReg8 <= -128)        accsum8 <= -128;
                        else if(ShiftReg8 >= 127)   accsum8 <= 127;
                        else                        accsum8 <= ShiftReg8[7:0];
    
                        if(ShiftReg9 <= -128)        accsum9 <= -128;
                        else if(ShiftReg9 >= 127)   accsum9 <= 127;
                        else                        accsum9 <= ShiftReg9[7:0];
    
                        if(ShiftReg10 <= -128)       accsum10 <= -128;
                        else if(ShiftReg10 >= 127)  accsum10 <= 127;
                        else                        accsum10 <= ShiftReg10[7:0];
    
                        if(ShiftReg11 <= -128)       accsum11 <= -128;
                        else if(ShiftReg11 >= 127)  accsum11 <= 127;
                        else                        accsum11 <= ShiftReg11[7:0];
    
                        if(ShiftReg12 <= -128)       accsum12 <= -128;
                        else if(ShiftReg12 >= 127)  accsum12 <= 127;
                        else                        accsum12 <= ShiftReg12[7:0];
    
                        if(ShiftReg13 <= -128)       accsum13 <= -128;
                        else if(ShiftReg13 >= 127)  accsum13 <= 127;
                        else                        accsum13 <= ShiftReg13[7:0];
    
                        if(ShiftReg14 <= -128)       accsum14 <= -128;
                        else if(ShiftReg14 >= 127)  accsum14 <= 127;
                        else                        accsum14 <= ShiftReg14[7:0];
    
                        if(ShiftReg15 <= -128)       accsum15 <= -128;
                        else if(ShiftReg15 >= 127)  accsum15 <= 127;
                        else                        accsum15 <= ShiftReg15[7:0];
                  
                        Stage <= Stage5; 
                    end
                    Stage5 : begin
                                if(ReluEn == 1'b1)begin
                                    if(accsum0 <= 32'sd0)        Data_Out_Int8_0 <= 0;
                                    else                    Data_Out_Int8_0 <= accsum0;
                                    
                                    if(accsum1 <= 32'sd0)        Data_Out_Int8_1 <= 0;
                                    else                    Data_Out_Int8_1 <= accsum1;
                                    
                                    if(accsum2 <= 32'sd0)        Data_Out_Int8_2 <= 0;
                                    else                    Data_Out_Int8_2 <= accsum2;
                                    
                                    if(accsum3 <= 32'sd0)        Data_Out_Int8_3 <= 0;
                                    else                    Data_Out_Int8_3 <= accsum3;
                                    
                                    if(accsum4 <= 32'sd0)        Data_Out_Int8_4 <= 0;
                                    else                    Data_Out_Int8_4 <= accsum4;
                                    
                                    if(accsum5 <= 32'sd0)        Data_Out_Int8_5 <= 0;
                                    else                    Data_Out_Int8_5 <= accsum5;
                                    
                                    if(accsum6 <= 32'sd0)        Data_Out_Int8_6 <= 0;
                                    else                    Data_Out_Int8_6 <= accsum6;
                                    
                                    if(accsum7 <= 32'sd0)        Data_Out_Int8_7 <= 0;
                                    else                    Data_Out_Int8_7 <= accsum7;
                                    
                                    if(accsum8 <= 32'sd0)        Data_Out_Int8_8 <= 0;
                                    else                    Data_Out_Int8_8 <= accsum8;
                                    
                                    if(accsum9 <= 32'sd0)        Data_Out_Int8_9 <= 0;
                                    else                    Data_Out_Int8_9 <= accsum9;
                                    
                                    if(accsum10 <= 32'sd0)       Data_Out_Int8_10 <= 0;
                                    else                    Data_Out_Int8_10 <= accsum10;
                                    
                                    if(accsum11 <= 32'sd0)       Data_Out_Int8_11 <= 0;
                                    else                    Data_Out_Int8_11 <= accsum11;
                                    
                                    if(accsum12 <= 32'sd0)       Data_Out_Int8_12 <= 0;
                                    else                    Data_Out_Int8_12 <= accsum12;
                                    
                                    if(accsum13 <= 32'sd0)       Data_Out_Int8_13 <= 0;
                                    else                    Data_Out_Int8_13 <= accsum13;
                                    
                                    if(accsum14 <= 32'sd0)       Data_Out_Int8_14 <= 0;
                                    else                    Data_Out_Int8_14 <= accsum14;
                                    
                                    if(accsum15 <= 32'sd0)       Data_Out_Int8_15 <= 0;
                                    else                    Data_Out_Int8_15 <= accsum15;       
                                end
                                else begin
                                    Data_Out_Int8_0 <= accsum0;
                                    Data_Out_Int8_1 <= accsum1;
                                    Data_Out_Int8_2 <= accsum2;
                                    Data_Out_Int8_3 <= accsum3;
                                    Data_Out_Int8_4 <= accsum4;
                                    Data_Out_Int8_5 <= accsum5;
                                    Data_Out_Int8_6 <= accsum6;
                                    Data_Out_Int8_7 <= accsum7;
                                    Data_Out_Int8_8 <= accsum8;
                                    Data_Out_Int8_9 <= accsum9;
                                    Data_Out_Int8_10 <= accsum10;
                                    Data_Out_Int8_11 <= accsum11;
                                    Data_Out_Int8_12 <= accsum12;
                                    Data_Out_Int8_13 <= accsum13;
                                    Data_Out_Int8_14 <= accsum14;
                                    Data_Out_Int8_15 <= accsum15;
                                end
                                Stage <= Stage6 ;
                             end
                             
                             Stage6 : begin
                                        Valid <= 1'b1;
                                        WriteEnable <= 16'hFFFF;
                                        Stage <= IDLE;    
                                      end
                    
                endcase
            end
            else begin
                if((MaxPoolValid == 1'b1) && (MaxPoolAck == 1'b0))begin
                    Data_Out_Int8_0  <= Data_Out_Maxpool_0;
                    Data_Out_Int8_1  <= Data_Out_Maxpool_1;
                    Data_Out_Int8_2  <= Data_Out_Maxpool_2;
                    Data_Out_Int8_3  <= Data_Out_Maxpool_3;
                    Data_Out_Int8_4  <= Data_Out_Maxpool_4;
                    Data_Out_Int8_5  <= Data_Out_Maxpool_5;
                    Data_Out_Int8_6  <= Data_Out_Maxpool_6;
                    Data_Out_Int8_7  <= Data_Out_Maxpool_7;
                    Data_Out_Int8_8  <= Data_Out_Maxpool_8;
                    Data_Out_Int8_9  <= Data_Out_Maxpool_9;
                    Data_Out_Int8_10 <= Data_Out_Maxpool_10;
                    Data_Out_Int8_11 <= Data_Out_Maxpool_11;
                    Data_Out_Int8_12 <= Data_Out_Maxpool_12;
                    Data_Out_Int8_13 <= Data_Out_Maxpool_13;
                    Data_Out_Int8_14 <= Data_Out_Maxpool_14;
                    Data_Out_Int8_15 <= Data_Out_Maxpool_15;   
                   
                    if(useless == 0) begin
                        Valid <= 1;
                        WriteEnable <= 16'hFFFF;
                        useless <= 1;
                        MaxPoolAck <= 1'b1;
                    end
                    if(useless == 1) begin
                        Valid <= 0;
                        WriteEnable <= 16'd0;
                    end                    
                end
                else begin
                    Data_Out_Int8_0  <= MIN_VAL;
                    Data_Out_Int8_1  <= MIN_VAL;
                    Data_Out_Int8_2  <= MIN_VAL;
                    Data_Out_Int8_3  <= MIN_VAL;
                    Data_Out_Int8_4  <= MIN_VAL;
                    Data_Out_Int8_5  <= MIN_VAL;
                    Data_Out_Int8_6  <= MIN_VAL;
                    Data_Out_Int8_7  <= MIN_VAL;
                    Data_Out_Int8_8  <= MIN_VAL;
                    Data_Out_Int8_9  <= MIN_VAL;
                    Data_Out_Int8_10 <= MIN_VAL;
                    Data_Out_Int8_11 <= MIN_VAL;
                    Data_Out_Int8_12 <= MIN_VAL;
                    Data_Out_Int8_13 <= MIN_VAL;
                    Data_Out_Int8_14 <= MIN_VAL;
                    Data_Out_Int8_15 <= MIN_VAL;    
                   
                    Valid <= 1'b0;
                    useless <= 0;
                    MaxPoolAck <= 1'b0;
                end    
            end
            
        end
    end
    
 
    always@(posedge clk)begin
        if(reset)begin
            address_out = 28'd0;
            WriteFlag <= 1'b0;
        end
        else begin
            if(Valid == 1'b1)begin
                address_out <= address_out + 1;
            end
        end
    end
    
endmodule
