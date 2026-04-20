`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2026 16:03:14
// Design Name: 
// Module Name: draw_name
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



module draw_name(input [9:0] xcoord, [8:0] ycoord, [9:0] xcorner, [8:0] ycorner , output cond);
wire cond1,cond2,cond3,cond4,cond5,cond6,cond7,cond8,cond9,cond10,cond11,cond12,cond13,cond14,cond15,cond16;
assign cond = cond1||cond2||cond3||cond4||cond5||cond6||cond7||cond8||cond9||cond10||cond11||cond12||cond13||cond14||cond15||cond16;

draw_Tupright t1(xcoord, ycoord, xcorner + 10'd0,   ycorner + 9'd8,   cond1);   
draw_Tupright t2(xcoord, ycoord, xcorner + 10'd72,  ycorner + 9'd8,   cond2); 
draw_Tupright t3(xcoord, ycoord, xcorner + 10'd136, ycorner + 9'd8,   cond3); 

draw_Tupdown ut1(xcoord, ycoord, xcorner + 10'd136, ycorner + 9'd56,  cond4);
draw_Tupdown ut2(xcoord, ycoord, xcorner + 10'd168, ycorner + 9'd32,  cond5);

draw4x1upr   f1u(xcoord, ycoord, xcorner + 10'd8,   ycorner + 9'd24,  cond6);
draw4x1upr   f2u(xcoord, ycoord, xcorner + 10'd80,  ycorner + 9'd24,  cond7);
draw4x1upr   f3u(xcoord, ycoord, xcorner + 10'd144, ycorner + 9'd24,  cond8);
draw4x1upr   f4u(xcoord, ycoord, xcorner + 10'd104, ycorner + 9'd16,  cond9);

draw4x1side  f1s(xcoord, ycoord, xcorner + 10'd32,  ycorner + 9'd8,  cond10);

drawlongL   LL1(xcoord, ycoord, xcorner + 10'd40,  ycorner + 9'd16,  cond11);
drawlongL   LL2(xcoord, ycoord, xcorner + 10'd40,  ycorner + 9'd32,  cond12);

drawlongLf LLf1(xcoord, ycoord, xcorner + 10'd168, ycorner + 9'd24,  cond13);
drawlongLf LLf2(xcoord, ycoord, xcorner + 10'd104, ycorner + 9'd8,  cond14);

drawsideL   sL1(xcoord, ycoord, xcorner + 10'd168, ycorner + 9'd8,  cond15);

drawsideS   sS1(xcoord, ycoord, xcorner + 10'd112, ycorner + 9'd24,  cond16);
endmodule

module draw_Tupright(input [9:0] xcoord, [8:0] ycoord, [9:0] xcorner, [8:0] ycorner , output cond);
    assign cond = (( xcoord >= xcorner && xcoord <= (xcorner + 10'd24) ) && ycoord == ycorner ) ||
                  (( ycoord >= ycorner && ycoord <= ycorner + 9'd8) && ( xcoord == xcorner || xcoord == xcorner + 10'd24) ) ||
                  
                  (( (xcoord >= xcorner && xcoord <= (xcorner + 10'd8)) || (xcoord >= (xcorner + 10'd16) && xcoord <= (xcorner + 10'd24)) ) && ycoord == ycorner + 9'd8 ) ||
                  
                  (( (xcoord == (xcorner + 10'd8)) || (xcoord == xcorner + 10'd16) ) && (ycoord <= (ycorner + 9'd16) && ycoord >= ycorner + 9'd8) ) ||
                  
                  ( (xcoord >= xcorner + 10'd8) && (xcoord <= xcorner + 10'd16) && (ycoord == ycorner + 9'd16));
endmodule

module draw_Tupdown(input [9:0] xcoord, [8:0] ycoord, [9:0] xcorner, [8:0] ycorner , output cond);
    assign cond = (( xcoord >= xcorner + 10'd8 && xcoord <= (xcorner + 10'd16) ) && ycoord == ycorner ) ||
                  (( ycoord >= ycorner && ycoord <= ycorner + 9'd8) && ( xcoord == xcorner+10'd8 || xcoord == xcorner + 10'd16) ) ||
                  
                  (( (xcoord >= xcorner && xcoord <= (xcorner + 10'd8)) || (xcoord >= (xcorner + 10'd16) && xcoord <= (xcorner + 10'd24)) ) && ycoord == ycorner + 9'd8 ) ||
                  
                  (( (xcoord == (xcorner)) || (xcoord == xcorner + 10'd24) ) && (ycoord <= (ycorner + 9'd16) && ycoord >= ycorner + 9'd8) ) ||
                  
                  ( (xcoord >= xcorner) && (xcoord <= xcorner + 10'd24) && (ycoord == ycorner + 9'd16));
endmodule

module draw4x1upr(input [9:0] xcoord, [8:0] ycoord, [9:0] xcorner, [8:0] ycorner , output cond);
    assign cond = (xcoord >= xcorner && xcoord <=xcorner+10'd8 && ycoord == ycorner) ||
                  ((xcoord == xcorner || xcoord == xcorner+10'd8) && (ycoord >= ycorner && ycoord<= ycorner +9'd32)) ||
                  (xcoord >= xcorner && xcoord <=xcorner+10'd8 && ycoord == ycorner+9'd32);
endmodule

module draw4x1side(input [9:0] xcoord, [8:0] ycoord, [9:0] xcorner, [8:0] ycorner , output cond);
    assign cond = (xcoord == xcorner && ycoord>=ycorner && ycoord<=ycorner+9'd8) ||
                  (xcoord >= xcorner && xcoord <=xcorner+10'd32 &&(ycoord==ycorner || ycoord==ycorner+9'd8)) ||
                  (xcoord == xcorner+10'd32 && ycoord>=ycorner && ycoord<=ycorner+9'd8);
endmodule

module drawlongL(input [9:0] xcoord, [8:0] ycoord, [9:0] xcorner, [8:0] ycorner , output cond);
    assign cond = (xcoord == xcorner && ycoord>=ycorner && ycoord<=ycorner+9'd16) ||
                  (xcoord >= xcorner && xcoord <=xcorner+10'd24 && ycoord==ycorner+9'd16) ||
                  (xcoord >= xcorner+10'd8 && xcoord <=xcorner+10'd24 && ycoord==ycorner+9'd8)||
                  (xcoord >= xcorner && xcoord <=xcorner+10'd8 && ycoord==ycorner) ||
                  (xcoord == xcorner+10'd8 && ycoord>=ycorner && ycoord<=ycorner+9'd8) ||
                  (xcoord == xcorner+10'd24 && ycoord>=ycorner+9'd8 && ycoord<=ycorner+9'd16);
endmodule

module drawlongLf(input [9:0] xcoord, [8:0] ycoord, [9:0] xcorner, [8:0] ycorner , output cond);
    assign cond = (xcoord == xcorner && ycoord>=ycorner && ycoord<=ycorner+9'd8) ||
                  (xcoord >= xcorner && xcoord <=xcorner+10'd24 &&ycoord==ycorner) ||
                  (xcoord == xcorner+10'd24 && ycoord>=ycorner && ycoord<=ycorner+9'd16) ||
                  (xcoord >= xcorner && xcoord <=xcorner+10'd16 &&ycoord==ycorner+9'd8) ||
                  (xcoord >= xcorner+10'd16 && xcoord <=xcorner+10'd24 &&ycoord==ycorner+9'd16) ||
                  (xcoord == xcorner+10'd16 && ycoord>=ycorner+9'd8 && ycoord<=ycorner+9'd16);
endmodule

module drawsideL(input [9:0] xcoord, [8:0] ycoord, [9:0] xcorner, [8:0] ycorner , output cond);
    assign cond = (xcoord == xcorner && ycoord>=ycorner && ycoord<=ycorner+9'd16) ||
                  (xcoord >= xcorner && xcoord <=xcorner+10'd24 &&ycoord==ycorner) ||
                  (xcoord == xcorner+10'd24 && ycoord>=ycorner && ycoord<=ycorner+9'd8) ||
                  (xcoord >= xcorner && xcoord <=xcorner+10'd8 &&ycoord==ycorner+9'd16) ||
                  (xcoord >= xcorner+10'd8 && xcoord <=xcorner+10'd24 &&ycoord==ycorner+9'd8) ||
                  (xcoord == xcorner+10'd8 && ycoord>=ycorner+9'd8 && ycoord<=ycorner+9'd16);
endmodule

module drawsideS(input [9:0] xcoord, [8:0] ycoord, [9:0] xcorner, [8:0] ycorner , output cond);
    assign cond = (xcoord == xcorner && ycoord>=ycorner && ycoord<=ycorner+9'd16) ||
                  (xcoord >= xcorner && xcoord <=xcorner+10'd8 &&ycoord==ycorner) ||
                  (xcoord == xcorner+10'd16 && ycoord>=ycorner+9'd8 && ycoord<=ycorner+9'd24) ||
                  (xcoord >= xcorner && xcoord <=xcorner+10'd8 &&ycoord==ycorner+9'd16) ||
                  (xcoord >= xcorner+10'd8 && xcoord <=xcorner+10'd16 &&(ycoord==ycorner+9'd8||ycoord==ycorner+9'd24)) ||
                  (xcoord == xcorner+10'd8 && ((ycoord>=ycorner && ycoord<=ycorner+9'd8)||(ycoord>=ycorner+9'd16 && ycoord<=ycorner+9'd24)));
endmodule


















