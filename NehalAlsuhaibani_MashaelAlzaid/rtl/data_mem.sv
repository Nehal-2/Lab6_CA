`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2024 05:40:54 PM
// Design Name: 
// Module Name: data_mem
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


module data_mem #(
    parameter WIDTH = 32,
    parameter DEPTH = 1024
)(
        input logic clk,
        input logic reset_n,
        input logic mem_write,
        input logic [WIDTH-1:0] addr,
        input logic [WIDTH-1:0] wdata,
        output logic [WIDTH-1:0] rdata
    );
    
    logic [WIDTH-1:0] dmem [0:DEPTH-1]; 
    
    assign rdata = dmem[addr[WIDTH-1:2]]; // word-aligned
    
    always_ff @(posedge clk, negedge reset_n) begin
        if (!reset_n) begin
            for (int i = 0; i < DEPTH; i++)
                dmem[i] <= 0;
        end else if (mem_write)
            dmem[addr[WIDTH-1:2]] <= wdata; // word-aligned
    end
    
endmodule
