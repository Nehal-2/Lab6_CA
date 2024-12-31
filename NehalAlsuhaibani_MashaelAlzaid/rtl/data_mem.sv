`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2024 05:40:54 PM
// Design Name: 
// Module Name: data_mem
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


module data_mem #(
    parameter WIDTH = 32,
    parameter DEPTH = 1024
)(
        input logic clk,
        input logic reset_n,
        input logic mem_write,
        input logic [WIDTH-1:0] addr,
        input logic [WIDTH-1:0] wdata,
        output logic [WIDTH-1:0] rdata
    );
    
   logic [3:0] func3= addr[14:12];
   logic func7 = addr[30];

//load  block  
//input addr_lsb = addr[3:0];
// store block
//module store_mem(
//    input logic [31:0] memory_word,
//    input logic [3:0] addr_lsb,
//    input logic [2:0] funct3,
//    input logic .wEn(mem_write),
//    input logic [31:0] addre,
//    output logic [31:0] dmem [0:1023]
//);


//memory block
    
    logic [WIDTH-1:0] dmem [0:DEPTH-1]; 
    
    assign rdata = dmem[addr[WIDTH-1:2]]; // word-aligned
    
    always_ff @(posedge clk, negedge reset_n) begin
        if (!reset_n) begin
            for (int i = 0; i < DEPTH; i++)
                dmem[i] <= 0;
        end else if (mem_write)
            dmem[addr[WIDTH-1:2]] <= wdata; // word-aligned
    end
 // load block
 
  
//  load_mem LM(
//.memory_word(dmem)
//, .addr_lsb(addr_lsb)
//,input logic  [2:0] funct3 //?? wheres the instruction?
//,.load_data(???  /// how is the connection should be?

//);
    
    
endmodule
