#DO NOT USE WITH MODELSIM-ALTERA VERSION OR MODELSIM-ALTERA Web Edition
#This file contains the commands to create libraries and compile the library file into those libraries.

# 1)  Make sure to set quartus_sim_lib variable to c:/altera/VER_NUMBER/quartus/eda/sim_lib
#  set quartus_sim_lib C:/intelFPGA/16.1/quartus/eda/sim_lib
#  set libs             ./libs
#  set vrl_lib_path     ./libs/vrl
#  set vhd_lib_path     ./libs/vhd

# 2)  To compile basic Altera libraries: do ./vhdl_library-setup.tcl 
#       Example: do ./vhdl_library-setup.tcl

#                    do CompileAlteraSimLibs.do clean"
#                    do CompileAlteraSimLibs.do altera_vrl
#                    do CompileAlteraSimLibs.do altera_vhd
#                    do CompileAlteraSimLibs.do cycloneive
#                    do CompileAlteraSimLibs.do cyclonev"

# 3)  To compile basic Altera and Device Specific Libraries: do ./vhdl_library-setup.tcl device_name
#       Example: do ./vhdl_library-setup.tcl stratixv
#       Example: do ./vhdl_library-setup.tcl cyclonev

set vhdFileName_vhdLibName {
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
  altera_europa_support_lib.vhd }

set cycloneive_vhdFileName_libName {
  cycloneive_atoms.vhd
  cycloneive_components.vhd        }

set cycloneV_vhdFileName_libName {
  cyclonev_atoms.vhd
  cyclonev_components.vhd
  cyclonev_hssi_components.vhd
  cyclonev_hssi_atoms.vhd}


set verFileName_libName {
    altera_primitives.v
    220model.v
    sgate.v
    altera_mf.v
    altera_lnsim.sv
    mentor/altera_lnsim_for_vhdl.sv }


proc pause {{message "Hit Enter to continue..."}} {
    puts -nonewline $message
    flush stdout
    gets stdin }

	
proc clean_lib {lib_path} {
    puts "Checking if $lib_path directory already exists; remove if exists"
    if { [file exists "$lib_path"] == 1 } { 
	  puts "$lib_path exists; removing directory: $lib_path  "
	  file delete -force "$lib_path" }
    puts "Checking if $lib_path is missing; make $lib_path if missing."
    if { [file exists "$lib_path"] == 0 } { 
      puts "$lib_path is missing; making $lib_path directory..."
      file mkdir $lib_path } 
}



# VHDL FUNCTIONS:

proc compile_vhdl_file { destination_library_dir 
                         vhd_source_file             } {

    puts ""
    puts "+++++++++++++ Starting to compile $vhd_source_file to $destination_library_dir +++++++++++++"
    #strip of the PATH and EXTENSION from <PATH>/vhd_source_file_name/<EXTENSION> 
    set destination_lib_name [file rootname [file tail $destination_library_dir]]
    puts "vhd_source_file: $vhd_source_file" 
    puts "destination_library_dir: $destination_library_dir" 
    vlib $destination_library_dir
    vmap $destination_lib_name $destination_library_dir
    vcom -work $destination_library_dir -2008 $vhd_source_file
    puts "------------- Done compiling $vhd_source_file to $destination_library_dir -------------" 

}


proc compile_vhdl_lib { destination_library_path 
                        path_to_vhd_source_file_dir 
                        vhd_source_file             } {

  foreach source_file $vhd_source_file {
    puts "+++++++++++++ Starting to compile $source_file to $source_file +++++++++++++"
    #strip of the PATH and EXTENSION from <PATH>/source_file_name/<EXTENSION> 
    set destination_lib_name [file rootname [file tail $source_file]]
    puts ""
    puts "source_file: $source_file" 
    puts "destination_library_path: $destination_library_path" 
    puts "path_to_vhd_source_file_dir: $path_to_vhd_source_file_dir" 
    puts "destination_lib_name $destination_lib_name"
    vlib $destination_library_path/$destination_lib_name
    vmap $destination_lib_name $destination_library_path/$destination_lib_name
    vcom -work $destination_library_path/$destination_lib_name -2008 $path_to_vhd_source_file_dir/$source_file
    puts "xxxxxxxxxxxxx Done compiling $source_file to $source_file xxxxxxxxxxxxx" 
  } 
}


