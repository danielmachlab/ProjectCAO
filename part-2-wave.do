onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sisc_tb/uut/u10/pc_inc
add wave -noupdate /sisc_tb/uut/u10/imm
add wave -noupdate /sisc_tb/uut/u10/br_sel
add wave -noupdate /sisc_tb/uut/u10/br_addr
add wave -noupdate /sisc_tb/uut/u8/ir_load
add wave -noupdate /sisc_tb/uut/u8/instr
add wave -noupdate /sisc_tb/uut/u7/pc_out
add wave -noupdate /sisc_tb/uut/u6/clk
add wave -noupdate /sisc_tb/uut/u2/clk
add wave -noupdate /sisc_tb/uut/u2/rst_f
add wave -noupdate /sisc_tb/uut/u2/opcode
add wave -noupdate /sisc_tb/uut/u2/mm
add wave -noupdate /sisc_tb/uut/u2/stat
add wave -noupdate /sisc_tb/uut/u2/rf_we
add wave -noupdate /sisc_tb/uut/u2/wb_sel
add wave -noupdate /sisc_tb/uut/u2/alu_op
add wave -noupdate /sisc_tb/uut/u2/br_sel
add wave -noupdate /sisc_tb/uut/u2/pc_rst
add wave -noupdate /sisc_tb/uut/u2/pc_write
add wave -noupdate /sisc_tb/uut/u2/pc_sel
add wave -noupdate /sisc_tb/uut/u2/rb_sel
add wave -noupdate /sisc_tb/uut/u2/ir_load
add wave -noupdate /sisc_tb/uut/u2/present_state
add wave -noupdate /sisc_tb/uut/u2/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {783344100 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 228
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {783344100 ps} {783344800 ps}
