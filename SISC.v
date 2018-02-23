// ECE:3350 SISC processor project
// main SISC module, part 1

`timescale 1ns/100ps  

module sisc (clk, rst_f, ir);

  input clk, rst_f;
  input [31:0] ir;

// declare all internal wires here
  wire [31:0] rsa, rsb, alu_result, rf_write_data;
  wire [15:0] imm;
  wire [3:0]  sr_out, sr_in;//correct
  wire [1:0]  alu_op;
  wire        wb_sel, rf_we, sr_enable ;
  



// component instantiation goes here
  alu u1(clk, rsa, rsb, imm, alu_op, alu_result, /*stat-double check*/ sr_in, sr_enable); //taking alu def and naming it u1
  ctrl u2(clk, rst_f, /*opcode*/ir[31:28], /*mm*/ir[27:24], /*stat*/ sr_out, rf_we, alu_op, wb_sel);
  mux4 u3(in_a, in_b, sel, out);
  mux32 u4(in_a, in_b, sel, out);
  rf u5(clk, /*read_rega*/ir[19:16], /*read_regb*/ ir[15:12], /*write_reg*/ir[23:20], rf_write_data, rf_we, rsa, rsb);
  statreg u5(clk, sr_in, sr_enable, sr_out);


  initial
  
// put a $monitor statement here.  



endmodule


