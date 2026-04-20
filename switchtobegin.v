`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2026 15:35:04
// Design Name: 
// Module Name: switchtobegin
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


module switchtobegin(
 input [9:0] xcoord, 
   input [9:0] ycoord, 
   output cond
);
   // Centering "Turn on SW0 to begin"
   // Start X: ~160, Start Y: 320
   // Spacing: 16px per char
   
   localparam SX = 10'd160;
   localparam SY = 10'd350;
   
   wire c0_T, c1_u, c2_r, c3_n, c5_o, c6_n;
   wire c8_S, c9_W, c10_0;
   wire c12_t, c13_o, c15_b, c16_e, c17_g, c18_i, c19_n;

   // --- Helper Logic for Stroke Segments ---
   // We define macros or simple logic for each letter to keep it clean.
   // Common 1-pixel line logic:
   
   // 0. T
   assign c0_T = (xcoord >= SX && xcoord < SX+12 && ycoord >= SY && ycoord < SY+2) ||           // Top Bar
                 (xcoord >= SX+5 && xcoord < SX+7 && ycoord >= SY && ycoord < SY+16);           // Stem

   // 1. u (Bottom heavy)
   assign c1_u = (xcoord >= SX+16 && xcoord < SX+18 && ycoord >= SY+4 && ycoord < SY+16) ||       // Left
                 (xcoord >= SX+26 && xcoord < SX+28 && ycoord >= SY+4 && ycoord < SY+16) ||       // Right
                 (xcoord >= SX+16 && xcoord < SX+28 && ycoord >= SY+14 && ycoord < SY+16);      // Bottom

   // 2. r
   assign c2_r = (xcoord >= SX+32 && xcoord < SX+34 && ycoord >= SY+4 && ycoord < SY+16) ||     // Stem
                 (xcoord >= SX+32 && xcoord < SX+42 && ycoord >= SY+4 && ycoord < SY+6);        // Top curve

   // 3. n
   assign c3_n = (xcoord >= SX+48 && xcoord < SX+50 && ycoord >= SY+4 && ycoord < SY+16) ||     // Left
                 (xcoord >= SX+58 && xcoord < SX+60 && ycoord >= SY+4 && ycoord < SY+16) ||     // Right
                 (xcoord >= SX+48 && xcoord < SX+60 && ycoord >= SY+4 && ycoord < SY+6);        // Top

   // 5. o
   assign c5_o = (xcoord >= SX+80 && xcoord < SX+92 && ycoord >= SY+4 && ycoord < SY+6) ||      // Top
                 (xcoord >= SX+80 && xcoord < SX+92 && ycoord >= SY+14 && ycoord < SY+16) ||    // Bot
                 (xcoord >= SX+80 && xcoord < SX+82 && ycoord >= SY+4 && ycoord < SY+16) ||     // Left
                 (xcoord >= SX+90 && xcoord < SX+92 && ycoord >= SY+4 && ycoord < SY+16);       // Right

   // 6. n (same as c3 but shifted)
   assign c6_n = (xcoord >= SX+96 && xcoord < SX+98 && ycoord >= SY+4 && ycoord < SY+16) || 
                 (xcoord >= SX+106 && xcoord < SX+108 && ycoord >= SY+4 && ycoord < SY+16) || 
                 (xcoord >= SX+96 && xcoord < SX+108 && ycoord >= SY+4 && ycoord < SY+6);

   // 8. S
   assign c8_S = (xcoord >= SX+128 && xcoord < SX+140 && ycoord >= SY && ycoord < SY+2) ||      // Top
                 (xcoord >= SX+128 && xcoord < SX+140 && ycoord >= SY+7 && ycoord < SY+9) ||    // Mid
                 (xcoord >= SX+128 && xcoord < SX+140 && ycoord >= SY+14 && ycoord < SY+16) ||  // Bot
                 (xcoord >= SX+128 && xcoord < SX+130 && ycoord >= SY && ycoord < SY+9) ||      // Left Up
                 (xcoord >= SX+138 && xcoord < SX+140 && ycoord >= SY+7 && ycoord < SY+16);     // Right Down

   // 9. W (Simplified)
   assign c9_W = (xcoord >= SX+144 && xcoord < SX+146 && ycoord >= SY && ycoord < SY+16) ||     // Left
                 (xcoord >= SX+154 && xcoord < SX+156 && ycoord >= SY && ycoord < SY+16) ||     // Right
                 (xcoord >= SX+149 && xcoord < SX+151 && ycoord >= SY+8 && ycoord < SY+16) ||   // Mid Stem
                 (xcoord >= SX+144 && xcoord < SX+156 && ycoord >= SY+14 && ycoord < SY+16);    // Bottom

   // 10. 0 (Zero with slash or simple box) - Let's do simple box
   assign c10_0 =(xcoord >= SX+160 && xcoord < SX+172 && ycoord >= SY && ycoord < SY+2) || 
                 (xcoord >= SX+160 && xcoord < SX+172 && ycoord >= SY+14 && ycoord < SY+16) || 
                 (xcoord >= SX+160 && xcoord < SX+162 && ycoord >= SY && ycoord < SY+16) || 
                 (xcoord >= SX+170 && xcoord < SX+172 && ycoord >= SY && ycoord < SY+16);

   // 12. t
   assign c12_t =(xcoord >= SX+192 && xcoord < SX+204 && ycoord >= SY+4 && ycoord < SY+6) ||    // Cross
                 (xcoord >= SX+197 && xcoord < SX+199 && ycoord >= SY && ycoord < SY+16);       // Stem

   // 13. o
   assign c13_o =(xcoord >= SX+208 && xcoord < SX+220 && ycoord >= SY+4 && ycoord < SY+6) ||    
                 (xcoord >= SX+208 && xcoord < SX+220 && ycoord >= SY+14 && ycoord < SY+16) ||    
                 (xcoord >= SX+208 && xcoord < SX+210 && ycoord >= SY+4 && ycoord < SY+16) ||     
                 (xcoord >= SX+218 && xcoord < SX+220 && ycoord >= SY+4 && ycoord < SY+16);

   // 15. b
   assign c15_b =(xcoord >= SX+240 && xcoord < SX+242 && ycoord >= SY && ycoord < SY+16) ||     // Stem
                 (xcoord >= SX+240 && xcoord < SX+252 && ycoord >= SY+14 && ycoord < SY+16) ||  // Bot
                 (xcoord >= SX+240 && xcoord < SX+252 && ycoord >= SY+8 && ycoord < SY+10) ||   // Mid
                 (xcoord >= SX+250 && xcoord < SX+252 && ycoord >= SY+8 && ycoord < SY+16);     // Right Loop

   // 16. e
   assign c16_e =(xcoord >= SX+256 && xcoord < SX+268 && ycoord >= SY+4 && ycoord < SY+6) ||    // Top
                 (xcoord >= SX+256 && xcoord < SX+268 && ycoord >= SY+8 && ycoord < SY+10) ||   // Mid
                 (xcoord >= SX+256 && xcoord < SX+268 && ycoord >= SY+14 && ycoord < SY+16) ||  // Bot
                 (xcoord >= SX+256 && xcoord < SX+258 && ycoord >= SY+4 && ycoord < SY+16) ||   // Left
                 (xcoord >= SX+266 && xcoord < SX+268 && ycoord >= SY+4 && ycoord < SY+8);      // Right Upper

   // 17. g
   assign c17_g =(xcoord >= SX+272 && xcoord < SX+284 && ycoord >= SY+4 && ycoord < SY+6) ||    // Top
                 (xcoord >= SX+272 && xcoord < SX+284 && ycoord >= SY+14 && ycoord < SY+16) ||  // Bot Loop Top
                 (xcoord >= SX+272 && xcoord < SX+284 && ycoord >= SY+18 && ycoord < SY+20) ||  // True Bottom
                 (xcoord >= SX+272 && xcoord < SX+274 && ycoord >= SY+4 && ycoord < SY+14) ||   // Left
                 (xcoord >= SX+282 && xcoord < SX+284 && ycoord >= SY+4 && ycoord < SY+20);     // Right Stem

   // 18. i
   assign c18_i =(xcoord >= SX+288 && xcoord < SX+300 && ycoord >= SY+14 && ycoord < SY+16) ||  // Base
                 (xcoord >= SX+293 && xcoord < SX+295 && ycoord >= SY+4 && ycoord < SY+14) ||   // Stem
                 (xcoord >= SX+293 && xcoord < SX+295 && ycoord >= SY && ycoord < SY+2);        // Dot

   // 19. n
   assign c19_n =(xcoord >= SX+304 && xcoord < SX+306 && ycoord >= SY+4 && ycoord < SY+16) || 
                 (xcoord >= SX+314 && xcoord < SX+316 && ycoord >= SY+4 && ycoord < SY+16) || 
                 (xcoord >= SX+304 && xcoord < SX+316 && ycoord >= SY+4 && ycoord < SY+6);

   // Final Output: OR all characters together
   assign cond = c0_T | c1_u | c2_r | c3_n | c5_o | c6_n | 
                 c8_S | c9_W | c10_0 | c12_t | c13_o | 
                 c15_b | c16_e | c17_g | c18_i | c19_n;

endmodule
