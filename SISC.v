// ECE:3350 SISC processor project
// main SISC module, part 1

`timescale 1ns/100ps  

module sisc (clk, rst_f);

  input clk, rst_f;

  // declare all internal wires here
  wire [31:0] rsa, rsb, alu_result, out_32, read_data, instr;
  wire [3:0]  sr_out, sr_in, out_4; // now it's correct
  wire [1:0]  alu_op;
  wire [15:0] pc_out, br_addr,out_16;
  wire        wb_sel, rf_we, sr_enable, sel, br_sel, pc_rst, pc_write, pc_sel, rb_sel, ir_load,dm_we;
  
  // component instantiation goes here
  alu u1(clk, rsa, rsb, instr[15:0]/*imm*/, alu_op, alu_result, /*stat-double check*/ sr_in, sr_enable); //taking alu def and naming it u1
  ctrl u2(clk, rst_f, /*opcode*/instr[31:28], /*mm*/instr[27:24], /*stat*/ sr_out, rf_we, alu_op, wb_sel, br_sel, pc_rst, pc_write, pc_sel, rb_sel, ir_load,dm_we);
  mux4 u3(/*in_a*/ instr[15:12], /*in_b*/ instr[23:20], rb_sel, out_4);
  mux32 u4(/*in_a*/ 32'h00000000, /*in_b*/ alu_result, sel, out_32);
  rf u5(clk, /*read_rega*/instr[19:16], /*read_regb*/ instr[15:12], /*write_reg*/instr[23:20], out_32, rf_we, rsa, rsb);
  statreg u6(clk, sr_in, sr_enable, sr_out);

  // part 2 instantiation
  pc u7(clk, br_addr, pc_sel, pc_write, pc_rst, pc_out);
  ir u8(clk, ir_load, read_data, instr);
  im u9(/*read_addr*/pc_out, read_data);
  br u10(pc_out, instr[15:0]/*imm*/, br_sel, br_addr);

  // part 3 instantiation
  mux16 u11(/*in_a*/instr[15:0],/*in_b*/alu_result,sel,out_16);
  dm u12( out_16,out_16,rsb,dm_we,read_data); 
  // don't think this line is going to work. It needs to take two inputs from mux16 but mux16 only has one output


  // put a $monitor statement here.  
  initial
  begin
    $monitor("ir=%h, pc=%h, r1=%h, r2=%h, r3=%h, r4=%h, r5=%h, alu_op=%h, br_sel=%h, pc_write=%h, pc_sel=%h", instr, pc_out, u5.ram_array[1], u5.ram_array[2], u5.ram_array[3], u5.ram_array[4], u5.ram_array[5], alu_op, br_sel, pc_write, pc_sel); 
  end
 
endmodule


