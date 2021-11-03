set QUARTUS_ROOTDIR $::env(QUARTUS_ROOTDIR)
set_global_assignment -name VHDL_FILE "${QUARTUS_ROOTDIR}dspba/backend/Libraries/vhdl/base/dspba_library_package.vhd"
set_global_assignment -name VHDL_FILE "${QUARTUS_ROOTDIR}dspba/backend/Libraries/vhdl/base/dspba_library.vhd"
