`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2024 06:39:07 PM
// Design Name: 
// Module Name: main_control
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


module main_control(
    input logic [6:0] opcode,
    output logic branch,
    output logic mem_write,
    output logic memtoreg,
    output logic reg_write,
    output logic alu_src,
    output logic [1:0] alu_op

    );
    
    always_comb begin
        case (opcode)
            7'b0110011 : begin // R-type instructions
                reg_write = 1;
                mem_write = 0;
                memtoreg = 0;
                alu_op = 2'b10;
                alu_src = 0;
                branch = 0;
            end
            7'b0010011: begin // I-type instructions
                reg_write = 1;
                mem_write = 0;
                memtoreg = 0;
                alu_op = 2'b11;
                alu_src = 1;
                branch = 0;
            end
            7'b0000011: begin // I*-type instructions (load)
                reg_write = 1;
                mem_write = 0;
                memtoreg = 1;
                alu_op = 2'b00;
                alu_src = 1;
                branch = 0;
            end
            7'b1100011: begin // B-type instructions (beq)
                reg_write = 0;
                mem_write = 0;
//                memtoreg = 0; // X for now
                alu_op = 2'b01;
                alu_src = 0;
                branch = 1;
            end 
            7'b0100011: begin // S-type instructions
                reg_write = 0;
                mem_write = 1;
//                memtoreg = 0; // X for now
                alu_op = 2'b00;
                alu_src = 1;
                branch = 0;
            end
            default: begin
                reg_write = 0;
                mem_write = 0;
                memtoreg = 0;
                alu_op = 2'b10;
                alu_src = 0;
                branch = 0;
            end
        endcase
    end
endmodule
