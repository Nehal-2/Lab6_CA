`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2024 01:41:07 PM
// Design Name: 
// Module Name: inst_mem_tb
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


module inst_mem_tb;
    localparam ADDR_WIDTH = 8; // Number of address bits in test file
    localparam INST_WIDTH = 32;
    localparam DEPTH = 28;
    
    logic [ADDR_WIDTH-1:0] addr;
    logic [INST_WIDTH-1:0] inst; // Number of instruction bits in test file
    
    inst_mem #(.ADDR_WIDTH(ADDR_WIDTH), .INST_WIDTH(INST_WIDTH), .DEPTH(DEPTH)) uut (.*);
    
    initial begin
        for (int i = 0; i < 2**ADDR_WIDTH; i++) begin
            addr = i; #10;
        end
        $finish;  // End simulation
    end
    
endmodule
