transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/Sign_Ext_6.vhd}
vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/Shifter_7bits.vhd}
vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/Register_File.vhd}
vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/Register_16.vhd}
vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/Register_1.vhd}
vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/MUX_5_to_1.vhd}
vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/MUX_4_to_1.vhd}
vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/MUX_3_TO_1.vhd}
vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/MUX_1_TO_5.vhd}
vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/MUX_1_TO_3.vhd}
vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/mux81.vhd}
vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/Memory.vhd}
vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/Incrementer.vhd}
vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/DUT.vhd}
vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/Dataflow.vhd}
vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/CPU.vhd}
vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/Controller.vhd}
vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/ALU.vhd}

vcom -93 -work work {C:/Users/SHAMBHAVI SHANKER/Desktop/214project/Testbench.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L fiftyfivenm -L rtl_work -L work -voptargs="+acc"  Testbench

add wave *
view structure
view signals
run -all
