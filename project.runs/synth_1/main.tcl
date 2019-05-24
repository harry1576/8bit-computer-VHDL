# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -id {Synth 8-256} -limit 10000
set_msg_config -id {Synth 8-638} -limit 10000
create_project -in_memory -part xc7a100tcsg324-3

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir P:/ENEL373/Lab_A01_group_20/project.cache/wt [current_project]
set_property parent.project_path P:/ENEL373/Lab_A01_group_20/project.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
read_vhdl -library xil_defaultlib {
  P:/ENEL373/Lab_A01_group_20/project.srcs/sources_1/new/FSM.vhd
  P:/ENEL373/Lab_A01_group_20/project.srcs/sources_1/new/tri_8.vhd
  P:/ENEL373/Lab_A01_group_20/project.srcs/sources_1/new/reg_8.vhd
  P:/ENEL373/Lab_A01_group_20/project.srcs/sources_1/new/display.vhd
  P:/ENEL373/Lab_A01_group_20/project.srcs/sources_1/new/debounce.vhd
  P:/ENEL373/Lab_A01_group_20/project.srcs/sources_1/imports/Downloads/clock_divider.vhd
  P:/ENEL373/Lab_A01_group_20/project.srcs/sources_1/new/btn_reg.vhd
  P:/ENEL373/Lab_A01_group_20/project.srcs/sources_1/new/ALU.vhd
  P:/ENEL373/Lab_A01_group_20/project.srcs/sources_1/new/main.vhd
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc P:/ENEL373/Lab_A01_group_20/project.srcs/constrs_1/imports/Downloads/Nexys4DDR_Master.xdc
set_property used_in_implementation false [get_files P:/ENEL373/Lab_A01_group_20/project.srcs/constrs_1/imports/Downloads/Nexys4DDR_Master.xdc]


synth_design -top main -part xc7a100tcsg324-3


write_checkpoint -force -noxdef main.dcp

catch { report_utilization -file main_utilization_synth.rpt -pb main_utilization_synth.pb }
