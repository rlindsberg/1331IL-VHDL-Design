add wave -position insertpoint sim:/tb_ar4003/*
add wave -position insertpoint sim:/tb_ar4003/Pocesor_inst/Ctl_inst/*
add wave -position insertpoint sim:/tb_ar4003/Pocesor_inst/ALU_inst/*
add wave -position insertpoint sim:/tb_ar4003/Pocesor_inst/reg_file_inst/*
add wave -position insertpoint sim:/tb_ar4003/Pocesor_inst/MUX_inst/*
add wave -position insertpoint sim:/tb_ar4003/Pocesor_inst/buffer_inst/*
add wave -position insertpoint  \
sim:/tb_ar4003/clk
force -freeze sim:/tb_ar4003/clk 1 0, 0 {2500 ps} -r 5000
