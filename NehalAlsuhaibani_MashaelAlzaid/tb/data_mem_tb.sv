`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2024 06:08:14 PM
// Design Name: 
// Module Name: data_mem_tb
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


module data_mem_tb;
    localparam WIDTH = 32;
    localparam DEPTH = 1024;
    
    logic clk, reset_n, mem_write;
    logic [WIDTH-1:0] addr, wdata, rdata;
    
    data_mem #(.WIDTH(WIDTH), .DEPTH(DEPTH)) uut (.*); 

    // Generate clock signal
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle clock every 5 time units
    end
    
    // Test procedure
    initial begin
        // Initialize inputs
        reset_n = 0;
        mem_write = 0;
        addr = 0;
        wdata = 0;

        // Release reset
        #10 reset_n = 1;

        // Test case 1: Write and Read at address 0
        addr = 32'h00000000;
        wdata = 32'h89ABCDEF;
        mem_write = 1; // Enable write
        #10;
        mem_write = 0; // Disable write
        #10;
        $display("Test 1 - Read data: %h (Expected: 89ABCDEF)", rdata);

        // Test case 2: Write and Read at address 4
        addr = 32'h00000004;
        wdata = 32'hCAFECAFE;
        mem_write = 1; // Enable write
        #10;
        mem_write = 0; // Disable write
        #10;
        $display("Test 2 - Read data: %h (Expected: CAFECAFE)", rdata);

        // Test case 3: Write and Read at unaligned address (undefined behavior)
        addr = 32'h00000002;
        wdata = 32'hBAD00BAD;
        mem_write = 1; // Enable write
        #10;
        mem_write = 0; // Disable write
        #10;
        $display("Test 3 - Read data: %h (Undefined behavior expected)", rdata);

        // Test case 4: Check reset behavior
        reset_n = 0;
        #10;
        reset_n = 1;
        #10;
        addr = 32'h00000000;
        $display("Test 4 - Read data after reset: %h (Expected: Undefined or Zero)", rdata);

        // End simulation
        $stop;
    end
    
endmodule
