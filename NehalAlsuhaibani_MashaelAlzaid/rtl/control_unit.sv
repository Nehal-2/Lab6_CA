`timescale 1ns / 1ps
    
  
module control_unit(
input logic [6:0]opcode,//: The 7-bit opcode from the instruction.
input logic func7,//: The 5th bit of the fun7 field from the instruction. #NOTE IS THIS FUN7 OR FUN7 BIT5??
input logic [2:0]func3, //: The 3-bit fun3 field from the instruction.

output logic reg_write,//: Enables writing data to a register.
output logic mem_write,//: Enables writing data to memory.
output logic mem_to_reg,//: Selects data source for writing back to the register.
output logic [1:0]alu_op,//: Control signal passed to the ALU Control Unit.
output logic alu_src,//: Selects ALU operand source (immediate or register).
output logic branch,//: Indicates branch instructions.
output logic [3:0]alu_ctrl//: The 4-bit control signal for ALU operations    );
    );
        
    main_control mc(        
        .opcode(opcode),            
        .branch(branch),            
        .mem_write(mem_write),      
        .memtoreg(mem_to_reg),      
        .reg_write(reg_write),      
        .alu_src(alu_src),        
        .alu_op(alu_op)  );         
   
    
    alu_control aluc(
        .alu_op(alu_op),               // Input: ALU operation signal
        .func7(func7),
        .func3(func3),
        .alu_ctrl(alu_ctrl)            // Output: ALU control signal    
    );
endmodule
