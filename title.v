`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2026 14:45:00
// Design Name: 
// Module Name: title
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


module title(input [9:0] xcoord, [8:0] ycoord, output T1, E, T2, R, I, S, boxoutline, shading); 
//was gonna combine but this lets us do the multi colour


    assign T1 = ( (xcoord >= 10'd185 && xcoord <= 10'd225) && (ycoord >= 9'd210 && ycoord <= 9'd225) ) || 
                ( (xcoord >= 10'd197 && xcoord <= 10'd212) && (ycoord >= 9'd210 && ycoord <= 9'd270) );    

    assign E =  ( (xcoord >= 10'd235 && xcoord <= 10'd250) && (ycoord >= 9'd210 && ycoord <= 9'd270) ) || 
                ( (xcoord >= 10'd235 && xcoord <= 10'd275) && (ycoord >= 9'd210 && ycoord <= 9'd225) ) || 
                ( (xcoord >= 10'd235 && xcoord <= 10'd275) && (ycoord >= 9'd232 && ycoord <= 9'd247) ) || 
                ( (xcoord >= 10'd235 && xcoord <= 10'd275) && (ycoord >= 9'd255 && ycoord <= 9'd270) );  

    assign T2 = ( (xcoord >= 10'd285 && xcoord <= 10'd325) && (ycoord >= 9'd210 && ycoord <= 9'd225) ) || 
                ( (xcoord >= 10'd297 && xcoord <= 10'd312) && (ycoord >= 9'd210 && ycoord <= 9'd270) );  

    assign R =  ( (xcoord >= 10'd335 && xcoord <= 10'd350) && (ycoord >= 9'd210 && ycoord <= 9'd270) ) || 
                ( (xcoord >= 10'd335 && xcoord <= 10'd375) && (ycoord >= 9'd210 && ycoord <= 9'd225) ) || 
                ( (xcoord >= 10'd335 && xcoord <= 10'd375) && (ycoord >= 9'd232 && ycoord <= 9'd247) ) || 
                ( (xcoord >= 10'd360 && xcoord <= 10'd375) && (ycoord >= 9'd210 && ycoord <= 9'd247) ) || 
                ( (xcoord >= 10'd360 && xcoord <= 10'd375) && (ycoord >= 9'd247 && ycoord <= 9'd270) );  

    assign I =  ( (xcoord >= 10'd385 && xcoord <= 10'd405) && (ycoord >= 9'd210 && ycoord <= 9'd270) );

    assign S =  ( (xcoord >= 10'd415 && xcoord <= 10'd455) && (ycoord >= 9'd210 && ycoord <= 9'd225) ) || 
                ( (xcoord >= 10'd415 && xcoord <= 10'd455) && (ycoord >= 9'd232 && ycoord <= 9'd247) ) || 
                ( (xcoord >= 10'd415 && xcoord <= 10'd455) && (ycoord >= 9'd255 && ycoord <= 9'd270) ) || 
                ( (xcoord >= 10'd415 && xcoord <= 10'd430) && (ycoord >= 9'd210 && ycoord <= 9'd247) ) || 
                ( (xcoord >= 10'd440 && xcoord <= 10'd455) && (ycoord >= 9'd232 && ycoord <= 9'd270) );    
                

    assign boxoutline = (xcoord >= 10'd175 && xcoord <= 10'd465) && (ycoord >= 9'd200 && ycoord <= 9'd280);

    assign shading = boxoutline && ((xcoord < 10'd175 + 10'd4) || (xcoord > 10'd465 - 10'd4) ||
                            (ycoord < 9'd200 + 9'd4) || (ycoord > 9'd280 - 9'd4));

endmodule
