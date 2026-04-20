`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2026 08:59:19 PM
// Design Name: 
// Module Name: modifiable_freq
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


module modifiable_freq #(parameter N = 440) (input clk,
                                            output freq);
    parameter clock = 100_000_000;
    reg [17:0] counter = 18'b0;
    reg slow_clock = 0;
    always @(posedge clk) begin
        if (counter == clock/2/N - 1) begin
            counter <= 0;
            slow_clock <= ~slow_clock;
        end else begin
            counter <= counter + 1;
        end
    end
    assign freq = slow_clock;
endmodule
