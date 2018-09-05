transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/gnmn/Documents/skola/IL1331/1331IL-VHDL-Design/alabb1/Ripple_adder/b4_ripple_adder.vhd}
vcom -93 -work work {/home/gnmn/Documents/skola/IL1331/1331IL-VHDL-Design/alabb1/Full_adder/full_adder.vhd}
vcom -93 -work work {/home/gnmn/Documents/skola/IL1331/1331IL-VHDL-Design/alabb1/Adder8/tb_Adder8.vhd}
vcom -93 -work work {/home/gnmn/Documents/skola/IL1331/1331IL-VHDL-Design/alabb1/Adder8/Adder8.vhd}

vcom -93 -work work {/home/gnmn/Documents/skola/IL1331/1331IL-VHDL-Design/alabb1/Adder8/tb_Adder8.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneiv_hssi -L cycloneiv_pcie_hip -L cycloneiv -L rtl_work -L work -voptargs="+acc"  tb_Adder8

add wave *
view structure
view signals
run -all
