`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2026 21:31:22
// Design Name: 
// Module Name: reroll_tracker
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



module reroll_tracker(
    input clk, gamestart,
    input [15:1] sw,
    input [3:0] reroll_remain,
    output [3:0] reroll_start, 
    output reg [6:0] seg,
    output reg [3:0] an
);

    reg [3:0] sw_val; 
    reg [3:0] firstdigit;
    reg [3:0] seconddigit;
    wire [6:0] displayfirst;
    wire [6:0] displaysecond;

    always @ (*) begin
        if (sw[15:1] == 0)   sw_val = 4'd0;
        else if (sw[15]==1) sw_val = 4'd15;
        else if (sw[14]==1) sw_val = 4'd14;
        else if (sw[13]==1) sw_val = 4'd13;
        else if (sw[12]==1) sw_val = 4'd12;
        else if (sw[11]==1) sw_val = 4'd11;
        else if (sw[10]==1) sw_val = 4'd10;
        else if (sw[9]==1)  sw_val = 4'd9;
        else if (sw[8]==1)  sw_val = 4'd8;
        else if (sw[7]==1)  sw_val = 4'd7;
        else if (sw[6]==1)  sw_val = 4'd6;
        else if (sw[5]==1)  sw_val = 4'd5;
        else if (sw[4]==1)  sw_val = 4'd4;
        else if (sw[3]==1)  sw_val = 4'd3;
        else if (sw[2]==1)  sw_val = 4'd2;
        else if (sw[1]==1)  sw_val = 4'd1;
        else                sw_val = 4'd0;
    end

    assign reroll_start = sw_val; 

    always @ (posedge clk) begin
        if (~gamestart) begin
            if (sw_val > 4'd9) begin
                seconddigit <= 4'd1;
                firstdigit <= sw_val - 4'd10;
            end else begin
                seconddigit <= 4'd0;
                firstdigit <= sw_val;
            end
        end 
        else begin
            if (reroll_remain > 4'd9) begin
                seconddigit <= 4'd1;
                firstdigit <= reroll_remain - 4'd10;
            end else begin
                seconddigit <= 4'd0;
                firstdigit <= reroll_remain;
            end
        end
    end

    segmentbits phm(firstdigit, displayfirst);
    segmentbits phm2(seconddigit, displaysecond);
    
    reg state = 0;
    reg [17:0] count = 0;
    always @(posedge clk) begin
        count <= (count == 18'd25000) ? 0 : count + 1;
        state <= (count == 0) ? ~state : state; 
        case (state) 
            0: begin
                seg <= displayfirst;
                an <= 4'b1110;
            end
            1: begin
                seg <= displaysecond;
                an <= 4'b1101;
            end
        endcase
    end
endmodule

module segmentbits(input [3:0] number, output [6:0] bits);
    
    reg [6:0] code;
    assign bits = code;
    always @ (*) begin
    case (number) 
    0: code = 7'b1000000;
    1: code = 7'b1111001;
    2: code = 7'b0100100;
    3: code = 7'b0110000;
    4: code = 7'b0011001;
    5: code = 7'b0010010;
    6: code = 7'b0000010;
    7: code = 7'b1111000;
    8: code = 7'b0000000;
    9: code = 7'b0010000;
    default: code = 7'b1111111;
    endcase
    
    end

endmodule
