`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2024 12:47:43 PM
// Design Name: 
// Module Name: main_control_tb
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


module main_control_tb;
    logic [6:0] opcode;
    logic branch, mem_write, memtoreg, reg_write, alu_src;
    logic [1:0] alu_op;
    
    main_control dut(.*);
    
    initial begin
        opcode = 7'b0110011; #10 // R-type instructions
        opcode = 7'b0010011; #10 // I-type instructions
        opcode = 7'b0000011; #10 // I*-type instructions (load)
        opcode = 7'b1100011; #10 // B-type instructions (beq)
        opcode = 7'b0100011; #10 // S-type instructions
        opcode = 7'b0100011; #10 // Unidentified opcode
        $finish;
    end
endmodule
