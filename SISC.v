// ECE:3350 SISC processor project
// main SISC module, part 1

`timescale 1ns/100ps  

module sisc (clk, rst_f);

  input clk, rst_f;

  // declare all internal wires here
  wire [31:0] rsa, rsb, alu_result, out_32, read_data, instr, dm_out;
  wire [3:0]  sr_out, sr_in, out_4, out_42; // now it's correct
  wire [1:0]  alu_op, mm_sel, wb_sel;
  wire [15:0] pc_out, br_addr, mux16_out;
  wire        rf_we, sr_enable, sel, br_sel, pc_rst, pc_write, pc_sel, rb_sel, ir_load,  dm_we, swp_sel;
  
  // component instantiation goes here
  alu u1(clk, rsa, rsb, instr[15:0]/*imm*/, alu_op, alu_result, /*stat-double check*/ sr_in, sr_enable); //taking alu def and naming it u1
  ctrl u2(clk, rst_f, /*opcode*/instr[31:28], /*mm*/instr[27:24], /*stat*/ sr_out, rf_we, alu_op, wb_sel, br_sel, pc_rst, pc_write, pc_sel, rb_sel, ir_load, mm_sel, dm_we,swp_sel);
  mux4 u3(/*in_a*/ instr[15:12], /*in_b*/ instr[23:20], rb_sel, out_4);
  mux32 u4(alu_result, dm_out,rsa, rsb, wb_sel, out_32);
  rf u5(clk, /*read_rega*/instr[19:16], /*read_regb*/ out_4, /*write_reg*/out_42, out_32, rf_we, rsa, rsb);
  statreg u6(clk, sr_in, sr_enable, sr_out);

  // part 2 instantiation
  pc u7(clk, br_addr, pc_sel, pc_write, pc_rst, pc_out);
  ir u8(clk, ir_load, read_data, instr);
  im u9(/*read_addr*/pc_out, read_data);
  br u10(pc_out, instr[15:0]/*imm*/, br_sel, br_addr);

  // part 3 instantiation
  mux16 u11(alu_result[15:0], instr[15:0],rsa[15:0], mm_sel, mux16_out);
  dm u12(mux16_out, mux16_out, rsb, dm_we, dm_out);
  mux4 u13(instr[19:16],instr[23:20] , swp_sel, out_42);

  initial
  begin
    $monitor("ir=%h, pc=%h, r1=%h, r2=%h, r3=%h, r4=%h, r5=%h, alu_op=%h, br_sel=%h, pc_write=%h, pc_sel=%h,dm[8]=%h,dm[9]=%h,mux32[10]=%h, out32 = %h", instr, pc_out, u5.ram_array[1], u5.ram_array[2], u5.ram_array[3], u5.ram_array[4], u5.ram_array[5], alu_op, br_sel, pc_write, pc_sel,u12.ram_array[8],u12.ram_array[9],rsa, out_32); 
  end
 
endmodule


