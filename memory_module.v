`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2026 16:53:29
// Design Name: 
// Module Name: memory_module
// 
//////////////////////////////////////////////////////////////////////////////////


// this module will be updated if the collision flag is 1, it will update the memory array with the new block's coordinates based on the block_id, 
// It will also clear any line that is fully occupied (all cells in the row are 1) and move down all the lines above the cleared line (increase the row index by 1) when a line is cleared. 
// The module will also keep track of the number of lines cleared to determine when to move down the lines.

module memory_module (
    input clk,
    input [8:0] centre_coord,
    input [4:0] block_id,
    input [199:0] flat_memory_array_old,
    input update_memory_flag,
    input game_started_flag,
    output reg spawn_new_flag = 1'b0,
    output reg [199:0] flat_memory_array_updated = 200'b0,
    output reg [15:0] score = 16'd0,
    output reg game_over_flag = 1'b0
    );
    integer i, j, k;
    integer wr;
    integer count;
    integer write_row;
 
    reg memory_array_old [0:19][0:9];
    reg memory_array_new [0:19][0:9];
    reg memory_array_temp [0:19][0:9];
 
    always @(*) begin
        for (i = 0; i < 20; i = i + 1)
            for (j = 0; j < 10; j = j + 1)
                memory_array_old[i][j] = flat_memory_array_old[i*10 + j];
    end
 
    wire [3:0] x = centre_coord[8:5];
    wire [4:0] y = centre_coord[4:0];
    reg [1:0] state_flag = 2'b00;
    reg [2:0] num_clear_lines = 3'b000;
 
    always @(posedge clk) begin
        if (!game_started_flag) begin
            spawn_new_flag <= 1'b0;
            state_flag     <= 2'b00;
            score          <= 16'd0;
            num_clear_lines <= 3'b000;
            game_over_flag <= 1'b0;
            // Reset the flat output array
            flat_memory_array_updated <= 200'b0;
            for (i = 0; i < 20; i = i + 1)
                for (j = 0; j < 10; j = j + 1)
                    memory_array_new[i][j] <= 1'b0;
        end
        else begin
 
            // State 00: write landed block into memory
            if (state_flag == 2'b00) begin
                spawn_new_flag <= 1'b0;
                if (update_memory_flag) begin
                    for (i = 0; i < 20; i = i + 1)
                        for (j = 0; j < 10; j = j + 1)
                            memory_array_new[i][j] <= memory_array_old[i][j];
                    // O block
                    if (block_id[2:0] == 3'b000) begin
                        memory_array_new[y][x]     <= 1'b1; memory_array_new[y][x+1]   <= 1'b1;
                        memory_array_new[y+1][x]   <= 1'b1; memory_array_new[y+1][x+1] <= 1'b1;
                    end
                    // L block
                    if (block_id[2:0] == 3'b001) begin
                        if (block_id[4:3] == 2'b00) begin
                            memory_array_new[y][x]     <= 1'b1; memory_array_new[y+1][x]   <= 1'b1;
                            memory_array_new[y+2][x]   <= 1'b1; memory_array_new[y+2][x+1] <= 1'b1;
                        end
                        else if (block_id[4:3] == 2'b01) begin
                            memory_array_new[y][x]     <= 1'b1; memory_array_new[y][x-1]   <= 1'b1;
                            memory_array_new[y][x-2]   <= 1'b1; memory_array_new[y+1][x-2] <= 1'b1;
                        end
                        else if (block_id[4:3] == 2'b10) begin
                            memory_array_new[y][x]     <= 1'b1; memory_array_new[y-1][x]   <= 1'b1;
                            memory_array_new[y-2][x]   <= 1'b1; memory_array_new[y-2][x-1] <= 1'b1;
                        end
                        else if (block_id[4:3] == 2'b11) begin
                            memory_array_new[y][x]     <= 1'b1; memory_array_new[y][x+1]   <= 1'b1;
                            memory_array_new[y][x+2]   <= 1'b1; memory_array_new[y-1][x+2] <= 1'b1;
                        end
                    end
                    // I block
                    if (block_id[2:0] == 3'b010) begin
                        if (block_id[4:3] == 2'b00 || block_id[4:3] == 2'b10) begin
                            memory_array_new[y][x]   <= 1'b1; memory_array_new[y+1][x] <= 1'b1;
                            memory_array_new[y+2][x] <= 1'b1; memory_array_new[y+3][x] <= 1'b1;
                        end
                        else begin
                            memory_array_new[y][x]   <= 1'b1; memory_array_new[y][x-1] <= 1'b1;
                            memory_array_new[y][x-2] <= 1'b1; memory_array_new[y][x-3] <= 1'b1;
                        end
                    end
                    // S block
                    if (block_id[2:0] == 3'b011) begin
                        if (block_id[4:3] == 2'b00 || block_id[4:3] == 2'b10) begin
                            memory_array_new[y][x]     <= 1'b1; memory_array_new[y][x+1]   <= 1'b1;
                            memory_array_new[y+1][x]   <= 1'b1; memory_array_new[y+1][x-1] <= 1'b1;
                        end
                        else begin
                            memory_array_new[y][x]     <= 1'b1; memory_array_new[y+1][x]   <= 1'b1;
                            memory_array_new[y][x-1]   <= 1'b1; memory_array_new[y-1][x-1] <= 1'b1;
                        end
                    end
                    // T block
                    if (block_id[2:0] == 3'b100) begin
                        if (block_id[4:3] == 2'b00) begin
                            memory_array_new[y][x]     <= 1'b1; memory_array_new[y+1][x]   <= 1'b1;
                            memory_array_new[y+1][x-1] <= 1'b1; memory_array_new[y+1][x+1] <= 1'b1;
                        end
                        else if (block_id[4:3] == 2'b01) begin
                            memory_array_new[y][x]     <= 1'b1; memory_array_new[y][x-1]   <= 1'b1;
                            memory_array_new[y-1][x-1] <= 1'b1; memory_array_new[y+1][x-1] <= 1'b1;
                        end
                        else if (block_id[4:3] == 2'b10) begin
                            memory_array_new[y][x]     <= 1'b1; memory_array_new[y-1][x]   <= 1'b1;
                            memory_array_new[y-1][x-1] <= 1'b1; memory_array_new[y-1][x+1] <= 1'b1;
                        end
                        else if (block_id[4:3] == 2'b11) begin
                            memory_array_new[y][x]     <= 1'b1; memory_array_new[y][x+1]   <= 1'b1;
                            memory_array_new[y-1][x+1] <= 1'b1; memory_array_new[y+1][x+1] <= 1'b1;
                        end
                    end
                    state_flag <= 2'b01;
                end
            end
 
            // State 01: clear full rows to zero AND count them 
            // Kept identical to original working code.
            else if (state_flag == 2'b01) begin

                // game over condition
                if (memory_array_new[0][4] == 1'b1 || memory_array_new[0][5] == 1'b1 || memory_array_new[0][6] == 1'b1) begin
                    game_over_flag <= 1'b1;
                end

                // continue as normal if not game over
                else begin
                    count = 0;
                    write_row = 19;
                
                    // Init temp to all zeros
                    for (i = 0; i < 20; i = i + 1)
                        for (j = 0; j < 10; j = j + 1)
                            memory_array_temp[i][j] <= 1'b0;
                
                    // Scan bottom to top, pack non-full rows into temp
                    for (i = 19; i >= 0; i = i - 1) begin
                        k = 0;
                        for (j = 0; j < 10; j = j + 1)
                            if (memory_array_new[i][j]) k = k + 1;
                
                        if (k == 10) begin
                            count = count + 1;  // full row skip
                        end
                        else if (k > 0) begin
                            // explicit decode  synthesizable
                            for (wr = 0; wr < 20; wr = wr + 1)
                                if (wr == write_row)
                                    for (j = 0; j < 10; j = j + 1)
                                        memory_array_temp[wr][j] <= memory_array_new[i][j];
                            write_row = write_row - 1;
                        end
                        // k == 0: empty row skip
                    end
                
                    num_clear_lines <= count[2:0];
                    state_flag <= 2'b10;
                end
            end
            
            // State 10: copy temp¨ memory_array_new (fixed index, clean) State 10: copy temp¨ memory_array_new (fixed index, clean)
            else if (state_flag == 2'b10) begin
                for (i = 0; i < 20; i = i + 1)
                    for (j = 0; j < 10; j = j + 1)
                        memory_array_new[i][j] <= memory_array_temp[i][j];
                
                // point update score here based on num_clear_lines
                if (num_clear_lines == 1) begin
                    score <= score + 16'd10;
                end
                else if (num_clear_lines == 2) begin
                    score <= score + 16'd20;
                end
                else if (num_clear_lines == 3) begin
                    score <= score + 16'd50;
                end
                else if (num_clear_lines == 4) begin
                    score <= score + 16'd100;
                end
                else begin
                    score <= score; // no change
                end
                state_flag <= 2'b11;
            end
 
            // State 11: flatten to output and signal spawn State 11: flatten to output and signal spawn
            else if (state_flag == 2'b11) begin
                for (i = 0; i < 20; i = i + 1)
                    for (j = 0; j < 10; j = j + 1)
                        flat_memory_array_updated[i*10 + j] <= memory_array_new[i][j];
                spawn_new_flag <= 1'b1;
                state_flag     <= 2'b00;
            end
 
        end
    end
endmodule