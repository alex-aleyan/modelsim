#Launches the simulation of the compiled test bench script:
vsim -novopt -L work \
             -L work_lib \
             -L i_tse_mac \
             -L rst_controller \
             -L tse \
             -L altera_ver \
             -L lpm_ver \
             -L sgate_ver \
             -L altera_mf_ver \
             -L altera_lnsim_ver \
             -L cycloneive_ver \
             tse_controller_tb


#vsim -novopt -t ps -L work \
#                   -L work_lib \
#                   -L i_tse_mac \
#                   -L rst_controller \
#                   -L tse \
#                   -L altera_ver \
#                   -L lpm_ver \
#                   -L sgate_ver \
#                   -L altera_mf_ver \
#                   -L altera_lnsim_ver \
#                   -L cycloneive_ver $TOP_LEVEL_NAME


  
