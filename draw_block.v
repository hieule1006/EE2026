`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2026 15:16:44
// Design Name: 
// Module Name: draw_block
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


module draw_block(input [4:0] block_id, [8:0] centre_coord, output [35:0] block_chunks);
    
    reg [8:0] chunk1;
    reg [8:0] chunk2;
    reg [8:0] chunk3;
    reg [8:0] chunk4;
    
    assign block_chunks = {chunk1, chunk2, chunk3, chunk4};
    
    wire [3:0] centre_x = centre_coord[8:5];
    wire [4:0] centre_y = centre_coord[4:0];
    
    always @(*) begin
    
    case (block_id[2:0])
    3'b000: begin //2x2 square, no need to check rotation
            chunk1 = centre_coord; //top left
            chunk2 = {(centre_x + 4'b0001),(centre_y)}; //top right
            chunk3 = {(centre_x),(centre_y + 4'b0001)}; //bottom left
            chunk4 = {(centre_x + 4'b0001),(centre_y + 4'b0001)}; //bottom right
            end
    3'b001: begin //L
            case (block_id[4:3])
            2'b00:  begin //upright L
                    chunk1 = centre_coord; //top
                    chunk2 = {(centre_x),(centre_y + 4'b0001)}; //one below
                    chunk3 = {(centre_x),(centre_y + 4'b0010)}; //two below
                    chunk4 = {(centre_x + 4'b0001),(centre_y + 4'b0010)}; //jutting part  
                    end
            2'b01:  begin //90 deg clockwise
                    chunk1 = centre_coord; //far left
                    chunk2 = {(centre_x - 4'b0001),(centre_y)}; //one left
                    chunk3 = {(centre_x - 4'b0010),(centre_y)}; //two left
                    chunk4 = {(centre_x - 4'b0010),(centre_y + 4'b0001)}; //jutting part                 
                    end
            2'b10:  begin //upside down
                    chunk1 = centre_coord; //very bottom
                    chunk2 = {(centre_x),(centre_y - 4'b0001)}; //one up
                    chunk3 = {(centre_x),(centre_y - 4'b0010)}; //two up
                    chunk4 = {(centre_x - 4'b0001),(centre_y - 4'b0010)}; //jutting part                                         
                    end
            2'b11:  begin //90 deg counter clockwise
                    chunk1 = centre_coord; //far left
                    chunk2 = {(centre_x + 4'b0001),(centre_y)}; //one right
                    chunk3 = {(centre_x + 4'b0010),(centre_y)}; //two right
                    chunk4 = {(centre_x + 4'b0010),(centre_y - 4'b0001)}; //jutting part                                           
                    end            
            endcase
            end
    3'b010: begin //4x1
            case (block_id[3])
            1'b0:  begin //upright 
                    chunk1 = centre_coord; //top
                    chunk2 = {(centre_x),(centre_y + 4'b0001)}; //one below
                    chunk3 = {(centre_x),(centre_y + 4'b0010)}; //2 below
                    chunk4 = {(centre_x),(centre_y + 4'b0011)}; //3 below
                    end
            1'b1:  begin //laying down
                    chunk1 = centre_coord; //far right
                    chunk2 = {(centre_x - 4'b0001),(centre_y)}; //one left
                    chunk3 = {(centre_x - 4'b0010),(centre_y)}; //2 left
                    chunk4 = {(centre_x - 4'b0011),(centre_y)}; //3 left               
                    end
            endcase    
            end
    3'b011: begin //S
            case (block_id[3])
            1'b0:  begin //upright 
                    chunk1 = centre_coord; //top
                    chunk2 = {(centre_x + 4'b0001),(centre_y)}; //one right
                    chunk3 = {(centre_x),(centre_y + 4'b0001)}; //1 below
                    chunk4 = {(centre_x - 4'b0001),(centre_y + 4'b0001)}; //1 below + left
                    end
            1'b1:  begin //90 deg clockwise
                    chunk1 = centre_coord; //right
                    chunk2 = {(centre_x),(centre_y + 4'b0001)}; //one down
                    chunk3 = {(centre_x - 4'b0001),(centre_y)}; //1 left
                    chunk4 = {(centre_x - 4'b0001),(centre_y - 4'b0001)}; //1 left, 1 up            
                    end
            endcase             
            end   
    3'b100: begin //T
            case (block_id[4:3])
            2'b00:  begin //upright T
                    chunk1 = centre_coord; //top
                    chunk2 = {(centre_x),(centre_y + 4'b0001)}; //one below
                    chunk3 = {(centre_x - 4'b0001),(centre_y + 4'b0001)}; //left side
                    chunk4 = {(centre_x + 4'b0001),(centre_y + 4'b0001)}; //right side 
                    end
            2'b01:  begin //90 deg clockwise
                    chunk1 = centre_coord; //far left
                    chunk2 = {(centre_x - 4'b0001),(centre_y)}; //one left
                    chunk3 = {(centre_x - 4'b0001),(centre_y - 4'b0001)}; //above
                    chunk4 = {(centre_x - 4'b0001),(centre_y + 4'b0001)}; //below                 
                    end
            2'b10:  begin //upside down
                    chunk1 = centre_coord; //very bottom
                    chunk2 = {(centre_x),(centre_y - 4'b0001)}; //one up
                    chunk3 = {(centre_x - 4'b0001),(centre_y - 4'b0001)}; //left side
                    chunk4 = {(centre_x + 4'b0001),(centre_y - 4'b0001)}; //right side                                       
                    end
            2'b11:  begin //90 deg counter clockwise
                    chunk1 = centre_coord; //far left
                    chunk2 = {(centre_x + 4'b0001),(centre_y)}; //one right
                    chunk3 = {(centre_x + 4'b0001),(centre_y - 4'b0001)}; //above
                    chunk4 = {(centre_x + 4'b0001),(centre_y + 4'b0001)}; //below                                      
                    end            
            endcase                   
            end 
    endcase
    
    end
    
endmodule

