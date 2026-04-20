`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2026 15:38:19
// Design Name: 
// Module Name: shade_pixel
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

module blkchunk2blkpix(input [9:0] x_pixel, [8:0] y_pixel, [35:0] block_chunks, output cond);
    wire cond1, cond2, cond3, cond4;
    translation_mod_prot c1(x_pixel,y_pixel,block_chunks[35:27],cond1);
    translation_mod_prot c2(x_pixel,y_pixel,block_chunks[26:18],cond2);
    translation_mod_prot c3(x_pixel,y_pixel,block_chunks[17:9],cond3);
    translation_mod_prot c4(x_pixel,y_pixel,block_chunks[8:0],cond4);
    
    assign cond = cond1 || cond2 || cond3 || cond4;
    
endmodule


module translation_mod_prot(input [9:0] x_pixel, [8:0] y_pixel,[8:0] chunks, output cond);

    assign cond = (x_pixel >= (chunks[8:5]*20 + 20*11) && x_pixel <=(chunks[8:5]*20+20*11 +20)) &&
                  (y_pixel >= chunks[4:0]*20 + 20*2 && y_pixel <=(chunks[4:0]*20+20*2+20));
 
   
endmodule
