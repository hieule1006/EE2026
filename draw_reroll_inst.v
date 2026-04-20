`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2026 21:17:05
// Design Name: 
// Module Name: draw_reroll_inst
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


module draw_reroll_inst(
input wire [9:0] xcoord, 
    input wire [8:0] ycoord, 
    output wire cond
);
    // Centering "Select rerolls on SW1 to 15"
    // String length: 27 chars * 16px = 432px wide. 
    // Screen center 320 -> (640-432)/2 = 104.
    // Placed slightly below the previous Y=320 text.
    
    localparam SX = 10'd104;
    localparam SY = 10'd320;
    
    wire c0_S, c1_e, c2_l, c3_e, c4_c, c5_t;
    wire c7_r, c8_e, c9_r, c10_o, c11_l, c12_l, c13_s;
    wire c15_o, c16_n;
    wire c18_S, c19_W, c20_1;
    wire c22_t, c23_o;
    wire c25_1, c26_5;

    // --- Helper Logic for Stroke Segments ---
    // Characters follow the 12px width bounds inside a 16px block step.
    // Uppercase/Ascenders span SY to SY+16. Lowercase spans SY+4 to SY+16.

    // 0. S (Capital)
    assign c0_S = (xcoord >= SX && xcoord < SX+12 && ycoord >= SY && ycoord < SY+2) ||      // Top
                  (xcoord >= SX && xcoord < SX+12 && ycoord >= SY+7 && ycoord < SY+9) ||    // Mid
                  (xcoord >= SX && xcoord < SX+12 && ycoord >= SY+14 && ycoord < SY+16) ||  // Bot
                  (xcoord >= SX && xcoord < SX+2 && ycoord >= SY && ycoord < SY+9) ||       // Left Up
                  (xcoord >= SX+10 && xcoord < SX+12 && ycoord >= SY+7 && ycoord < SY+16);  // Right Down

    // 1. e
    assign c1_e = (xcoord >= SX+16 && xcoord < SX+28 && ycoord >= SY+4 && ycoord < SY+6) ||     // Top
                  (xcoord >= SX+16 && xcoord < SX+28 && ycoord >= SY+8 && ycoord < SY+10) ||    // Mid
                  (xcoord >= SX+16 && xcoord < SX+28 && ycoord >= SY+14 && ycoord < SY+16) ||   // Bot
                  (xcoord >= SX+16 && xcoord < SX+18 && ycoord >= SY+4 && ycoord < SY+16) ||    // Left
                  (xcoord >= SX+26 && xcoord < SX+28 && ycoord >= SY+4 && ycoord < SY+8);       // Right Upper

    // 2. l (Ascender)
    assign c2_l = (xcoord >= SX+37 && xcoord < SX+39 && ycoord >= SY && ycoord < SY+16);        // Stem

    // 3. e
    assign c3_e = (xcoord >= SX+48 && xcoord < SX+60 && ycoord >= SY+4 && ycoord < SY+6) ||
                  (xcoord >= SX+48 && xcoord < SX+60 && ycoord >= SY+8 && ycoord < SY+10) ||
                  (xcoord >= SX+48 && xcoord < SX+60 && ycoord >= SY+14 && ycoord < SY+16) ||
                  (xcoord >= SX+48 && xcoord < SX+50 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+58 && xcoord < SX+60 && ycoord >= SY+4 && ycoord < SY+8);

    // 4. c
    assign c4_c = (xcoord >= SX+64 && xcoord < SX+76 && ycoord >= SY+4 && ycoord < SY+6) ||     // Top
                  (xcoord >= SX+64 && xcoord < SX+76 && ycoord >= SY+14 && ycoord < SY+16) ||   // Bot
                  (xcoord >= SX+64 && xcoord < SX+66 && ycoord >= SY+4 && ycoord < SY+16);      // Left

    // 5. t
    assign c5_t = (xcoord >= SX+80 && xcoord < SX+92 && ycoord >= SY+4 && ycoord < SY+6) ||     // Cross
                  (xcoord >= SX+85 && xcoord < SX+87 && ycoord >= SY && ycoord < SY+16);        // Stem

    // [Space at 6: SX+96]

    // 7. r
    assign c7_r = (xcoord >= SX+112 && xcoord < SX+114 && ycoord >= SY+4 && ycoord < SY+16) ||  // Stem
                  (xcoord >= SX+112 && xcoord < SX+122 && ycoord >= SY+4 && ycoord < SY+6);     // Top curve

    // 8. e
    assign c8_e = (xcoord >= SX+128 && xcoord < SX+140 && ycoord >= SY+4 && ycoord < SY+6) ||
                  (xcoord >= SX+128 && xcoord < SX+140 && ycoord >= SY+8 && ycoord < SY+10) ||
                  (xcoord >= SX+128 && xcoord < SX+140 && ycoord >= SY+14 && ycoord < SY+16) ||
                  (xcoord >= SX+128 && xcoord < SX+130 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+138 && xcoord < SX+140 && ycoord >= SY+4 && ycoord < SY+8);

    // 9. r
    assign c9_r = (xcoord >= SX+144 && xcoord < SX+146 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+144 && xcoord < SX+154 && ycoord >= SY+4 && ycoord < SY+6);

    // 10. o
    assign c10_o= (xcoord >= SX+160 && xcoord < SX+172 && ycoord >= SY+4 && ycoord < SY+6) ||   // Top
                  (xcoord >= SX+160 && xcoord < SX+172 && ycoord >= SY+14 && ycoord < SY+16) || // Bot
                  (xcoord >= SX+160 && xcoord < SX+162 && ycoord >= SY+4 && ycoord < SY+16) ||  // Left
                  (xcoord >= SX+170 && xcoord < SX+172 && ycoord >= SY+4 && ycoord < SY+16);    // Right

    // 11. l
    assign c11_l= (xcoord >= SX+181 && xcoord < SX+183 && ycoord >= SY && ycoord < SY+16);

    // 12. l
    assign c12_l= (xcoord >= SX+197 && xcoord < SX+199 && ycoord >= SY && ycoord < SY+16);

    // 13. s (Lowercase S scaled to ycoord constraints)
    assign c13_s= (xcoord >= SX+208 && xcoord < SX+220 && ycoord >= SY+4 && ycoord < SY+6) ||   // Top
                  (xcoord >= SX+208 && xcoord < SX+220 && ycoord >= SY+9 && ycoord < SY+11) ||  // Mid
                  (xcoord >= SX+208 && xcoord < SX+220 && ycoord >= SY+14 && ycoord < SY+16) || // Bot
                  (xcoord >= SX+208 && xcoord < SX+210 && ycoord >= SY+4 && ycoord < SY+11) ||  // Left Up
                  (xcoord >= SX+218 && xcoord < SX+220 && ycoord >= SY+9 && ycoord < SY+16);    // Right Down

    // [Space at 14: SX+224]

    // 15. o
    assign c15_o= (xcoord >= SX+240 && xcoord < SX+252 && ycoord >= SY+4 && ycoord < SY+6) ||
                  (xcoord >= SX+240 && xcoord < SX+252 && ycoord >= SY+14 && ycoord < SY+16) ||
                  (xcoord >= SX+240 && xcoord < SX+242 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+250 && xcoord < SX+252 && ycoord >= SY+4 && ycoord < SY+16);

    // 16. n
    assign c16_n= (xcoord >= SX+256 && xcoord < SX+258 && ycoord >= SY+4 && ycoord < SY+16) ||  // Left
                  (xcoord >= SX+266 && xcoord < SX+268 && ycoord >= SY+4 && ycoord < SY+16) ||  // Right
                  (xcoord >= SX+256 && xcoord < SX+268 && ycoord >= SY+4 && ycoord < SY+6);     // Top

    // [Space at 17: SX+272]

    // 18. S (Capital)
    assign c18_S= (xcoord >= SX+288 && xcoord < SX+300 && ycoord >= SY && ycoord < SY+2) ||
                  (xcoord >= SX+288 && xcoord < SX+300 && ycoord >= SY+7 && ycoord < SY+9) ||
                  (xcoord >= SX+288 && xcoord < SX+300 && ycoord >= SY+14 && ycoord < SY+16) ||
                  (xcoord >= SX+288 && xcoord < SX+290 && ycoord >= SY && ycoord < SY+9) ||
                  (xcoord >= SX+298 && xcoord < SX+300 && ycoord >= SY+7 && ycoord < SY+16);

    // 19. W
    assign c19_W= (xcoord >= SX+304 && xcoord < SX+306 && ycoord >= SY && ycoord < SY+16) ||    // Left
                  (xcoord >= SX+314 && xcoord < SX+316 && ycoord >= SY && ycoord < SY+16) ||    // Right
                  (xcoord >= SX+309 && xcoord < SX+311 && ycoord >= SY+8 && ycoord < SY+16) ||  // Mid Stem
                  (xcoord >= SX+304 && xcoord < SX+316 && ycoord >= SY+14 && ycoord < SY+16);   // Bottom

    // 20. 1 (Number)
    assign c20_1= (xcoord >= SX+326 && xcoord < SX+328 && ycoord >= SY && ycoord < SY+16) ||    // Stem
                  (xcoord >= SX+322 && xcoord < SX+332 && ycoord >= SY+14 && ycoord < SY+16) || // Base
                  (xcoord >= SX+322 && xcoord < SX+326 && ycoord >= SY && ycoord < SY+2);       // Serif

    // [Space at 21: SX+336]

    // 22. t
    assign c22_t= (xcoord >= SX+352 && xcoord < SX+364 && ycoord >= SY+4 && ycoord < SY+6) ||   
                  (xcoord >= SX+357 && xcoord < SX+359 && ycoord >= SY && ycoord < SY+16);      

    // 23. o
    assign c23_o= (xcoord >= SX+368 && xcoord < SX+380 && ycoord >= SY+4 && ycoord < SY+6) ||
                  (xcoord >= SX+368 && xcoord < SX+380 && ycoord >= SY+14 && ycoord < SY+16) ||
                  (xcoord >= SX+368 && xcoord < SX+370 && ycoord >= SY+4 && ycoord < SY+16) ||
                  (xcoord >= SX+378 && xcoord < SX+380 && ycoord >= SY+4 && ycoord < SY+16);

    // [Space at 24: SX+384]

    // 25. 1 (Number)
    assign c25_1= (xcoord >= SX+406 && xcoord < SX+408 && ycoord >= SY && ycoord < SY+16) ||    
                  (xcoord >= SX+402 && xcoord < SX+412 && ycoord >= SY+14 && ycoord < SY+16) || 
                  (xcoord >= SX+402 && xcoord < SX+406 && ycoord >= SY && ycoord < SY+2);       

    // 26. 5 (Number)
    assign c26_5= (xcoord >= SX+416 && xcoord < SX+428 && ycoord >= SY && ycoord < SY+2) ||     // Top
                  (xcoord >= SX+416 && xcoord < SX+428 && ycoord >= SY+7 && ycoord < SY+9) ||   // Mid
                  (xcoord >= SX+416 && xcoord < SX+428 && ycoord >= SY+14 && ycoord < SY+16) || // Bot
                  (xcoord >= SX+416 && xcoord < SX+418 && ycoord >= SY && ycoord < SY+9) ||     // Left Up
                  (xcoord >= SX+426 && xcoord < SX+428 && ycoord >= SY+7 && ycoord < SY+16);    // Right Down


    // Final Output: OR all characters together
    assign cond = c0_S | c1_e | c2_l | c3_e | c4_c | c5_t | 
                  c7_r | c8_e | c9_r | c10_o| c11_l| c12_l| c13_s | 
                  c15_o| c16_n| 
                  c18_S| c19_W| c20_1 | 
                  c22_t| c23_o| 
                  c25_1| c26_5;

endmodule