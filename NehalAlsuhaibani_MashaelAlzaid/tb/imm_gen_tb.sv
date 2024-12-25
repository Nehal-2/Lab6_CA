`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2024 02:15:33 PM
// Design Name: 
// Module Name: imm_gen_tb
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


module imm_gen_tb;
    logic [31:0] inst, imm;
    
    imm_gen uut (.*);
    
    initial begin
        // Test I*- & I-type instructions
        inst = 32'h00052503; #10 // lw x10 0(x10) 
        inst = 32'h00050593; #10 // addi x11 x10 0
        
        // Test S-type instructions
        inst = 32'h00112223; #10 // sw x1 4(x2)
        
        // Test B-type instructions
        inst = 32'h00500863; #10 // beq x0 x5 16
        
        $finish;
    end
    
endmodule
