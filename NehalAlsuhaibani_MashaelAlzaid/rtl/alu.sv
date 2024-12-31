`timescale 1ns / 1ps


module alu #(
    parameter WIDTH = 32
)(
        input logic [WIDTH-1:0] op1,
        input logic [WIDTH-1:0] op2,
        input logic [3:0] alu_ctrl,
        output logic [WIDTH-1:0] alu_result,
        output logic zero
    );
    
    always @(*) begin
        case (alu_ctrl)
            4'b0000: alu_result = op1 + op2; // ADD
            4'b1000: alu_result = op1 - op2; // SUB
            4'b0111: alu_result = op1 & op2; // AND
            4'b0110: alu_result = op1 | op2; // OR
            4'b0100: alu_result = op1 ^ op2; // XOR
            4'b0001: alu_result = op1 << op2; // SLL
            4'b0101: alu_result = op1 >> op2; // SRL
            4'b1101: alu_result = $signed(op1) >>> op2; // SRA
            4'b0010: alu_result = ($signed(op1) < $signed(op2)) ? 1 : 0; // SLT
            4'b0011: alu_result = (op1 < op2) ? 1 : 0; // SLTU
             // Immediate operations
            4'b1010: alu_result = op1 + op2; // ADDI (Add Immediate) -> ADD operation
            4'b1011: alu_result = ($signed(op1) < $signed(op2)) ? 1 : 0; // SLTI (Set Less Than Immediate)
            4'b1100: alu_result = (op1 < op2) ? 1 : 0; // SLTIU (Set Less Than Immediate Unsigned)
            4'b1101: alu_result = op1 ^ op2; // XORI (XOR Immediate)
            4'b1110: alu_result = op1 | op2; // ORI (OR Immediate)
            4'b1111: alu_result = op1 & op2; // ANDI (AND Immediate)
            
             default: alu_result = {WIDTH{1'b0}};
        endcase
    end
    
    assign zero = ~|alu_result;
    
endmodule
