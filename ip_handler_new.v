`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2026 06:33:31 PM
// Design Name: 
// Module Name: ip_handler2
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


module ip_handler_new (
    input clk,
    input start,
    input collision_flag,
    input spawn_new_flag,
    input [15:0] score,
    input [3:0] reroll_start,
    input BTNU, BTNL, BTNR, BTNC, BTND,
    input [199:0] flat_memory_array,   // for left/right/rotate collision check
    output wire [3:0] reroll_remain,
    output reg [4:0] block_id = 5'b00_000,
    output [8:0] centre,
    output [15:1] LD //leds
);
 
    // Button conditioning
    wire move_left, move_right, rotate, hold_rng, fast_drop_pulse;
    button_conditioner bcU (clk, BTNU, rotate);
    button_conditioner bcL (clk, BTNL, move_left);
    button_conditioner bcR (clk, BTNR, move_right);
    button_conditioner bcC (clk, BTNC, hold_rng);
    button_conditioner bcD (clk, BTND, fast_drop_pulse);
    wire fast_drop = bcD.stable_btn;

    // RNG system
    wire [2:0] next_piece;
    reroll_system rng (
        .clk(clk), 
        .rst(!start),
        .btnc(hold_rng && !collision_flag),
        .reroll_init(reroll_start),
        .spawn_new_flag(spawn_new_flag),
        .ON_flag(1'b1),
        .held_piece(next_piece),
        .reroll_count(reroll_remain)
    );

    // Position
    reg [3:0] x = 4'b0101;
    reg [4:0] y = 5'b00000;
    assign centre = {x, y};
 
    reg [26:0] fall_count = 0;
    reg [26:0] speed_threshold;
    
    always @(*) begin
        if (score < 16'd50)
            speed_threshold = 27'd9_999_999; //27'd99_999_999; //1 Hz
        else if (score < 16'd100)
            speed_threshold = 27'd4_999_999; //27'd49_999_999; //2 Hz
        else if (score < 16'd150)
            speed_threshold = 27'd3_999_999; //27'd39_999_999; // ~2.5 Hz
        else
            speed_threshold = 27'd3_333_333; //27'd33_333_333; // stay at 3 Hz aft 150 points
    end
    
    wire fall_pulse = (fast_drop) ? (fall_count >= 27'd1_999_999) : (fall_count >= speed_threshold); // 27'd19_999_999 (100MHz) //5 Hz when btn D or based on score when not btn D
    wire [26:0] current_active_threshold = (fast_drop) ? 27'd1_999_999 : speed_threshold; //used for led blinking
    reg blink_reg;
    
    // Memory decode
    integer mi, mj;
    reg mem2d [0:19][0:9];
    always @(*) begin
        for (mi = 0; mi < 20; mi = mi + 1)
            for (mj = 0; mj < 10; mj = mj + 1)
                mem2d[mi][mj] = flat_memory_array[mi*10 + mj];
    end

    // Combinational: can_move_left
    reg can_move_left;
    always @(*) begin
        can_move_left = 1'b1;
        // O block
        if (block_id == 5'b00_000) begin
            if (x == 0) can_move_left = 0;
            else if (mem2d[y][x-1] || mem2d[y+1][x-1]) can_move_left = 0;
        end
        // L 
        else if (block_id == 5'b00_001) begin
            if (x == 0) can_move_left = 0;
            else if (mem2d[y][x-1] || mem2d[y+1][x-1] || mem2d[y+2][x-1]) can_move_left = 0;
        end
        else if (block_id == 5'b01_001) begin
            if (x < 3) can_move_left = 0;
            else if (mem2d[y][x-3] || mem2d[y+1][x-3]) can_move_left = 0;
        end
        else if (block_id == 5'b10_001) begin
            if (x < 2) can_move_left = 0;
            else if (mem2d[y-2][x-2] || mem2d[y-1][x-1] || mem2d[y][x-1]) can_move_left = 0;
        end
        else if (block_id == 5'b11_001) begin
            if (x == 0) can_move_left = 0;
            else if (mem2d[y-1][x+1] || mem2d[y][x-1]) can_move_left = 0;
        end
        // I 
        else if (block_id == 5'b00_010) begin
            if (x == 0) can_move_left = 0;
            else if (mem2d[y][x-1] || mem2d[y+1][x-1] || mem2d[y+2][x-1] || mem2d[y+3][x-1]) can_move_left = 0;
        end
        else if (block_id == 5'b01_010) begin
            if (x < 4) can_move_left = 0;
            else if (mem2d[y][x-4]) can_move_left = 0;
        end
        // S 
        else if (block_id == 5'b00_011) begin
            if (x < 2) can_move_left = 0;
            else if (mem2d[y][x-1] || mem2d[y+1][x-2]) can_move_left = 0;
        end
        else if (block_id == 5'b01_011) begin
            if (x < 2) can_move_left = 0;
            else if (mem2d[y-1][x-2] || mem2d[y][x-2] || mem2d[y+1][x-1]) can_move_left = 0;
        end
        // T 
        else if (block_id == 5'b00_100) begin
            if (x < 2) can_move_left = 0;
            else if (mem2d[y][x-1] || mem2d[y+1][x-2]) can_move_left = 0;
        end
        else if (block_id == 5'b01_100) begin
            if (x < 2) can_move_left = 0;
            else if (mem2d[y-1][x-2] || mem2d[y][x-2] || mem2d[y+1][x-2]) can_move_left = 0;
        end
        else if (block_id == 5'b10_100) begin
            if (x < 2) can_move_left = 0;
            else if (mem2d[y-1][x-2] || mem2d[y][x-1]) can_move_left = 0;
        end
        else if (block_id == 5'b11_100) begin
            if (x == 0) can_move_left = 0;
            else if (mem2d[y-1][x] || mem2d[y][x-1] || mem2d[y+1][x]) can_move_left = 0;
        end
    end
 
    // Combinational: can_move_right
    reg can_move_right;
    always @(*) begin
        can_move_right = 1'b1;
        // O 
        if (block_id == 5'b00_000) begin
            if (x >= 8) can_move_right = 0;
            else if (mem2d[y][x+2] || mem2d[y+1][x+2]) can_move_right = 0;
        end
        // L
        else if (block_id == 5'b00_001) begin
            if (x >= 8) can_move_right = 0;
            else if (mem2d[y][x+1] || mem2d[y+1][x+1] || mem2d[y+2][x+2]) can_move_right = 0;
        end
        else if (block_id == 5'b01_001) begin
            if (x >= 9) can_move_right = 0;
            else if (mem2d[y][x+1] || mem2d[y+1][x-1]) can_move_right = 0;
        end
        else if (block_id == 5'b10_001) begin
            if (x >= 9) can_move_right = 0;
            else if (mem2d[y-2][x+1] || mem2d[y-1][x+1] || mem2d[y][x+1]) can_move_right = 0;
        end
        else if (block_id == 5'b11_001) begin
            if (x >= 7) can_move_right = 0;
            else if (mem2d[y-1][x+3] || mem2d[y][x+3]) can_move_right = 0;
        end
        // I 
        else if (block_id == 5'b00_010) begin
            if (x >= 9) can_move_right = 0;
            else if (mem2d[y][x+1] || mem2d[y+1][x+1] || mem2d[y+2][x+1] || mem2d[y+3][x+1]) can_move_right = 0;
        end
        else if (block_id == 5'b01_010) begin
            if (x >= 9) can_move_right = 0;
            else if (mem2d[y][x+1]) can_move_right = 0;
        end
        // S
        else if (block_id == 5'b00_011) begin
            if (x >= 8) can_move_right = 0;
            else if (mem2d[y][x+2] || mem2d[y+1][x+1]) can_move_right = 0;
        end
        else if (block_id == 5'b01_011) begin
            if (x >= 9) can_move_right = 0;
            else if (mem2d[y-1][x] || mem2d[y][x+1] || mem2d[y+1][x+1]) can_move_right = 0;
        end
        // T 
        else if (block_id == 5'b00_100) begin
            if (x >= 8) can_move_right = 0;
            else if (mem2d[y][x+1] || mem2d[y+1][x+2]) can_move_right = 0;
        end
        else if (block_id == 5'b01_100) begin
            if (x >= 9) can_move_right = 0;
            else if (mem2d[y-1][x] || mem2d[y][x+1] || mem2d[y+1][x]) can_move_right = 0;
        end
        else if (block_id == 5'b10_100) begin
            if (x >= 8) can_move_right = 0;
            else if (mem2d[y-1][x+2] || mem2d[y][x+1]) can_move_right = 0;
        end
        else if (block_id == 5'b11_100) begin
            if (x >= 8) can_move_right = 0;
            else if (mem2d[y-1][x+2] || mem2d[y][x+2] || mem2d[y+1][x+2]) can_move_right = 0;
        end
    end
 
    // Combinational: can_rotate
    reg can_rotate;
    always @(*) begin
        can_rotate = 1'b1;
        // O 
        if (block_id[2:0] == 3'b000) can_rotate = 1;
 
        // L
        else if (block_id == 5'b00_001) begin
            if (x < 2) can_rotate = 0;
            else if (mem2d[y][x-1] || mem2d[y][x-2] || mem2d[y+1][x-2]) can_rotate = 0;
        end
        else if (block_id == 5'b01_001) begin
            if (x < 1 || y < 2) can_rotate = 0;
            else if (mem2d[y-1][x] || mem2d[y-2][x] || mem2d[y-2][x-1]) can_rotate = 0;
        end
        else if (block_id == 5'b10_001) begin
            if (x > 7 || y < 1) can_rotate = 0;
            else if (mem2d[y][x+1] || mem2d[y][x+2] || mem2d[y-1][x+2]) can_rotate = 0;
        end
        else if (block_id == 5'b11_001) begin
            if (x > 8) can_rotate = 0;
            else if (mem2d[y+1][x] || mem2d[y+2][x] || mem2d[y+2][x+1]) can_rotate = 0;
        end
 
        // I 
        else if (block_id == 5'b00_010 || block_id == 5'b10_010) begin
            if (x < 3) can_rotate = 0;
            else if (mem2d[y][x-1] || mem2d[y][x-2] || mem2d[y][x-3]) can_rotate = 0;
        end
        else if (block_id == 5'b01_010 || block_id == 5'b11_010) begin
            if (x > 9) can_rotate = 0;
            else if (mem2d[y+1][x] || mem2d[y+2][x] || mem2d[y+3][x]) can_rotate = 0;
        end
 
        // S 
        else if (block_id == 5'b00_011 || block_id == 5'b10_011) begin
            if (x < 1 || y < 1) can_rotate = 0;
            else if (mem2d[y+1][x] || mem2d[y][x-1] || mem2d[y-1][x-1]) can_rotate = 0;
        end
        else if (block_id == 5'b01_011 || block_id == 5'b11_011) begin
            if (x > 8) can_rotate = 0;
            else if (mem2d[y][x+1] || mem2d[y+1][x] || mem2d[y+1][x-1]) can_rotate = 0;
        end
 
        // T 
        else if (block_id == 5'b00_100) begin
            if (x < 1 || y < 1) can_rotate = 0;
            else if (mem2d[y][x-1] || mem2d[y-1][x-1] || mem2d[y+1][x-1]) can_rotate = 0;
        end
        else if (block_id == 5'b01_100) begin
            if (y < 1 || x > 8) can_rotate = 0;
            else if (mem2d[y-1][x] || mem2d[y-1][x-1] || mem2d[y-1][x+1]) can_rotate = 0;
        end
        else if (block_id == 5'b10_100) begin
            if (x > 8 || y < 1) can_rotate = 0;
            else if (mem2d[y][x+1] || mem2d[y-1][x+1] || mem2d[y+1][x+1]) can_rotate = 0;
        end
        else if (block_id == 5'b11_100) begin
            if (x < 1 || x > 8) can_rotate = 0;
            else if (mem2d[y+1][x] || mem2d[y+1][x-1] || mem2d[y+1][x+1]) can_rotate = 0;
        end
    end
 
    // Sequential logic
    always @(posedge clk) begin
        if (!start) begin
            x <= 4'b0101; y <= 5'b00000;
            block_id <= 5'b00_000; fall_count <= 0; 
            blink_reg <= 0;
        end
        else if (spawn_new_flag) begin
            x <= 4'b0101; y <= 5'b00000;
            block_id <= {2'b00, next_piece}; fall_count <= 0;
        end
        else if (collision_flag) begin
            fall_count <= 0;
        end
        else begin
            fall_count <= (fall_pulse || fast_drop_pulse) ? 27'd0 : fall_count + 1;
            blink_reg <= (fall_count < (current_active_threshold >> 1)); //led blinking
            
            // Rotation: boundary guard + memory collision check
            if (rotate && can_rotate) begin
                block_id[4:3] <= block_id[4:3] + 1;
            end
 
            // Left/right: use can_move_left/right
            if (move_left  && can_move_left)  x <= x - 1;
            if (move_right && can_move_right) x <= x + 1;
 
            // Reroll
            if (hold_rng && reroll_remain > 0) begin
                block_id <= {2'b00, next_piece};
                x <= 4'b0101; y <= 5'b00000;
            end
 
            // Fall
            if (fall_pulse) y <= y + 1;
        end
    end
    assign LD = (start && blink_reg) ? 15'h7FFF : 15'h0000; //blink 
endmodule
 
module button_conditioner (
    input clk,
    input btn_in,
    output pulse_out
);
    reg [19:0] count = 0;
    reg stable_btn = 0;
    reg delay_btn = 0;
    always @(posedge clk) begin
        if (btn_in == stable_btn) count <= 0;
        else begin
            count <= count + 1;
            if (count >= 1_000_00) begin stable_btn <= btn_in; count <= 0; end
        end
    end
    always @(posedge clk) delay_btn <= stable_btn;
    assign pulse_out = stable_btn & ~delay_btn;
endmodule

module reroll_system (
    input clk,
    input rst,
    input btnc,
    input ON_flag,            
    input [3:0] reroll_init,
    input spawn_new_flag,  

    output reg [2:0] held_piece, // 0-4
    output reg [3:0] reroll_count
);
//random
    reg [3:0] lfsr = 4'b1011;

    wire [2:0] rand_piece;
    assign rand_piece = lfsr % 5;   // 0-4

    always @(posedge clk) begin
            lfsr <= {lfsr[2:0], lfsr[3] ^ lfsr[2]};
    end
//reroll
    always @(posedge clk) begin //used to have async reset
        if (rst) begin
            reroll_count <= reroll_init; //order was swapped
            held_piece <= 0;
        end 
        else if (btnc && reroll_count > 0) begin
            reroll_count <= reroll_count - 1;
        end
       held_piece <= ((!ON_flag) || btnc || rst || spawn_new_flag) ? rand_piece : held_piece;
    end

endmodule


