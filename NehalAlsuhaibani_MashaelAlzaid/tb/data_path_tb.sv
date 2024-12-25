`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2024 04:41:10 PM
// Design Name: 
// Module Name: data_path_tb
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


module data_path_tb;
    logic clk, reset_n, reg_write, alu_src, branch, mem_write, memtoreg;
    logic [3:0] alu_ctrl;
    
    data_path dut (.*);
    
    // Generate clock signal
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns clock period
    end
    
    initial begin
        reset_n = 0; #10 reset_n = 1; 
        
        // Load 10 into t0 ( addi t0, x0, 10)
        reg_write = 1'b1; // Need to write to register file (to the t0 register)
        alu_src = 1'b1; // Need to select the second operand from Imm value
        mem_write = 1'b0; // This is not a store instruction
        alu_ctrl = 4'b0000; // ALU should perform Addition (addi t0, x0, 10)
        memtoreg = 1'b0; // It's not a lw instruction where data from Mem will go to reg
        branch = 1'b0; // It's not a branch instruction
        #10;
        // Load 5 into t1 ( addi t1, x0, 5)
        // Note that control signal for this and above insturction will be save, only the rd and immediate value will change
        // These value's are not contorl by control so they are not input of data path
        // These value's will come from instruction directly
        reg_write = 1'b1; // Need to write to register file (to the t0 register)
        alu_src = 1'b1; // Need to select the second operand from Imm value
        mem_write = 1'b0; // This is not a store instruction
        alu_ctrl = 4'b0000; // ALU should perform Addition (addi t0, x0, 10)
        memtoreg = 1'b0; // It's not a lw instruction where data from Mem will go to reg
        branch = 1'b0; // It's not a branch instruction
        #10;
        // Add t2 = t0 + t1 ( add t2, t1, t0)
        reg_write = 1'b1; // Need to write to register file (to the t0 register)
        alu_src = 1'b0; // Second operand is not Imm value
        mem_write = 1'b0; // This is not a store instruction
        alu_ctrl = 4'b0000; // ALU should perform Addition (addi t0, x0, 10)
        memtoreg = 1'b0; // It's not a lw instruction where data from Mem will go to reg
        branch = 1'b0; // It's not a branch instruction
        #10;
        $finish;
    end
    
endmodule
