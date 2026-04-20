`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2026 22:29:05
// Design Name: 
// Module Name: gameover
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


module switchtoreturn(
    input [9:0] xcoord, 
    input [9:0] ycoord, 
    output cond
);
    // Centering "Turn off SW0 to return to start"
    // Total Chars: 29. 29 * 16px = 464px. (640-464)/2 = 88. 
    localparam SX = 10'd88;
    localparam SY = 10'd350;
    
    wire c0_T, c1_u, c2_r, c3_n;          // Turn
    wire c5_o, c6_f, c7_f;               // off
    wire c9_S, c10_W, c11_0;             // SW0
    wire c13_t, c14_o;                   // to
    wire c16_r, c17_e, c18_t, c19_u, c20_r, c21_n; // return
    wire c23_t, c24_o;                   // to
    wire c26_s, c27_t, c28_a, c29_r, c30_t; // start

    // --- Revised "f" Logic ---
    // Using a vertical stem, a top hook, and a mid-crossbar
    // Position 6
    assign c6_f = (xcoord >= SX+101 && xcoord < SX+103 && ycoord >= SY && ycoord < SY+16) ||  // Vertical Stem
                  (xcoord >= SX+101  && xcoord < SX+108 && ycoord >= SY && ycoord < SY+2)  ||  // Top Hook EDITED
                  (xcoord >= SX+97  && xcoord < SX+105 && ycoord >= SY+6 && ycoord < SY+8);   // Crossbar
    
    // Position 7
    assign c7_f = (xcoord >= SX+117 && xcoord < SX+119 && ycoord >= SY && ycoord < SY+16) ||  // Vertical Stem
                  (xcoord >= SX+117 && xcoord < SX+124 && ycoord >= SY && ycoord < SY+2)  ||  // Top Hook EDITED
                  (xcoord >= SX+113 && xcoord < SX+121 && ycoord >= SY+6 && ycoord < SY+8);   // Crossbar

    // --- Rest of the String ---
    
    // Turn
    assign c0_T = (xcoord >= SX && xcoord < SX+12 && ycoord >= SY && ycoord < SY+2) ||
                  (xcoord >= SX+5 && xcoord < SX+7 && ycoord >= SY && ycoord < SY+16);
    assign c1_u = (xcoord >= SX+16 && xcoord < SX+18 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+26 && xcoord < SX+28 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+16 && xcoord < SX+28 && ycoord >= SY+14 && ycoord < SY+16);
    assign c2_r = (xcoord >= SX+32 && xcoord < SX+34 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+32 && xcoord < SX+42 && ycoord >= SY+4 && ycoord < SY+6);
    assign c3_n = (xcoord >= SX+48 && xcoord < SX+50 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+58 && xcoord < SX+60 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+48 && xcoord < SX+60 && ycoord >= SY+4 && ycoord < SY+6);

    // o (from "off")
    assign c5_o = (xcoord >= SX+80 && xcoord < SX+92 && ycoord >= SY+4 && ycoord < SY+6) ||
                  (xcoord >= SX+80 && xcoord < SX+92 && ycoord >= SY+14 && ycoord < SY+16) ||
                  (xcoord >= SX+80 && xcoord < SX+82 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+90 && xcoord < SX+92 && ycoord >= SY+4 && ycoord < SY+16);

    // SW0
    assign c9_S = (xcoord >= SX+144 && xcoord < SX+156 && ycoord >= SY && ycoord < SY+2) ||
                  (xcoord >= SX+144 && xcoord < SX+156 && ycoord >= SY+7 && ycoord < SY+9) ||
                  (xcoord >= SX+144 && xcoord < SX+156 && ycoord >= SY+14 && ycoord < SY+16) ||
                  (xcoord >= SX+144 && xcoord < SX+146 && ycoord >= SY && ycoord < SY+9) ||
                  (xcoord >= SX+154 && xcoord < SX+156 && ycoord >= SY+7 && ycoord < SY+16);
    assign c10_W= (xcoord >= SX+160 && xcoord < SX+162 && ycoord >= SY && ycoord < SY+16) ||
                  (xcoord >= SX+170 && xcoord < SX+172 && ycoord >= SY && ycoord < SY+16) ||
                  (xcoord >= SX+160 && xcoord < SX+172 && ycoord >= SY+14 && ycoord < SY+16) ||
                  (xcoord >= SX+165 && xcoord < SX+167 && ycoord >= SY+8 && ycoord < SY+16);
    assign c11_0= (xcoord >= SX+176 && xcoord < SX+188 && ycoord >= SY && ycoord < SY+2) ||
                  (xcoord >= SX+176 && xcoord < SX+188 && ycoord >= SY+14 && ycoord < SY+16) ||
                  (xcoord >= SX+176 && xcoord < SX+178 && ycoord >= SY && ycoord < SY+16) ||
                  (xcoord >= SX+186 && xcoord < SX+188 && ycoord >= SY && ycoord < SY+16);

    // to
    assign c13_t= (xcoord >= SX+208 && xcoord < SX+220 && ycoord >= SY+4 && ycoord < SY+6) ||
                  (xcoord >= SX+213 && xcoord < SX+215 && ycoord >= SY && ycoord < SY+16);
                  
    assign c14_o= (xcoord >= SX+224 && xcoord < SX+236 && ycoord >= SY+4 && ycoord < SY+6) ||
                  (xcoord >= SX+224 && xcoord < SX+236 && ycoord >= SY+14 && ycoord < SY+16) ||
                  (xcoord >= SX+224 && xcoord < SX+226 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+234 && xcoord < SX+236 && ycoord >= SY+4 && ycoord < SY+16);
                  

    // return
    assign c16_r= (xcoord >= SX+256 && xcoord < SX+258 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+256 && xcoord < SX+266 && ycoord >= SY+4 && ycoord < SY+6);
    assign c17_e= (xcoord >= SX+272 && xcoord < SX+284 && ycoord >= SY+4 && ycoord < SY+6) ||
                  (xcoord >= SX+272 && xcoord < SX+284 && ycoord >= SY+8 && ycoord < SY+10) ||
                  (xcoord >= SX+272 && xcoord < SX+284 && ycoord >= SY+14 && ycoord < SY+16) ||
                  (xcoord >= SX+272 && xcoord < SX+274 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+282 && xcoord < SX+284 && ycoord >= SY+4 && ycoord < SY+8);
    assign c18_t= (xcoord >= SX+288 && xcoord < SX+300 && ycoord >= SY+4 && ycoord < SY+6) ||
                  (xcoord >= SX+293 && xcoord < SX+295 && ycoord >= SY && ycoord < SY+16);
    assign c19_u= (xcoord >= SX+304 && xcoord < SX+306 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+314 && xcoord < SX+316 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+304 && xcoord < SX+316 && ycoord >= SY+14 && ycoord < SY+16);
    assign c20_r= (xcoord >= SX+320 && xcoord < SX+322 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+320 && xcoord < SX+330 && ycoord >= SY+4 && ycoord < SY+6);
    assign c21_n= (xcoord >= SX+336 && xcoord < SX+338 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+346 && xcoord < SX+348 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+336 && xcoord < SX+348 && ycoord >= SY+4 && ycoord < SY+6);

    // to
    assign c23_t= (xcoord >= SX+368 && xcoord < SX+380 && ycoord >= SY+4 && ycoord < SY+6) ||
                  (xcoord >= SX+373 && xcoord < SX+375 && ycoord >= SY && ycoord < SY+16);
    assign c24_o= (xcoord >= SX+384 && xcoord < SX+396 && ycoord >= SY+4 && ycoord < SY+6) || //EDITED
                  (xcoord >= SX+384 && xcoord < SX+396 && ycoord >= SY+14 && ycoord < SY+16) ||
                  (xcoord >= SX+384 && xcoord < SX+386 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+394 && xcoord < SX+396 && ycoord >= SY+4 && ycoord < SY+16);

    // start
    assign c26_s= (xcoord >= SX+416 && xcoord < SX+428 && ycoord >= SY+4 && ycoord < SY+6) ||
                  (xcoord >= SX+416 && xcoord < SX+428 && ycoord >= SY+9 && ycoord < SY+11) ||
                  (xcoord >= SX+416 && xcoord < SX+428 && ycoord >= SY+14 && ycoord < SY+16) ||
                  (xcoord >= SX+416 && xcoord < SX+418 && ycoord >= SY+4 && ycoord < SY+11) ||
                  (xcoord >= SX+426 && xcoord < SX+428 && ycoord >= SY+9 && ycoord < SY+16);
    assign c27_t= (xcoord >= SX+432 && xcoord < SX+444 && ycoord >= SY+4 && ycoord < SY+6) ||
                  (xcoord >= SX+437 && xcoord < SX+439 && ycoord >= SY && ycoord < SY+16);
    assign c28_a= (xcoord >= SX+448 && xcoord < SX+460 && ycoord >= SY+14 && ycoord < SY+16) ||
                  (xcoord >= SX+448 && xcoord < SX+460 && ycoord >= SY+4 && ycoord < SY+6) ||
                  (xcoord >= SX+448 && xcoord < SX+460 && ycoord >= SY+9 && ycoord < SY+11) ||
                  (xcoord >= SX+458 && xcoord < SX+460 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+448 && xcoord < SX+450 && ycoord >= SY+9 && ycoord < SY+16);
    assign c29_r= (xcoord >= SX+464 && xcoord < SX+466 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+464 && xcoord < SX+474 && ycoord >= SY+4 && ycoord < SY+6);
    assign c30_t= (xcoord >= SX+480 && xcoord < SX+492 && ycoord >= SY+4 && ycoord < SY+6) ||
                  (xcoord >= SX+485 && xcoord < SX+487 && ycoord >= SY && ycoord < SY+16);

    assign cond = c0_T | c1_u | c2_r | c3_n | c5_o | c6_f | c7_f |
                  c9_S | c10_W | c11_0 | c13_t | c14_o | 
                  c16_r | c17_e | c18_t | c19_u | c20_r | c21_n |
                  c23_t | c24_o | c26_s | c27_t | c28_a | c29_r | c30_t;

endmodule
module gameover_display(
    input [9:0] xcoord, 
    input [9:0] ycoord, 
    output cond
);
    // Centering "GAME OVER"
    // Bold stroke width: 4px
    localparam SX = 10'd212; 
    localparam SY = 10'd280; // Positioned ABOVE the return text
    
    wire c0_G, c1_A, c2_M, c3_E;
    wire c5_O, c6_V, c7_E, c8_R;

    // 0. G
    assign c0_G = (xcoord >= SX && xcoord < SX+16 && ycoord >= SY && ycoord < SY+4) ||       // Top
                  (xcoord >= SX && xcoord < SX+16 && ycoord >= SY+12 && ycoord < SY+16) ||    // Bottom
                  (xcoord >= SX && xcoord < SX+4 && ycoord >= SY && ycoord < SY+16) ||       // Left
                  (xcoord >= SX+12 && xcoord < SX+16 && ycoord >= SY+8 && ycoord < SY+16) ||  // Right half-stem
                  (xcoord >= SX+8 && xcoord < SX+16 && ycoord >= SY+8 && ycoord < SY+12);    // Mid bar

    // 1. A
    assign c1_A = (xcoord >= SX+24 && xcoord < SX+40 && ycoord >= SY && ycoord < SY+4) ||     // Top
                  (xcoord >= SX+24 && xcoord < SX+40 && ycoord >= SY+8 && ycoord < SY+12) ||    // Mid
                  (xcoord >= SX+24 && xcoord < SX+28 && ycoord >= SY && ycoord < SY+16) ||     // Left
                  (xcoord >= SX+36 && xcoord < SX+40 && ycoord >= SY && ycoord < SY+16);     // Right

    // 2. M
    assign c2_M = (xcoord >= SX+48 && xcoord < SX+52 && ycoord >= SY && ycoord < SY+16) ||     // Left
                  (xcoord >= SX+60 && xcoord < SX+64 && ycoord >= SY && ycoord < SY+16) ||     // Right
                  (xcoord >= SX+48 && xcoord < SX+64 && ycoord >= SY && ycoord < SY+4) ||      // Top
                  (xcoord >= SX+54 && xcoord < SX+58 && ycoord >= SY && ycoord < SY+12);     // Middle leg

    // 3. E
    assign c3_E = (xcoord >= SX+72 && xcoord < SX+88 && ycoord >= SY && ycoord < SY+4) ||      // Top
                  (xcoord >= SX+72 && xcoord < SX+88 && ycoord >= SY+6 && ycoord < SY+10) ||    // Mid
                  (xcoord >= SX+72 && xcoord < SX+88 && ycoord >= SY+12 && ycoord < SY+16) ||   // Bot
                  (xcoord >= SX+72 && xcoord < SX+76 && ycoord >= SY && ycoord < SY+16);      // Left

    // [Space at index 4]

    // 5. O
    assign c5_O = (xcoord >= SX+120 && xcoord < SX+136 && ycoord >= SY && ycoord < SY+4) ||    // Top
                  (xcoord >= SX+120 && xcoord < SX+136 && ycoord >= SY+12 && ycoord < SY+16) || // Bot
                  (xcoord >= SX+120 && xcoord < SX+124 && ycoord >= SY && ycoord < SY+16) ||    // Left
                  (xcoord >= SX+132 && xcoord < SX+136 && ycoord >= SY && ycoord < SY+16);    // Right

    // 6. V
    assign c6_V = (xcoord >= SX+144 && xcoord < SX+148 && ycoord >= SY && ycoord < SY+12) ||    // Left
                  (xcoord >= SX+156 && xcoord < SX+160 && ycoord >= SY && ycoord < SY+12) ||    // Right
                  (xcoord >= SX+148 && xcoord < SX+156 && ycoord >= SY+12 && ycoord < SY+16);   // Bottom connector

    // 7. E
    assign c7_E = (xcoord >= SX+168 && xcoord < SX+184 && ycoord >= SY && ycoord < SY+4) ||
                  (xcoord >= SX+168 && xcoord < SX+184 && ycoord >= SY+6 && ycoord < SY+10) ||
                  (xcoord >= SX+168 && xcoord < SX+184 && ycoord >= SY+12 && ycoord < SY+16) ||
                  (xcoord >= SX+168 && xcoord < SX+172 && ycoord >= SY && ycoord < SY+16);

    // 8. R
    assign c8_R = (xcoord >= SX+192 && xcoord < SX+196 && ycoord >= SY && ycoord < SY+16) ||    // Left Stem
                  (xcoord >= SX+192 && xcoord < SX+208 && ycoord >= SY && ycoord < SY+4) ||     // Top
                  (xcoord >= SX+192 && xcoord < SX+208 && ycoord >= SY+7 && ycoord < SY+11) ||   // Mid
                  (xcoord >= SX+204 && xcoord < SX+208 && ycoord >= SY && ycoord < SY+11) ||    // Right loop
                  (xcoord >= SX+202 && xcoord < SX+208 && ycoord >= SY+10 && ycoord < SY+16);   // Leg

    assign cond = c0_G | c1_A | c2_M | c3_E | c5_O | c6_V | c7_E | c8_R;

endmodule
