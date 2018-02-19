// ECE:3350 SISC processor project
// main SISC module, part 1

`timescale 1ns/100ps  

module sisc (clk, rst_f, ir);

  input clk, rst_f;
  input [31:0] ir;

// declare all internal wires here
  wire [31:0] rsa, rsb, alu_result, rf_write_data
  wire [15:0] 
  



// component instantiation goes here
  alu u1(clk, rsa, rsb, imm, alu_OP, alu_result, stat, stat_en); //taking alu def and naming it u1
  ctrl u2(clk, rst_f, opcode, mm, stat, rf_we, alu_op, wb_sel);
  mux4 u3(in_a, in_b, sel, out);
  mux32 u4(in_a, in_b, sel, out);
  rf u5(clk, read_rega, read_regb, write_reg, rf_write_data, rf_we, rsa, rsb);
  statreg u5(clk, in, enable, out);


  initial
  
// put a $monitor statement here.  



endmodule


