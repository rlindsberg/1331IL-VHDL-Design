transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/gnmn/Documents/IL1331/1331IL-VHDL-Design/alabb1/full_adder.vhd}

