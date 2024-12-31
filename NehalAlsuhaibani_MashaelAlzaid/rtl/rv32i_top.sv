`timescale 1ns / 1ps

module rv32i_top(
input logic clk,  
input logic reset_n
    );
    localparam WIDTH = 32;
    logic [WIDTH-1:0] instruction;     // Fetched instruction from data_path
    logic [6:0] opcode;          
    logic [2:0] func3;          
    logic func7;                 // 5th bit of the Func7 field
    logic branch;
    logic mem_write;
    logic memtoreg;
    logic reg_write;
    logic alu_src;
    logic [1:0] alu_op;
    logic [3:0] alu_ctrl; 
        
    
    data_path #(.WIDTH(WIDTH)) dp(
    .clk(clk),
    .reset_n(reset_n),
    .reg_write(reg_write),
    .alu_src(alu_src),
    .alu_ctrl(alu_ctrl),
    .branch(branch),
    .mem_write(mem_write),
    .memtoreg(memtoreg),
    .instruction(instruction) );
    
    
    assign opcode = instruction[6:0];
    assign func3 = instruction[14:12];
    assign func7 = instruction[30];

    control_unit cu(
        .opcode(opcode),
        .func7(func7),//
        .func3(func3),//
        .reg_write(reg_write),
        .mem_write(mem_write),
        .mem_to_reg(memtoreg),
        .alu_op(alu_op),
        .alu_src(alu_src),
        .branch(branch),
        .alu_ctrl(alu_ctrl)
        );

    
    endmodule
