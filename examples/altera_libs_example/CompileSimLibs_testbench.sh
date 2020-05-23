#!/bin/bash

source ./include.ln

#modelsim_path="c:/modeltech64_10.5g/win64"

quartus_sim_lib="${QUARTUS_ROOTDIR}/eda/sim_lib"

here="$(dirname $(readlink -f "$0"))"

libs="$here/libs"
vrl_lib_path="$libs/vrl"
vhd_lib_path="$libs/vhd"

mkdir -p $vrl_lib_path
if [ $? -ne 0 ]; then echo "FAILED TO CREATE LIB"; exit; fi
mkdir -p $vhd_lib_path
if [ $? -ne 0 ]; then echo "FAILED TO CREATE LIB"; exit; fi

does_dir_exist $QUARTUS_ROOTDIR
does_dir_exist $quartus_sim_lib

cp $MODELSIM ./

does_file_exist ./modelsim.ini
#if [ $? -ne 0 ]; then exit; fi

echo -e "Launching modelsim now!"

#vsim -c -do "set quartus_sim_lib $quartus_sim_lib; set libs $libs; set vrl_lib_path $vrl_lib_path; set vhd_lib_path $vhd_lib_path; do CompileSimLibs.do clean"
#vsim -c -do "set quartus_sim_lib $quartus_sim_lib; set libs $libs; set vrl_lib_path $vrl_lib_path; set vhd_lib_path $vhd_lib_path; do CompileSimLibs.do altera_vrl"
#vsim -c -do "set quartus_sim_lib $quartus_sim_lib; set libs $libs; set vrl_lib_path $vrl_lib_path; set vhd_lib_path $vhd_lib_path; do CompileSimLibs.do altera_vhd"
#vsim -c -do "set quartus_sim_lib $quartus_sim_lib; set libs $libs; set vrl_lib_path $vrl_lib_path; set vhd_lib_path $vhd_lib_path; do CompileSimLibs.do cycloneive"
#vsim -c -do "set quartus_sim_lib $quartus_sim_lib; set libs $libs; set vrl_lib_path $vrl_lib_path; set vhd_lib_path $vhd_lib_path; do CompileSimLibs.do cyclonev"





# vhdl_source_file="$quartus_sim_lib/altera_syn_attributes.vhd"
# destination_lib_path="$vhd_lib_path"
# vsim -c -do "set destination_lib_path "$destination_lib_path"; 
#              set vhdl_source_file "$vhdl_source_file"; 
#              do CompileSimLibs.do test"



source_files=(
altera_syn_attributes.vhd
altera_standard_functions.vhd
alt_dspbuilder_package.vhd
altera_europa_support_lib.vhd
altera_primitives_components.vhd
altera_primitives.vhd
220pack.vhd
220model.vhd
sgate_pack.vhd
sgate.vhd
altera_mf_components.vhd
altera_mf.vhd
altera_lnsim_components.vhd
alt_dspbuilder_package.vhd
altera_europa_support_lib.vhd
)

for source_file in ${source_files[@]}
do
    vhdl_source_file="$quartus_sim_lib/${source_file}"
    destination_lib_path="libs/altera_vhd"
    vsim -c -do "set destination_lib_path "$destination_lib_path"; 
                 set vhdl_source_file "$vhdl_source_file"; 
                 do CompileSimLibs.do vhd_file"
done


source_files=(
    altera_primitives.v
    220model.v
    sgate.v
    altera_mf.v
    altera_lnsim.sv
    mentor/altera_lnsim_for_vhdl.sv
)
for source_file in ${source_files[@]}
do
    sourcefile="$quartus_sim_lib/${source_file}"
    destination_lib_path="libs/altera_vrl"
    vsim -c -do "set destination_lib_path "$destination_lib_path"; 
                 set vrl_source_file "$sourcefile"; 
                 do CompileSimLibs.do vrl_file"
done




exit 0
