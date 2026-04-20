`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/11/2026 03:18:08 PM
// Design Name: 
// Module Name: src1
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


module src1(
    input clock, //100MHz
    input BTNU, BTNL, BTNR, BTNC, BTND,
    output [15:1] LD,
    output [6:0] seg,
    output [3:0] an,
    input gamestart, [15:1] sw,
    output Xsync,
    output Ysync,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output [7:0] JC, //oled display - cong
    output [3:0] JB //speaker - cong
);

wire clk; //10MHz

ten_M tenM (clock, clk);

wire clk6p25m;
wire [12:0] pixel_index;
wire frame_begin, sending_pixels, sample_pixel;
wire [15:0] pixel_data;
wire [15:0] score;

//speaker - cong
speaker blk_speaker (.clk (clock),
                    .sw(gamestart),
                    .JB(JB));

//score on oled
score_display score_inst (
        .clk           (clk), //change clk to clock??
        .reset         (!gamestart),
        .pixel_index   (pixel_index),
        .score_input (score),
        .pixel_data    (pixel_data)
    );

// Clock divider for oled
clk6p25m clk_div_oled (
    .clk     (clock),
    .reset   (!gamestart),
    .clk6p25m(clk6p25m)
);

// oled for score - cong
Oled_Display oled (
    .clk (clk6p25m),
    .reset (!gamestart),
    .pixel_data (pixel_data),
    .pixel_index (pixel_index),
    .cs (JC[0]),
    .sdin (JC[1]),
    .sclk (JC[3]),
    .d_cn (JC[4]),
    .resn (JC[5]),
    .vccen (JC[6]),
    .pmoden (JC[7]),
    .frame_begin (frame_begin),
    .sending_pixels(sending_pixels),
    .sample_pixel (sample_pixel)
);




wire game_on;
assign game_on = gamestart;

reg [1:0] clk_div = 0;

always @(posedge clock) //from 100MHz
    clk_div <= clk_div + 1;

wire pixel_clk = clk_div[1];   // 25 MHz


// VGA timing
parameter X_VISIBLE = 640;
parameter X_FRONT = 16;
parameter X_SYNC = 96;
parameter X_BACK = 48;
parameter X_TOTAL = 800;

parameter Y_VISIBLE = 480;
parameter Y_FRONT = 10;
parameter Y_SYNC = 2;
parameter Y_BACK = 33;
parameter Y_TOTAL = 525;


reg [9:0] x_count = 0;
reg [8:0] y_count = 0;


always @(posedge pixel_clk)
begin
    if (x_count == X_TOTAL - 1)
    begin
        x_count <= 0;

        if (y_count == Y_TOTAL - 1)
            y_count <= 0;
        else
            y_count <= y_count + 1;
    end
    else
        x_count <= x_count + 1;
end


assign Xsync = ~(x_count >= 656 && x_count < 752);
assign Ysync = ~(y_count >= 490 && y_count < 492);


wire video_on;
assign video_on = (x_count < X_VISIBLE) && (y_count < Y_VISIBLE);
wire box = (x_count >= 50 && x_count <=100)&& (y_count >=50 && y_count<=100);

wire check = x_count<= 11*20 || x_count%20 == 0 || x_count>=21*20;
wire check2 = y_count <= 2*20 || y_count%20 == 0 || y_count>=22*20;
wire gridcond = check2 || check;
reg [11:0] vga_hex; 

assign {vgaRed, vgaGreen, vgaBlue} = vga_hex;

wire returninst;
switchtoreturn rgss2(x_count,y_count,returninst);
wire gameoverdisplay;
gameover_display(x_count,y_count,gameoverdisplay);

wire slowclk;
slowed_clk duuut(clock,slowclk);
wire [4:0] block_id;
wire shade_area;
wire [35:0] blk_chunks;
wire [8:0] position;
draw_block dut(block_id, position, blk_chunks);
blkchunk2blkpix d2(x_count, y_count, blk_chunks, shade_area); //convert chunks to condition
wire [7:0] counter;
wire condtext;
draw_name d122( x_count,y_count, 10'd12, 9'd14 , condtext);

//for start menu
wire T1,E,T2,R,I,S,boxx,shading;
title rg(x_count, y_count, T1, E, T2, R, I, S, boxx,shading);
wire instructions;
switchtobegin deet2(x_count,y_count,instructions);
reg [199:0] flat_memory_array_old;
wire [199:0] flat_memory_array_updated;
wire filled;
shade_filled deet(x_count,y_count,flat_memory_array_updated,filled);
wire instructions2;
draw_reroll_inst deet3(x_count,y_count,instructions2);


wire spawn_new_flag;    //new-hieu
wire game_over_flag;    //new
wire updatemem;         //new

memory_module memory_blk (
    .clk(clk), //change clk to clock??
    .centre_coord (position),
    .block_id (block_id),
    .flat_memory_array_old (flat_memory_array_old),
    .update_memory_flag (updatemem),
    .game_started_flag (game_on),
    .spawn_new_flag (spawn_new_flag),
    .flat_memory_array_updated (flat_memory_array_updated),
    .score (score),
    .game_over_flag (game_over_flag)
);

//collision part
wire collision_flag;

always @ (posedge clk) begin
    flat_memory_array_old <= flat_memory_array_updated;
end

collision_module collision_blk (
    .clk (clk), //change clk to clock??
    .centre_coord (position),
    .block_id (block_id),
    .flat_memory_array (flat_memory_array_old),
    .game_started_flag (game_on),
    .spawn_new_flag (spawn_new_flag),  
    .collision_flag (collision_flag),
    .update_memory_flag (updatemem)
);
    
    
clocktickcounter duuu(clock, counter);
wire [3:0] reroll_remain;
wire [3:0] reroll_start;

ip_handler_new game_ctrl (
    .clk(clk), //change clk to clock??
    .start(game_on),
    .BTNU(BTNU),
    .BTNL(BTNL),
    .BTNR(BTNR),
    .BTNC(BTNC),
    .BTND(BTND),
    .score(score),
    .LD(LD),
    .collision_flag(collision_flag),
    .spawn_new_flag(spawn_new_flag),
    .flat_memory_array(flat_memory_array_old),
    .block_id(block_id),
    .centre(position),
    .reroll_remain(reroll_remain),
    .reroll_start (reroll_start)
);

reroll_tracker phm3(clock,gamestart,sw[15:1],reroll_remain, reroll_start, seg,an);

always @(posedge pixel_clk) begin
    if (!video_on)
        vga_hex <= 12'h000;
    else if(gamestart) 
        begin
    if(!game_over_flag) begin
    if (condtext) //title
        vga_hex <= 12'hFFF;
    else if (gridcond) //gameplay space
        vga_hex <= 12'h000;
    else if (shade_area) //falling block
        begin
        if (block_id[2:0] == 3'b000) //2x2 yellow
            vga_hex <= 12'hFF0;
        else if (block_id[2:0] == 3'b001) //L orange
            vga_hex <=12'hF90; 
        else if (block_id[2:0] == 3'b010) //4x1 cyan
            vga_hex <=12'h0FF; 
        else if (block_id[2:0] == 3'b011) //S light green
            vga_hex <=12'h0F1; 
        else if (block_id[2:0] == 3'b100) //T purple
            vga_hex <=12'hB6F; 
        end
    else if (filled)
        vga_hex <=12'h02F; //filled blocks
    else
        vga_hex <= 12'hFFF;
        end
    else begin
    if(returninst && slowclk)
        vga_hex <=12'hFF0;    
    else if (gameoverdisplay)
        vga_hex <=12'hF11;
    else vga_hex <=12'h000;
    end
        end
    else 
    begin
    if(T1)
        vga_hex <=12'hF00;
    else if (E)
        vga_hex <=12'hF70;
    else if (T2)
        vga_hex <=12'hFF0;
    else if (R)
        vga_hex <=12'h0F0;
    else if (I)
        vga_hex <=12'h0FF;
    else if (S)
        vga_hex <=12'hB0F;
    else if (shading)
         vga_hex <=12'h107;
    else if (boxx)
        vga_hex <=12'h43D;
    else if (instructions2)
        vga_hex <=12'hFFF;
    else if (instructions && slowclk)
        vga_hex <=12'hFF0;
    else
        vga_hex <=12'h000;
    end

end
endmodule

module slowed_clk(input clock, output wave);
    reg [31:0] count = 0;
    reg slowedwave = 0;
    
    always @ (posedge clock) begin
        count <= (count==49_999_999) ? 0 : count +1;
        slowedwave <= (count==49_999_999) ? ~slowedwave : slowedwave;
    end
    
    assign wave = slowedwave;
endmodule

module clocktickcounter(input clock, output reg [7:0] count);
    wire wave;
    initial count = 0;
    slowed_clk dut2(clock,wave);
    always@(posedge wave) begin
        if (count != 13) //so that increment stops after max leds (i think the value will overflow if left alone too long)
            count <= count + 1;
            
        else count <=0;
    end
endmodule

module ten_M(input clock, output clk);
    reg [31:0] count = 0;
    reg slowedwave = 0;
    
    always @ (posedge clock) begin
        count <= (count==4) ? 0 : count +1;
        slowedwave <= (count==4) ? ~slowedwave : slowedwave;
    end
    
    assign clk = slowedwave;
endmodule
