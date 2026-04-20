`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2026 09:52:51 PM
// Design Name: 
// Module Name: collision_module
// 
//////////////////////////////////////////////////////////////////////////////////


module collision_module (
    input clk,
    input [8:0] centre_coord,
    input [4:0] block_id,
    input game_started_flag,
    input [199:0] flat_memory_array,
    input spawn_new_flag,
    output reg collision_flag = 1'b0,
    output reg update_memory_flag = 1'b0
);
    integer i, j;
    reg memory_array_2d [0:19][0:9];
    always @(*) begin
        for (i = 0; i < 20; i = i + 1)
            for (j = 0; j < 10; j = j + 1)
                memory_array_2d[i][j] = flat_memory_array[i*10 + j];
    end
 
    wire [3:0] x = centre_coord[8:5];
    wire [4:0] y = centre_coord[4:0];
 
    reg locked = 1'b0;
 
    always @(posedge clk) begin
        update_memory_flag <= 1'b0;
 
        if (spawn_new_flag || !game_started_flag) begin
            collision_flag <= 1'b0;
            locked         <= 1'b0;
        end
        else begin
            collision_flag <= 1'b0;
 
            // O block
            if (block_id[2:0] == 3'b000) begin
                if (y >= 18 || memory_array_2d[y+2][x] || memory_array_2d[y+2][x+1]) begin
                    collision_flag <= 1'b1;
                    if (!locked) begin update_memory_flag <= 1'b1; locked <= 1'b1; end
                end
            end
            // L block
            if (block_id[2:0] == 3'b001) begin
                if (block_id[4:3] == 2'b00) begin
                    if (y >= 17 || memory_array_2d[y+3][x] || memory_array_2d[y+3][x+1]) begin
                        collision_flag <= 1'b1;
                        if (!locked) begin update_memory_flag <= 1'b1; locked <= 1'b1; end
                    end
                end
                else if (block_id[4:3] == 2'b01) begin
                    if (y >= 18 || memory_array_2d[y+2][x-2] || memory_array_2d[y+1][x-1] || memory_array_2d[y+1][x]) begin
                        collision_flag <= 1'b1;
                        if (!locked) begin update_memory_flag <= 1'b1; locked <= 1'b1; end
                    end
                end
                else if (block_id[4:3] == 2'b10) begin
                    if (y >= 19 || memory_array_2d[y+1][x] || memory_array_2d[y-1][x-1]) begin
                        collision_flag <= 1'b1;
                        if (!locked) begin update_memory_flag <= 1'b1; locked <= 1'b1; end
                    end
                end
                else if (block_id[4:3] == 2'b11) begin
                    if (y >= 19 || memory_array_2d[y+1][x] || memory_array_2d[y+1][x+1] || memory_array_2d[y+1][x+2]) begin
                        collision_flag <= 1'b1;
                        if (!locked) begin update_memory_flag <= 1'b1; locked <= 1'b1; end
                    end
                end
            end
            // I block
            if (block_id[2:0] == 3'b010) begin
                if (block_id[4:3] == 2'b00 || block_id[4:3] == 2'b10) begin
                    if (y >= 16 || memory_array_2d[y+4][x]) begin
                        collision_flag <= 1'b1;
                        if (!locked) begin update_memory_flag <= 1'b1; locked <= 1'b1; end
                    end
                end
                else begin
                    if (y >= 19 || memory_array_2d[y+1][x] || memory_array_2d[y+1][x-1] || memory_array_2d[y+1][x-2] || memory_array_2d[y+1][x-3]) begin
                        collision_flag <= 1'b1;
                        if (!locked) begin update_memory_flag <= 1'b1; locked <= 1'b1; end
                    end
                end
            end
            // S block
            if (block_id[2:0] == 3'b011) begin
                if (block_id[4:3] == 2'b00 || block_id[4:3] == 2'b10) begin
                    if (y >= 18 || memory_array_2d[y+2][x-1] || memory_array_2d[y+2][x] || memory_array_2d[y+1][x+1]) begin
                        collision_flag <= 1'b1;
                        if (!locked) begin update_memory_flag <= 1'b1; locked <= 1'b1; end
                    end
                end
                else begin
                    if (y >= 18 || memory_array_2d[y+1][x-1] || memory_array_2d[y+2][x]) begin
                        collision_flag <= 1'b1;
                        if (!locked) begin update_memory_flag <= 1'b1; locked <= 1'b1; end
                    end
                end
            end
            // T block
            if (block_id[2:0] == 3'b100) begin
                if (block_id[4:3] == 2'b00) begin
                    if (y >= 18 || memory_array_2d[y+2][x-1] || memory_array_2d[y+2][x] || memory_array_2d[y+2][x+1]) begin
                        collision_flag <= 1'b1;
                        if (!locked) begin update_memory_flag <= 1'b1; locked <= 1'b1; end
                    end
                end
                else if (block_id[4:3] == 2'b01) begin
                    if (y >= 18 || memory_array_2d[y+2][x-1] || memory_array_2d[y+1][x]) begin
                        collision_flag <= 1'b1;
                        if (!locked) begin update_memory_flag <= 1'b1; locked <= 1'b1; end
                    end
                end
                else if (block_id[4:3] == 2'b10) begin
                    if (y >= 19 || memory_array_2d[y][x-1] || memory_array_2d[y+1][x] || memory_array_2d[y][x+1]) begin
                        collision_flag <= 1'b1;
                        if (!locked) begin update_memory_flag <= 1'b1; locked <= 1'b1; end
                    end
                end
                else if (block_id[4:3] == 2'b11) begin
                    if (y >= 18 || memory_array_2d[y+1][x] || memory_array_2d[y+2][x+1]) begin
                        collision_flag <= 1'b1;
                        if (!locked) begin update_memory_flag <= 1'b1; locked <= 1'b1; end
                    end
                end
            end
        end
    end
endmodule