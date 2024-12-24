`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2024 02:46:28 PM
// Design Name: 
// Module Name: reg_file_tb
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


module reg_file_tb;
    localparam WIDTH = 32;
    
    logic clk, reset_n, reg_write; 
    logic [$clog2(WIDTH)-1:0] raddr1, raddr2,  waddr;
    logic [WIDTH-1:0] wdata, rdata1, rdata2;
    
    reg_file #(.WIDTH(WIDTH)) uut (.*);
    
    // Generate clock signal
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Toggle clock every 5 time units
    end
    
    // Apply stimulus
    initial begin
        reset_n = 0; #10; reset_n = 1;
        reg_write = 1; waddr = 5'b00000 ; wdata = 32'h01234567; #10;
                       waddr = 5'b00001 ; wdata = 32'h76543210; #10;
                       waddr = 5'b00010 ; wdata = 32'h89ABCDEF; #10;
                       waddr = 5'b00011 ; wdata = 32'hFEDCBA98; #10;
                       waddr = 5'b00100 ; wdata = 32'hFF00FF00; #10;
                       waddr = 5'b00101 ; wdata = 32'h00FF00FF; #10;
                       waddr = 5'b00110 ; wdata = 32'h10000000; #10;
                       waddr = 5'b00111 ; wdata = 32'h10101010; #10;
                       waddr = 5'b01000 ; wdata = 32'h01010101; #10;
                       waddr = 5'b11111 ; wdata = 32'hFFFFFFFF; #10;
        reg_write = 0; #10;               
        raddr1 = 5'b00000; raddr2 = 5'b00001; #10;              
        raddr1 = 5'b00010; raddr2 = 5'b00011; #10;               
        raddr1 = 5'b00100; raddr2 = 5'b00101; #10;
        raddr1 = 5'b00110; raddr2 = 5'b00111; #10;
        raddr1 = 5'b01000; raddr2 = 5'b11111; #10;
        
        $finish;  // End simulation
        
    end 
    
endmodule
