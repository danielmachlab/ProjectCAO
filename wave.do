onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sisc_tb/uut/u2/present_state
add wave -noupdate /sisc_tb/uut/u2/clk
add wave -noupdate /sisc_tb/uut/u2/rst_f
add wave -noupdate /sisc_tb/uut/instr
add wave -noupdate /sisc_tb/uut/u7/pc_out
add wave -noupdate {/sisc_tb/uut/u5/ram_array[5]}
add wave -noupdate {/sisc_tb/uut/u5/ram_array[4]}
add wave -noupdate {/sisc_tb/uut/u5/ram_array[3]}
add wave -noupdate {/sisc_tb/uut/u5/ram_array[2]}
add wave -noupdate {/sisc_tb/uut/u5/ram_array[1]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {1 ns}
