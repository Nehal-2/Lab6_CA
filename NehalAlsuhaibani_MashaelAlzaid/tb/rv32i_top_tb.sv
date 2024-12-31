`timescale 1ns / 1ps

module rv32i_top_tb;

    // Clock and Reset
    logic clk;
    logic reset_n;

    rv32i_top dut (
        .clk(clk),
        .reset_n(reset_n)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        reset_n = 0;           
        #20;                  
        reset_n = 1;
        #20          
//15-19, 20-24
        // Test Case : Simulate a branch instruction (beq t1, t2, offset)
        dut.dp.instruction = 32'b00000000001000001000000000000011;
        #20; // Wait for simulation to propagate


        // Test Case 1: Simulate a sample R-type instruction (add t1, t2, t3)
        dut.dp.instruction = 32'b00000000001100100001000110110011;
        #20; // Wait for simulation to propagate

        if (dut.opcode !== 7'b0110011) $display("Test 1 Failed: Incorrect Opcode");
        if (dut.func3 !== 3'b001) $display("Test 1 Failed: Incorrect Funct3");
        if (dut.func7 !== 1'b0) $display("Test 1 Failed: Incorrect Funct7");
        if (dut.alu_ctrl !== 4'b0010) $display("Test 1 Failed: Incorrect ALU Control");
        if (dut.reg_write !== 1'b1) $display("Test 1 Failed: Reg Write Not Enabled");

        // Test Case 2: Simulate a sample I-type instruction (addi t1, t2, 10)
        dut.dp.instruction = 32'b00000000001000101000000100010011;
        #20; 
        

        if (dut.opcode !== 7'b0010011) $display("Test 2 Failed: Incorrect Opcode");
        if (dut.func3 !== 3'b000) $display("Test 2 Failed: Incorrect Funct3");
        if (dut.func7 !== 1'b0) $display("Test 2 Failed: Incorrect Funct7");
        if (dut.alu_ctrl !== 4'b0010) $display("Test 2 Failed: Incorrect ALU Control");
        if (dut.reg_write !== 1'b1) $display("Test 2 Failed: Reg Write Not Enabled");

        // Test Case 3: Simulate a branch instruction (beq t1, t2, offset)
        dut.dp.instruction = 32'b00000000001000001000000001100011;
        #20; // Wait for simulation to propagate


        if (dut.opcode !== 7'b1100011) $display("Test 3 Failed: Incorrect Opcode");
        if (dut.func3 !== 3'b000) $display("Test 3 Failed: Incorrect Funct3");
        if (dut.func7 !== 1'b0) $display("Test 3 Failed: Incorrect Funct7");
        if (dut.branch !== 1'b1) $display("Test 3 Failed: Branch Signal Not Asserted");

        // End Simulation
        $display("All tests completed.");
        $stop;
    end

endmodule
