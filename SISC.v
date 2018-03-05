// ECE:3350 SISC processor project
// main SISC module, part 1

`timescale 1ns/100ps  

module sisc (clk, rst_f, ir);

  input clk, rst_f;
  input [31:0] ir;


// declare all internal wires here
  wire [31:0] rsa, rsb, alu_result, out_32;
  wire [3:0]  sr_out, sr_in, out_4; // now it's correct
  wire [1:0]  alu_op;
  wire [15:0] pc_out, br_addr;
  wire        wb_sel, rf_we, sr_enable, sel, br_sel, pc_rst, pc_write, pc_sel, rb_sel, ir_load;
  



// component instantiation goes here
  alu u1(clk, rsa, rsb, ir[15:0]/*imm*/, alu_op, alu_result, /*stat-double check*/ sr_in, sr_enable); //taking alu def and naming it u1
  ctrl u2(clk, rst_f, /*opcode*/ir[31:28], /*mm*/ir[27:24], /*stat*/ sr_out, rf_we, alu_op, wb_sel, br_sel, pc_rst, pc_write, pc_sel, rb_sel, ir_load);
  mux4 u3(/*in_a*/ ir[15:12], /*in_b*/ ir[23:20], rb_sel, out_4);
  mux32 u4(/*in_a*/ 32'h00000000, /*in_b*/ alu_result, sel, out_32);
  rf u5(clk, /*read_rega*/ir[19:16], /*read_regb*/ ir[15:12], /*write_reg*/ir[23:20], out_32, rf_we, rsa, rsb);
  statreg u6(clk, sr_in, sr_enable, sr_out);

// part 2 instantiation
  pc u7(clk, br_addr, pc_sel, pc_write, pc_rst, pc_out);
  ir u8(clk, ir_load, read_data, ir[31:0]/*instr*/);
  im u9(/*read_addr*/pc_out, read_data);
  br u10(pc_out, ir[15:0]/*imm*/, br_sel, br_addr);



 
  
// put a $monitor statement here.  
  initial
  begin
     $monitor("IR=%h", ir);
     $monitor("ALU_OP=%h",alu_op);
     $monitor("WB_SEL=%h",wb_sel);
     $monitor("RF_WE=%h",rf_we);
  end
 
endmodule


