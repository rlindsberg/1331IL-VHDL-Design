add wave -position insertpoint sim:/tb_controller/*
add wave -position insertpoint  \
sim:/tb_controller/CTR/adr
add wave -position insertpoint  \
sim:/tb_controller/CTR/data
add wave -position insertpoint  \
sim:/tb_controller/CTR/state
add wave -position insertpoint  \
sim:/tb_controller/CTR/next_state
add wave -position insertpoint  \
sim:/tb_controller/CTR/pc
add wave -position insertpoint  \
sim:/tb_controller/CTR/next_pc
add wave -position insertpoint  \
sim:/tb_controller/CTR/inst
force -freeze sim:/tb_controller/clk 1 0, 0 {2500 ps} -r 5000
run 500 ns
