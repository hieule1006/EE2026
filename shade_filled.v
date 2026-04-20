`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2026 23:18:04
// Design Name: 
// Module Name: shade_filled
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


module shade_filled(input [9:0] x_pixel, [8:0] y_pixel,[199:0] memory_array,output cond);
//wanted to use wor but vivaldo doesnt support??

    wire [199:0] temp; //stores array of conditions before reducing
    genvar i, j; //the source has integer but the error msg says genvar so ig we're using genvar
    generate
        for (i = 0; i < 20; i = i + 1) begin : row_loop
            for (j = 0; j < 10; j = j + 1) begin : col_loop
                
                wire filled; 
                wire [8:0] chunk; //fill i and j into a wire so that they can be put into the mod
                assign chunk[8:5] = j;
                assign chunk[4:0] = i;
                translation_mod_prot dut (x_pixel,y_pixel,chunk,filled);
                
                assign temp[i*10 + j] = memory_array[i*10 + j] && filled;

            end
        end
    endgenerate

    assign cond = |temp; //reduce all conditions in temp by ORing them together
endmodule
