`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2026 02:37:01 PM
// Design Name: 
// Module Name: speaker
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


module speaker (input clk, 
                input sw,
                output [3:0] JB);

    wire a4, b4, c5, d5, e5, f5, g5, gs5, a5;
    modifiable_freq #(440) blk0 (clk, a4);
    modifiable_freq #(494) blk1 (clk, b4);
    modifiable_freq #(523) blk2 (clk, c5);
    modifiable_freq #(587) blk3 (clk, d5);
    modifiable_freq #(659) blk4 (clk, e5);
    modifiable_freq #(698) blk5 (clk, f5);
    modifiable_freq #(784) blk6 (clk, g5);
    modifiable_freq #(831) blk7 (clk, gs5);
    modifiable_freq #(880) blk8 (clk, a5);

    // Song note delays
    parameter clk_freq = 100_000_000;
    parameter integer D_208ms = 0.208 * clk_freq;
    parameter integer D_417ms = 0.417 * clk_freq;
    parameter integer D_625ms = 0.625 * clk_freq;
    parameter integer D_833ms = 0.833 * clk_freq;
    parameter integer D_1667ms = 1.667 * clk_freq;

    reg [27:0] count = 28'b0;
    reg counter_clear = 1'b0;

    reg [31:0] state = "idle";

    always @(posedge clk) begin
        if (counter_clear) begin
            count <= 0;
            counter_clear <= 0;
        end
        else if (sw) begin
            count <= count + 1;
        end

        case(state)
            "idle": begin
                counter_clear <= 1;
                if (sw) state <= "n1";
            end

            "n1": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b1";
                end
            end
            "b1": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n2";
                end
            end

            "n2": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b2";
                end
            end
            "b2": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n3";
                end
            end

            "n3": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b3";
                end
            end
            "b3": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n4";
                end
            end

            "n4": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b4";
                end
            end
            "b4": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n5";
                end
            end

            "n5": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b5";
                end
            end
            "b5": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n6";
                end
            end

            "n6": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b6";
                end
            end
            "b6": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n7";
                end
            end

            "n7": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b7";
                end
            end
            "b7": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n8";
                end
            end

            "n8": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b8";
                end
            end
            "b8": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n9";
                end
            end

            "n9": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b9";
                end
            end
            "b9": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n10";
                end
            end

            "n10": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b10";
                end
            end
            "b10": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n11";
                end
            end

            "n11": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b11";
                end
            end
            "b11": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n12";
                end
            end

            "n12": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b12";
                end
            end
            "b12": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n13";
                end
            end

            "n13": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_625ms)/10) begin
                    counter_clear <= 1;
                    state <= "b13";
                end
            end
            "b13": begin
                if (~sw) state <= "idle";
                else if (count == D_625ms/10) begin
                    counter_clear <= 1;
                    state <= "n14";
                end
            end

            "n14": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b14";
                end
            end
            "b14": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n15";
                end
            end

            "n15": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b15";
                end
            end
            "b15": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n16";
                end
            end

            "n16": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b16";
                end
            end
            "b16": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n17";
                end
            end

            "n17": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b17";
                end
            end
            "b17": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n18";
                end
            end

            "n18": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b18";
                end
            end
            "b18": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n19";
                end
            end

            "n19": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b19";
                end
            end
            "b19": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n20";
                end
            end

            "n20": begin
                if (~sw) state <= "idle";
                else if (count == 0) begin
                    counter_clear <= 1;
                    state <= "b20";
                end
            end
            "b20": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms) begin
                    counter_clear <= 1;
                    state <= "n21";
                end
            end

            "n21": begin
                if (~sw) state <= "idle";
                else if (count == 0) begin
                    counter_clear <= 1;
                    state <= "b21";
                end
            end
            "b21": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms) begin
                    counter_clear <= 1;
                    state <= "n22";
                end
            end

            "n22": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b22";
                end
            end
            "b22": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n23";
                end
            end

            "n23": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b23";
                end
            end
            "b23": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n24";
                end
            end

            "n24": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b24";
                end
            end
            "b24": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n25";
                end
            end

            "n25": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b25";
                end
            end
            "b25": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n26";
                end
            end

            "n26": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b26";
                end
            end
            "b26": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n27";
                end
            end

            "n27": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_625ms)/10) begin
                    counter_clear <= 1;
                    state <= "b27";
                end
            end
            "b27": begin
                if (~sw) state <= "idle";
                else if (count == D_625ms/10) begin
                    counter_clear <= 1;
                    state <= "n28";
                end
            end

            "n28": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b28";
                end
            end
            "b28": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n29";
                end
            end

            "n29": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b29";
                end
            end
            "b29": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n30";
                end
            end

            "n30": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b30";
                end
            end
            "b30": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n31";
                end
            end

            "n31": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b31";
                end
            end
            "b31": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n32";
                end
            end

            "n32": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b32";
                end
            end
            "b32": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n33";
                end
            end

            "n33": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b33";
                end
            end
            "b33": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n34";
                end
            end

            "n34": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b34";
                end
            end
            "b34": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n35";
                end
            end

            "n35": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b35";
                end
            end
            "b35": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n36";
                end
            end

            "n36": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b36";
                end
            end
            "b36": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n37";
                end
            end

            "n37": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b37";
                end
            end
            "b37": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n38";
                end
            end

            "n38": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b38";
                end
            end
            "b38": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n39";
                end
            end

            "n39": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b39";
                end
            end
            "b39": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n40";
                end
            end

            "n40": begin
                if (~sw) state <= "idle";
                else if (count == 0) begin
                    counter_clear <= 1;
                    state <= "b40";
                end
            end
            "b40": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms) begin
                    counter_clear <= 1;
                    state <= "n41";
                end
            end

            "n41": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_833ms)/10) begin
                    counter_clear <= 1;
                    state <= "b41";
                end
            end
            "b41": begin
                if (~sw) state <= "idle";
                else if (count == D_833ms/10) begin
                    counter_clear <= 1;
                    state <= "n42";
                end
            end

            "n42": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_833ms)/10) begin
                    counter_clear <= 1;
                    state <= "b42";
                end
            end
            "b42": begin
                if (~sw) state <= "idle";
                else if (count == D_833ms/10) begin
                    counter_clear <= 1;
                    state <= "n43";
                end
            end

            "n43": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_833ms)/10) begin
                    counter_clear <= 1;
                    state <= "b43";
                end
            end
            "b43": begin
                if (~sw) state <= "idle";
                else if (count == D_833ms/10) begin
                    counter_clear <= 1;
                    state <= "n44";
                end
            end

            "n44": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_833ms)/10) begin
                    counter_clear <= 1;
                    state <= "b44";
                end
            end
            "b44": begin
                if (~sw) state <= "idle";
                else if (count == D_833ms/10) begin
                    counter_clear <= 1;
                    state <= "n45";
                end
            end

            "n45": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_833ms)/10) begin
                    counter_clear <= 1;
                    state <= "b45";
                end
            end
            "b45": begin
                if (~sw) state <= "idle";
                else if (count == D_833ms/10) begin
                    counter_clear <= 1;
                    state <= "n46";
                end
            end

            "n46": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_833ms)/10) begin
                    counter_clear <= 1;
                    state <= "b46";
                end
            end
            "b46": begin
                if (~sw) state <= "idle";
                else if (count == D_833ms/10) begin
                    counter_clear <= 1;
                    state <= "n47";
                end
            end

            "n47": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_1667ms)/10) begin
                    counter_clear <= 1;
                    state <= "b47";
                end
            end
            "b47": begin
                if (~sw) state <= "idle";
                else if (count == D_1667ms/10) begin
                    counter_clear <= 1;
                    state <= "n48";
                end
            end

            "n48": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_833ms)/10) begin
                    counter_clear <= 1;
                    state <= "b48";
                end
            end
            "b48": begin
                if (~sw) state <= "idle";
                else if (count == D_833ms/10) begin
                    counter_clear <= 1;
                    state <= "n49";
                end
            end

            "n49": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_833ms)/10) begin
                    counter_clear <= 1;
                    state <= "b49";
                end
            end
            "b49": begin
                if (~sw) state <= "idle";
                else if (count == D_833ms/10) begin
                    counter_clear <= 1;
                    state <= "n50";
                end
            end

            "n50": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_833ms)/10) begin
                    counter_clear <= 1;
                    state <= "b50";
                end
            end
            "b50": begin
                if (~sw) state <= "idle";
                else if (count == D_833ms/10) begin
                    counter_clear <= 1;
                    state <= "n51";
                end
            end

            "n51": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_833ms)/10) begin
                    counter_clear <= 1;
                    state <= "b51";
                end
            end
            "b51": begin
                if (~sw) state <= "idle";
                else if (count == D_833ms/10) begin
                    counter_clear <= 1;
                    state <= "n52";
                end
            end

            "n52": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b52";
                end
            end
            "b52": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n53";
                end
            end

            "n53": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b53";
                end
            end
            "b53": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n54";
                end
            end

            "n54": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_833ms)/10) begin
                    counter_clear <= 1;
                    state <= "b54";
                end
            end
            "b54": begin
                if (~sw) state <= "idle";
                else if (count == D_833ms/10) begin
                    counter_clear <= 1;
                    state <= "n55";
                end
            end

            "n55": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_1667ms)/10) begin
                    counter_clear <= 1;
                    state <= "b55";
                end
            end
            "b55": begin
                if (~sw) state <= "idle";
                else if (count == D_1667ms/10) begin
                    counter_clear <= 1;
                    state <= "n56";
                end
            end

            "n56": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b56";
                end
            end
            "b56": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n57";
                end
            end

            "n57": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b57";
                end
            end
            "b57": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n58";
                end
            end

            "n58": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b58";
                end
            end
            "b58": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n59";
                end
            end

            "n59": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b59";
                end
            end
            "b59": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n60";
                end
            end

            "n60": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b60";
                end
            end
            "b60": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n61";
                end
            end

            "n61": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b61";
                end
            end
            "b61": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n62";
                end
            end

            "n62": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b62";
                end
            end
            "b62": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n63";
                end
            end

            "n63": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b63";
                end
            end
            "b63": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n64";
                end
            end

            "n64": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b64";
                end
            end
            "b64": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n65";
                end
            end

            "n65": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b65";
                end
            end
            "b65": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n66";
                end
            end

            "n66": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b66";
                end
            end
            "b66": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n67";
                end
            end

            "n67": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b67";
                end
            end
            "b67": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n68";
                end
            end

            "n68": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_625ms)/10) begin
                    counter_clear <= 1;
                    state <= "b68";
                end
            end
            "b68": begin
                if (~sw) state <= "idle";
                else if (count == D_625ms/10) begin
                    counter_clear <= 1;
                    state <= "n69";
                end
            end

            "n69": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b69";
                end
            end
            "b69": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n70";
                end
            end

            "n70": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b70";
                end
            end
            "b70": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n71";
                end
            end

            "n71": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b71";
                end
            end
            "b71": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n72";
                end
            end

            "n72": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b72";
                end
            end
            "b72": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n73";
                end
            end

            "n73": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b73";
                end
            end
            "b73": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n74";
                end
            end

            "n74": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b74";
                end
            end
            "b74": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n75";
                end
            end

            "n75": begin
                if (~sw) state <= "idle";
                else if (count == 0) begin
                    counter_clear <= 1;
                    state <= "b75";
                end
            end
            "b75": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms) begin
                    counter_clear <= 1;
                    state <= "n76";
                end
            end

            "n76": begin
                if (~sw) state <= "idle";
                else if (count == 0) begin
                    counter_clear <= 1;
                    state <= "b76";
                end
            end
            "b76": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms) begin
                    counter_clear <= 1;
                    state <= "n77";
                end
            end

            "n77": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b77";
                end
            end
            "b77": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n78";
                end
            end

            "n78": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b78";
                end
            end
            "b78": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n79";
                end
            end

            "n79": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b79";
                end
            end
            "b79": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n80";
                end
            end

            "n80": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b80";
                end
            end
            "b80": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n81";
                end
            end

            "n81": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b81";
                end
            end
            "b81": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n82";
                end
            end

            "n82": begin
                if (~sw) state <= "idle";
                else if (count == 0) begin
                    counter_clear <= 1;
                    state <= "b82";
                end
            end
            "b82": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms) begin
                    counter_clear <= 1;
                    state <= "n83";
                end
            end

            "n83": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b83";
                end
            end
            "b83": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n84";
                end
            end

            "n84": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b84";
                end
            end
            "b84": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n85";
                end
            end

            "n85": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b85";
                end
            end
            "b85": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n86";
                end
            end

            "n86": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b86";
                end
            end
            "b86": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n87";
                end
            end

            "n87": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b87";
                end
            end
            "b87": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n88";
                end
            end

            "n88": begin
                if (~sw) state <= "idle";
                else if (count == 0) begin
                    counter_clear <= 1;
                    state <= "b88";
                end
            end
            "b88": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms) begin
                    counter_clear <= 1;
                    state <= "n89";
                end
            end

            "n89": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b89";
                end
            end
            "b89": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n90";
                end
            end

            "n90": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b90";
                end
            end
            "b90": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n91";
                end
            end

            "n91": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b91";
                end
            end
            "b91": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n92";
                end
            end

            "n92": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b92";
                end
            end
            "b92": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n93";
                end
            end

            "n93": begin
                if (~sw) state <= "idle";
                else if (count == 0) begin
                    counter_clear <= 1;
                    state <= "b93";
                end
            end
            "b93": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms) begin
                    counter_clear <= 1;
                    state <= "n94";
                end
            end

            "n94": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b94";
                end
            end
            "b94": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n95";
                end
            end

            "n95": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_208ms)/10) begin
                    counter_clear <= 1;
                    state <= "b95";
                end
            end
            "b95": begin
                if (~sw) state <= "idle";
                else if (count == D_208ms/10) begin
                    counter_clear <= 1;
                    state <= "n96";
                end
            end

            "n96": begin
                if (~sw) state <= "idle";
                else if (count == (9*D_417ms)/10) begin
                    counter_clear <= 1;
                    state <= "b96";
                end
            end
            "b96": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms/10) begin
                    counter_clear <= 1;
                    state <= "n97";
                end
            end

            "n97": begin
                if (~sw) state <= "idle";
                else if (count == 0) begin
                    counter_clear <= 1;
                    state <= "b97";
                end
            end
            "b97": begin
                if (~sw) state <= "idle";
                else if (count == D_417ms) begin
                    counter_clear <= 1;
                    state <= "idle";
                end
            end
        endcase
    end

    assign JB[0] = ((state == "n7")  || (state == "n8")  || (state == "n18") || (state == "n19") ||
                (state == "n38") || (state == "n39") || (state == "n46") || (state == "n62") ||
                (state == "n63") || (state == "n73") || (state == "n74") || (state == "n95") ||
                (state == "n96")) ? a4  :

               ((state == "n2")  || (state == "n6")  || (state == "n13") || (state == "n32") ||
                (state == "n33") || (state == "n44") || (state == "n47") || (state == "n51") ||
                (state == "n57") || (state == "n61") || (state == "n68") || (state == "n89")) ? b4  :

               ((state == "n3")  || (state == "n5")  || (state == "n9")  || (state == "n12") ||
                (state == "n14") || (state == "n17") || (state == "n28") || (state == "n31") ||
                (state == "n34") || (state == "n37") || (state == "n42") || (state == "n45") ||
                (state == "n49") || (state == "n52") || (state == "n58") || (state == "n60") ||
                (state == "n64") || (state == "n67") || (state == "n69") || (state == "n72") ||
                (state == "n84") || (state == "n87") || (state == "n90") || (state == "n94")) ? c5  :

               ((state == "n4")  || (state == "n11") || (state == "n15") || (state == "n22") ||
                (state == "n30") || (state == "n35") || (state == "n43") || (state == "n50") ||
                (state == "n59") || (state == "n66") || (state == "n70") || (state == "n77") ||
                (state == "n86") || (state == "n91")) ? d5  :

               ((state == "n1")  || (state == "n10") || (state == "n16") || (state == "n27") ||
                (state == "n29") || (state == "n36") || (state == "n41") || (state == "n48") ||
                (state == "n53") || (state == "n56") || (state == "n65") || (state == "n71") ||
                (state == "n83") || (state == "n85") || (state == "n92")) ? e5  :

               ((state == "n23") || (state == "n26") || (state == "n78") || (state == "n81")) ? f5  :

               ((state == "n25") || (state == "n80")) ? g5  :

               ((state == "n55")) ? gs5 :

               ((state == "n24") || (state == "n54") || (state == "n79")) ? a5  :

               1'b0;
    
    assign JB[1] = 1;
    assign JB[3] = sw;


endmodule
