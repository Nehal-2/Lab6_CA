`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2024 03:17:07 PM
// Design Name: 
// Module Name: data_path
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


module data_path(
    input logic clk,
    input logic reset_n,
    input logic reg_write,
    input logic alu_src,
    input logic [3:0] alu_ctrl,
    input logic branch,
    input logic mem_write,
    input logic memtoreg
    
    );
    localparam WIDTH = 32;
    localparam INST_DEPTH = 256;
    localparam DATA_DEPTH = 1024;
    
    // PROGRAM COUNTER
    logic [WIDTH-1:0] next_pc, current_pc, pc_plus_4;
    
    program_counter #(.n(WIDTH)) pc_inst(
        .clk(clk),
        .reset_n(reset_n),
        .data_in(next_pc),
        .data_o(current_pc)
        );
    
    assign pc_plus_4 = current_pc + 4;
    
    // INSTRUCTION MEMORY
    logic [WIDTH-1:0] inst;
        
    inst_mem #(.ADDR_WIDTH(WIDTH),
        .INST_WIDTH(WIDTH),
        .DEPTH(INST_DEPTH)
    ) inst_mem_inst(
        .addr(current_pc), 
        .inst(inst)
    );
    
    // REGISTER FILE
    logic [$clog2(WIDTH):0] rs1, rs2, rd;
    logic [WIDTH-1:0] reg_rdata1, reg_rdata2, reg_wdata;
    
    assign rs1 = inst[19:15];
    assign rs2 = inst[24:20];
    assign rd = inst[11:7];
    
    reg_file #(.WIDTH(WIDTH)) reg_file_inst(
        .clk(clk),
        .reset_n(reset_n),
        .reg_write(reg_write),
        .raddr1(rs1),
        .raddr2(rs2),
        .waddr(rd),
        .wdata(reg_wdata),
        .rdata1(reg_rdata1),
        .rdata2(reg_rdata2)
    );
    
    // IMMEDIATE GENERATOR
    logic [31:0] imm;
    
    imm_gen imm_gen_inst(
    .inst(inst),
    .imm(imm)
    );
    
    // ALU
    logic [WIDTH-1:0] alu_op2, alu_result;
    logic zero;
    
    assign alu_op2 = alu_src ? imm : reg_rdata2;
    
    alu #(.WIDTH(WIDTH)) alu_inst(
        .op1(reg_rdata1),
        .op2(alu_op2),
        .alu_ctrl(alu_ctrl),
        .alu_result(alu_result),
        .zero(zero)
    );
    
    // DATA MEMORY
    logic [WIDTH-1:0] mem_rdata;
    
    data_mem #(.WIDTH(WIDTH), 
        .DEPTH(DATA_DEPTH)
        ) data_mem_inst(
        .clk(clk),
        .reset_n(reset_n),
        .mem_write(mem_write),
        .addr(alu_result),
        .wdata(reg_rdata2),
        .rdata(mem_rdata)
    ); 
    
    assign reg_wdata = memtoreg ? mem_rdata : alu_result;
    
    // JUMP LOGIC
    logic [WIDTH-1:0] pc_jump;
    logic pc_sel;
    
    assign pc_jump = current_pc + imm;
    assign pc_sel = branch & zero;
    assign next_pc = pc_sel ? pc_jump : pc_plus_4;
    
endmodule
