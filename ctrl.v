// ECE:3350 SISC computer project
// finite state machine

`timescale 1ns/100ps

module ctrl (clk, rst_f, opcode, mm, stat, rf_we, alu_op, wb_sel, br_sel, pc_rst, pc_write, pc_sel, rb_sel, ir_load,dm_we);

  // Declare the ports listed above as inputs or outputs
  input clk, rst_f;
  input [3:0] opcode, mm, stat;
  output rf_we, wb_sel, alu_op, br_sel, pc_rst, pc_write, pc_sel, rb_sel, ir_load, dm_we;

  reg rf_we, wb_sel, pc_write, pc_sel, pc_rst, ir_load, br_sel, dm_we;
  reg [1:0] alu_op;
  
  // states
  parameter start0 = 0, start1 = 1, fetch = 2, decode = 3, execute = 4, mem = 5, writeback = 6;
   
  // opcodes
  parameter NOOP = 0, LOD = 1, STR = 2, SWP = 3, BRA = 4, BRR = 5, BNE = 6, BNR = 7, ALU_OP = 8, HLT=15;
	
  // addressing modes
  parameter am_imm = 8;

  // state registers
  reg [2:0]  present_state, next_state;

  initial
    present_state = start0;

  /* TODO: Write a sequential procedure that progresses the fsm to the next state on the
       positive edge of the clock, OR resets the state to 'start1' on the negative edge
       of rst_f. Notice that the computer is reset when rst_f is low, not high. 
	TODO: Write a combination procedure that determines the next state of the fsm. */


  always @(present_state, rst_f)
  begin 
    if (rst_f == 0)
      present_state <= start1;
    else
    begin
      case (present_state)
        start0: 
	  next_state <= start1;
        start1: 
	  next_state <= fetch;
        fetch: 
	  next_state <= decode;
        decode: 
	  next_state <= execute;
        execute: 
	  next_state <= mem;
        mem: 
	  next_state <= writeback;
        writeback: 
	  next_state <= fetch;
      endcase
    end
  end

  always @(posedge clk, negedge rst_f)
  begin
    if (rst_f == 0)
      present_state <= start1;
    else 
      present_state <= next_state;
  end
 
  /* TODO: Generate outputs based on the FSM states and inputs. For Parts 2, 3 and 4 you will
       add the new control signals here. */
  always @ (present_state,opcode,mm)
  begin
    rf_we = 1'b0;
    alu_op = 2'b10;
    wb_sel = 1'b0;
    pc_write = 1'b0;
    pc_sel = 1'b0; //arbitrary
    pc_rst = 1'b0; //arbitrary
    ir_load = 1'b0;
    dm_we = 1'b0;
    case(present_state)
      fetch: //done
      begin
        ir_load = 1;
	pc_write = 1;
	//increment PC in fetch
        pc_sel = 0;   
      end

      decode:
      begin
	pc_sel = 1'b1;
	//could be in execute.  Here because nothing else happens here.
	if(opcode == BRA || opcode == BNE)//absolute
	   br_sel = 1;
	if(opcode == BRR || opcode == BNR)
	   br_sel = 0;
	if((opcode == BRA || opcode == BRR) && ((mm & stat) != 0))
	   pc_write = 1;
	if((opcode == BNE || opcode == BNR) && ((mm & stat) == 0))
	   pc_write = 1;
        
      end

      start1:
	      pc_rst = 1;

      execute:
      begin
        //if opcode is 8 and mm is 8 alu_op bit zero is 1
        if(opcode == 8 && mm == 8)
          alu_op[0] = 1'b1;
        
        //if oppcode is 8 then alu_op bit 1 is zero
        if(opcode == 8)
          alu_op[1] = 1'b0;
      end
		
      mem://make sure output of alu immedeate or not so at the beginning of writeback
      begin
        dm_we = 1;
       
        // 01 or 02 + 08  mmselect = 0
        // 01 or 02 + 00 mmselect = 1
        if((opcode == 1 || opcode == 2) && mm == 8)          
          alu_op[0] = 1'b0;
        else if (mm == 0)
          alu_op[0] = 1'b1;
          
       
          
        //if opcode is 8 and mm is 8 alu_op bit zero is 1
        if(opcode == 8 && mm == 8)
          alu_op[0] = 1'b1;
      end

      writeback:
      begin
        dm_we = 0;
        //write back to the register file
        //wher rfwe is set to 1 if opcode is 8
        if(opcode == 8)
          rf_we = 1;
	
      end
    endcase
  end

  // Halt on HLT instruction
  
  always @ (opcode)
  begin
    if (opcode == HLT)
    begin 
      #5 $display ("Halt."); //Delay 5 ns so $monitor will print the halt instruction
      $stop;
    end
  end

endmodule
