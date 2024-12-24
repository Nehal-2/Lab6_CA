`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2024 01:09:28 PM
// Design Name: 
// Module Name: program_counter_tb
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


module program_counter_tb;
    localparam n = 4;
    
    logic clk, reset_n;
    logic [n-1:0] data_in, data_o;
    
    // Instantiate the program counter
    program_counter #(.n(n)) uut (.*);
    
    // Generate clock signal
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end

    // Test sequence
    initial begin
        reset_n = 0;
        #10;
        reset_n = 1;
        for (int i = 0; i < 2**n; i++) begin
            data_in = i;
            #10;
        end
        #100;
        $finish;
    end
    
endmodule