# VERILOG FUNCTIONS:
proc compile_vrl_file { destination_library_dir 
                        vrl_source_file             } {

    puts ""
    puts "+++++++++++++ Starting to compile $vrl_source_file to $destination_library_dir +++++++++++++"
    #strip of the PATH and EXTENSION from <PATH>/vrl_source_file_name/<EXTENSION> 
    set destination_lib_name [file rootname [file tail $destination_library_dir]]
    puts "vrl_source_file: $vrl_source_file" 
    puts "destination_library_dir: $destination_library_dir" 
    vlib $destination_library_dir
    vmap $destination_lib_name $destination_library_dir
    vlog -work $destination_library_dir $vrl_source_file
    puts "------------- Done compiling $vrl_source_file to $destination_library_dir -------------" 

}

proc compile_vrl_lib { destination_library_path
                       path_to_vhd_source_file_dir 
                       vhd_source_file             } {

  foreach source_file $vhd_source_file {
    puts "+++++++++++++ Starting to compile $source_file to $source_file +++++++++++++"
    #strip of the PATH and EXTENSION from <PATH>/source_file_name/<EXTENSION> 
    set destination_lib_name [file rootname [file tail $source_file]]
    puts ""
    puts "source_file: $source_file" 
    puts "destination_library_path: $destination_library_path" 
    puts "path_to_vhd_source_file_dir: $path_to_vhd_source_file_dir" 
    puts "destination_lib_name $destination_lib_name"
    vlib $destination_library_path/$destination_lib_name
    vmap $destination_lib_name $destination_library_path/$destination_lib_name
    #vlog -work $path_to_vrl_lib/$vrl_lib_name ${path_to_vrl_files}/$vrl_altera_basic_lib
    vlog -work $destination_library_path/$destination_lib_name $path_to_vhd_source_file_dir/$source_file
    puts "xxxxxxxxxxxxx Done compiling $source_file to $source_file xxxxxxxxxxxxx" 
  } 
}


proc test_proc { sim_path_to_vrl_lib 
                 quartus_path_to_vrl_files 
                 vhd_source_file} {

  set path_to_vrl_lib $sim_path_to_vrl_lib
  set path_to_vrl_files $quartus_path_to_vrl_files

  foreach elem $vhd_source_file {
    #puts "$elem" 
	set vrl_altera_basic_lib [lindex $elem 0]
	set vrl_lib_name [lindex $elem 1]
    puts "+++++++++++++ Starting to compile $vrl_altera_basic_lib to $vrl_lib_name +++++++++++++"
	vlib $path_to_vrl_lib/$vrl_lib_name
    vmap $vrl_lib_name $path_to_vrl_lib/$vrl_lib_name
    vlog -work $path_to_vrl_lib/$vrl_lib_name ${path_to_vrl_files}/$vrl_altera_basic_lib
    puts "xxxxxxxxxxxxx Done compiling $vrl_altera_basic_lib to $vrl_lib_name xxxxxxxxxxxxx" 
  } 
}
	

# pause	

# Clean All Current Libraries:
if {$argc > 0} {
  if { $1 == "clean" } {
    clean_lib $libs
	clean_lib $vrl_lib_path
	clean_lib $vhd_lib_path 
  } 
}
# pause


  
# ALTERA VHDL Libraries:
if {$argc > 0} {
  if { $1 == "altera_vhd" } { 
    compile_vhdl_lib $vhd_lib_path $quartus_sim_lib $vhdFileName_vhdLibName 
  } 
}


# CYCLONE-IVe Libraries:
if {$argc > 0} {
  if { $1 == "cycloneive" } {
    compile_vhdl_lib $vhd_lib_path $quartus_sim_lib $cycloneive_vhdFileName_libName
  }
}

# pause

# CYCLONE-V Libraries:
if {$argc > 0} {
  if { $1 == "cyclonev" } {
    compile_vhdl_lib $vhd_lib_path $quartus_sim_lib $cycloneV_vhdFileName_libName
  }
}

# ALTERA Verilog Libraries:
if {$argc > 0} {
  if { $1 == "altera_vrl" } {
        puts "verilog"
    compile_vrl_lib $vrl_lib_path $quartus_sim_lib $verFileName_libName
  }
}

if {$argc > 0} {
    if { $1 == "vhd_file" } {
        compile_vhdl_file $destination_lib_path $vhdl_source_file
    } 
}

if {$argc > 0} {
    if { $1 == "vrl_file" } {
        compile_vrl_file $destination_lib_path $vrl_source_file
    } 
}

if {$argc > 0} {
    if { $1 == "test" } {
        #compile_vhdl_file $destination_lib_path $vhdl_source_file
    } 
}
	
# pause

exit -force
