`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2026 07:08:46 PM
// Design Name: 
// Module Name: score_display
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


module score_display (
    input        clk,
    input        reset,
    input [12:0] pixel_index,
    input  [15:0] score_input,
    output [15:0] pixel_data
);

    parameter [15:0] COLOR_LABEL = 16'hFFFF; 
    parameter [15:0] COLOR_DIGIT = 16'hFE20; 
    parameter [15:0] COLOR_BG    = 16'd0;   

    localparam [6:0] LW = 7'd12;
    localparam [6:0] LH = 7'd16;
    localparam [6:0] LT = 7'd2;
    localparam [6:0] LG = 7'd3;
    localparam [6:0] LY = 7'd2;
    localparam [6:0] LX = 7'd12; // (96 - 5*12 - 4*3) / 2 = 12


    localparam [6:0] DW = 7'd18;
    localparam [6:0] DH = 7'd24;
    localparam [6:0] DT = 7'd4;
    localparam [6:0] DG = 7'd3;
    localparam [6:0] DY = 7'd22; 
    localparam [6:0] DX = 7'd7;

    //Pixel coordinates
    wire [6:0] px = pixel_index % 7'd96;
    wire [6:0] py = pixel_index / 7'd96;

    //Score counter
    reg [15:0] score;
    always @(posedge clk) begin
        if (reset) score <= 0;
        else score <=score_input;
    end

    //BCD
    wire [3:0] thou, hund, tens, ones;
    bin_to_bcd bcd (.bin(score), .thou(thou), .hund(hund),
                    .tens(tens), .ones(ones));

    wire s_on, c_on, o_on, r_on, e_on;
    draw_segment lS (.px(px),.py(py),.x0(LX+0*(LW+LG)),.y0(LY),.code(4'd10),.W(LW),.H(LH),.T(LT),.on(s_on));
    draw_segment lC (.px(px),.py(py),.x0(LX+1*(LW+LG)),.y0(LY),.code(4'd11),.W(LW),.H(LH),.T(LT),.on(c_on));
    draw_segment lO (.px(px),.py(py),.x0(LX+2*(LW+LG)),.y0(LY),.code(4'd12),.W(LW),.H(LH),.T(LT),.on(o_on));
    draw_segment lR (.px(px),.py(py),.x0(LX+3*(LW+LG)),.y0(LY),.code(4'd13),.W(LW),.H(LH),.T(LT),.on(r_on));
    draw_segment lE (.px(px),.py(py),.x0(LX+4*(LW+LG)),.y0(LY),.code(4'd14),.W(LW),.H(LH),.T(LT),.on(e_on));
    wire label_on = s_on | c_on | o_on | r_on | e_on;


    wire d3_on, d2_on, d1_on, d0_on;
    draw_segment n3 (.px(px),.py(py),.x0(DX+0*(DW+DG)),.y0(DY),.code(thou),.W(DW),.H(DH),.T(DT),.on(d3_on));
    draw_segment n2 (.px(px),.py(py),.x0(DX+1*(DW+DG)),.y0(DY),.code(hund),.W(DW),.H(DH),.T(DT),.on(d2_on));
    draw_segment n1 (.px(px),.py(py),.x0(DX+2*(DW+DG)),.y0(DY),.code(tens),.W(DW),.H(DH),.T(DT),.on(d1_on));
    draw_segment n0 (.px(px),.py(py),.x0(DX+3*(DW+DG)),.y0(DY),.code(ones),.W(DW),.H(DH),.T(DT),.on(d0_on));
    wire digits_on = d3_on | d2_on | d1_on | d0_on;

    // output pixel_data 
    assign pixel_data = digits_on ? COLOR_DIGIT :
                        label_on  ? COLOR_LABEL :
                                    COLOR_BG;
endmodule

module clk6p25m (
    input  clk, reset,
    output reg clk6p25m
);
    reg [2:0] cnt;
    always @(posedge clk) begin
        if (reset) begin cnt <= 0; clk6p25m <= 0; end
        else begin
            cnt <= cnt + 1;
            clk6p25m <= (cnt == 0) ? ~clk6p25m : clk6p25m;
        end
    end
endmodule

module draw_segment (
    input [6:0] px, py,
    input [6:0] x0, y0,
    input [3:0] code,
    input [6:0] W, H, T,
    output on
);
    wire [6:0] H2 = H >> 1;
    wire [6:0] T2 = T >> 1;


    wire seg_a = (px>=x0)     && (px<x0+W)   && (py>=y0)       && (py<y0+T);
    wire seg_b = (px>=x0+W-T) && (px<x0+W)   && (py>=y0)       && (py<y0+H2);
    wire seg_c = (px>=x0+W-T) && (px<x0+W)   && (py>=y0+H2)    && (py<y0+H);
    wire seg_d = (px>=x0)     && (px<x0+W)   && (py>=y0+H-T)   && (py<y0+H);
    wire seg_e = (px>=x0)     && (px<x0+T)   && (py>=y0+H2)    && (py<y0+H);
    wire seg_f = (px>=x0)     && (px<x0+T)   && (py>=y0)       && (py<y0+H2);
    wire seg_g = (px>=x0)     && (px<x0+W)   && (py>=y0+H2-T2) && (py<y0+H2+T2);


    reg [6:0] segs;
    always @(*) begin
        case (code)
            4'd0: segs = 7'b0111111;
            4'd1: segs = 7'b0000110; 
            4'd2: segs = 7'b1011011; 
            4'd3: segs = 7'b1001111;
            4'd4: segs = 7'b1100110; 
            4'd5: segs = 7'b1101101; 
            4'd6: segs = 7'b1111101; 
            4'd7: segs = 7'b0000111; 
            4'd8: segs = 7'b1111111; 
            4'd9: segs = 7'b1101111;
            4'd10: segs = 7'b1101101; 
            4'd11: segs = 7'b0111001; 
            4'd12: segs = 7'b0111111; 
            4'd13: segs = 7'b1110111;      
            4'd14: segs = 7'b1111001; 
            default: segs = 7'b0000000;
        endcase
    end

    assign on = (segs[0] & seg_a) | (segs[1] & seg_b) |
                (segs[2] & seg_c) | (segs[3] & seg_d) |
                (segs[4] & seg_e) | (segs[5] & seg_f) |
                (segs[6] & seg_g);
endmodule



module bin_to_bcd (
    input  [15:0] bin,
    output reg [3:0] thou, hund, tens, ones
);
    integer i;
    reg [31:0] s;
    always @(*) begin
        s = 32'd0;
        s[15:0] = bin;
        for (i = 0; i < 16; i = i + 1) begin
            if (s[19:16] >= 5) s[19:16] = s[19:16] + 3;
            if (s[23:20] >= 5) s[23:20] = s[23:20] + 3;
            if (s[27:24] >= 5) s[27:24] = s[27:24] + 3;
            if (s[31:28] >= 5) s[31:28] = s[31:28] + 3;
            s = s << 1;
        end
        ones = s[19:16]; tens = s[23:20];
        hund = s[27:24]; thou = s[31:28];
    end
endmodule

