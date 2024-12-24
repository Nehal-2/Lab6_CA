`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2024 05:23:13 PM
// Design Name: 
// Module Name: alu_tb
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


module alu_tb;
    localparam WIDTH = 32;
    
    logic [WIDTH-1:0] op1, op2, alu_result;
    logic [3:0] alu_ctrl;
    logic zero;
    
    alu #(.WIDTH(WIDTH)) uut (.*);
    
    initial begin
        // Initialize inputs
        op1 = 0; op2 = 0; alu_ctrl = 0;

        // Display header
        $display("Time\t op1\t\t op2\t\t alu_ctrl\t alu_result\t zero");
        $display("-------------------------------------------------------------");

        // Test ADD
        #10 op1 = 32'h00000005; op2 = 32'h00000003; alu_ctrl = 4'b0000;
        #10 $display("%0t\t %h\t %h\t %b\t %h\t %b", $time, op1, op2, alu_ctrl, alu_result, zero);

        // Test SUB
        #10 alu_ctrl = 4'b1000;
        #10 $display("%0t\t %h\t %h\t %b\t %h\t %b", $time, op1, op2, alu_ctrl, alu_result, zero);

        // Test AND
        #10 alu_ctrl = 4'b0111;
        #10 $display("%0t\t %h\t %h\t %b\t %h\t %b", $time, op1, op2, alu_ctrl, alu_result, zero);

        // Test OR
        #10 alu_ctrl = 4'b0110;
        #10 $display("%0t\t %h\t %h\t %b\t %h\t %b", $time, op1, op2, alu_ctrl, alu_result, zero);

        // Test XOR
        #10 alu_ctrl = 4'b0100;
        #10 $display("%0t\t %h\t %h\t %b\t %h\t %b", $time, op1, op2, alu_ctrl, alu_result, zero);

        // Test SLL
        #10 op1 = 32'h00000001; op2 = 32'h00000002; alu_ctrl = 4'b0001;
        #10 $display("%0t\t %h\t %h\t %b\t %h\t %b", $time, op1, op2, alu_ctrl, alu_result, zero);

        // Test SRL
        #10 op1 = 32'h00000010; op2 = 32'h00000002; alu_ctrl = 4'b0101;
        #10 $display("%0t\t %h\t %h\t %b\t %h\t %b", $time, op1, op2, alu_ctrl, alu_result, zero);

        // Test SRA
        #10 op1 = 32'h80000000; op2 = 32'h00000002; alu_ctrl = 4'b1101;
        #10 $display("%0t\t %h\t %h\t %b\t %h\t %b", $time, op1, op2, alu_ctrl, alu_result, zero);

        // Test SLT
        #10 op1 = 32'hFFFFFFFF; op2 = 32'h00000001; alu_ctrl = 4'b0010;
        #10 $display("%0t\t %h\t %h\t %b\t %h\t %b", $time, op1, op2, alu_ctrl, alu_result, zero);

        // Test SLTU
        #10 op1 = 32'h00000001; op2 = 32'hFFFFFFFF; alu_ctrl = 4'b0011;
        #10 $display("%0t\t %h\t %h\t %b\t %h\t %b", $time, op1, op2, alu_ctrl, alu_result, zero);

        // Test default case
        #10 alu_ctrl = 4'b1111;
        #10 $display("%0t\t %h\t %h\t %b\t %h\t %b", $time, op1, op2, alu_ctrl, alu_result, zero);

        // Finish simulation
        #10 $finish;
    end
    
endmodule
