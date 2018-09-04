transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/rlindsberg/Documents/Github/1331IL-VHDL-Design/labb1/1.2/full_adder.vhd}
vcom -93 -work work {C:/Users/rlindsberg/Documents/Github/1331IL-VHDL-Design/labb1/1.2/b4_ripple_adder.vhd}
vcom -93 -work work {C:/Users/rlindsberg/Documents/Github/1331IL-VHDL-Design/labb1/1.2/tb_b4_ripple_adder.vhd}

vcom -93 -work work {C:/Users/rlindsberg/Documents/Github/1331IL-VHDL-Design/labb1/1.2/tb_b4_ripple_adder.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work -voptargs="+acc"  tb_b4_ripple_adder

add wave *
view structure
view signals
run -all
