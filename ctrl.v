// ECE:3350 SISC computer project
// finite state machine

`timescale 1ns/100ps

module ctrl (clk, rst_f, opcode, mm, stat, rf_we, alu_op, wb_sel);

  // Declare the ports listed above as inputs or outputs
  input clk, rst_f, opcode, mm, stat;
  output rf_we, alu_op, wb_sel;
  
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
       of rst_f. Notice that the computer is reset when rst_f is low, not high. */
  always @(present_state, RST_F)
  begin 
    if (RST_F == 0)
      present_state <= start1;
    else
      case (present_state)
        start0: next_state <= start1;
        start1: next_state <= fetch;
        fetch: next_state <= decode;
        decode: next_state <= execute;
        execute: next_state <= mem;
        mem: next_state <= writeback;
        writeback: next_state <= fetch;
  end

  
  /* TODO: Write a combination procedure that determines the next state of the fsm. */



  /* TODO: Generate outputs based on the FSM states and inputs. For Parts 2, 3 and 4 you will
       add the new control signals here. */


// I am not sure which on the above this is but I am just adding it 
// This is from class but I don't know where 'update' is coming from
  always @ (present_state,update,mm)
  begin
  	if_we <= 1b0;
	alu_up <= 2b10;
	wb_sel <= 1b0;
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
