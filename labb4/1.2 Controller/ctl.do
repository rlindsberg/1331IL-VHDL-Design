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
sim:/tb_controller/CTR/next_pc
add wave -position insertpoint  \
sim:/tb_controller/CTR/pc
add wave -position insertpoint  \
sim:/tb_controller/CTR/inst
force -freeze sim:/tb_controller/clock 1 0, 0 {250 ps} -r 500
run 18 ns
