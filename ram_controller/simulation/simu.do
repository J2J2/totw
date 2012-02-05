# create library
if [file exists work] {
    vdel -all
}
vlib work

# compile the Verilog source files
vlog -O0 -cover bcefst ../source_rtl/*.v +incdir+../source_rtl 
vlog ../t_bench/*.v +incdir+../t_bench

# open debugging windows
view wave

# start and run simulation
#vsim  -voptargs="+acc" tb_sample
#vsim tb_cwg +nowarnTFMPC +nowarnTSCALE +notimingchecks
vsim -debugdb -voptargs="+acc" tb_ram_controller +nowarnTFMPC +nowarnTSCALE +notimingchecks

log -r *
do wave.do
run -a

