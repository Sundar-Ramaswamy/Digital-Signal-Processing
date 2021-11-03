onerror {resume}

# obtain Modelsim version and extract the NN.Nc part after vsim
quietly set vsim_ver [regexp -inline {vsim (\d+\.\d+)(\w?)} [vsim -version]]
quietly set has_fixpt_radix 0
if {[lindex $vsim_ver 1] == 10.2} {
    if {[lindex $vsim_ver 2] >= "d"} {
        quietly set has_fixpt_radix 1
    }
} elseif {[lindex $vsim_ver 1] > 10.2} {
    quietly set has_fixpt_radix 1
}

proc add_fixpt_wave {name width frac_width signed} {
    global has_fixpt_radix
    if {$frac_width > 0 && $has_fixpt_radix} {
        set type "[string index $signed 0]fix${width}_En${frac_width}"
        if {[lsearch [radix names] $type] < 0} {
            if {$signed == "signed"} {
                radix define $type -fixed -signed -fraction $frac_width
            } else {
                radix define $type -fixed -fraction $frac_width
            }
        }
        add wave -noupdate -format Literal -radix $type $name
    } else {
        add wave -noupdate -format Literal -radix $signed $name
    }
}

add wave -noupdate -divider {Input Ports}
add wave -noupdate -format Logic /MCC150_TransceiverBPSK_Decimation_atb/dut/clk
add wave -noupdate -format Logic /MCC150_TransceiverBPSK_Decimation_atb/dut/areset_n
add wave -noupdate -format Logical /MCC150_TransceiverBPSK_Decimation_atb/sim/in_4_dv_stm
add_fixpt_wave /MCC150_TransceiverBPSK_Decimation_atb/sim/in_5_dc_stm 8 0 unsigned
add_fixpt_wave /MCC150_TransceiverBPSK_Decimation_atb/sim/in_1_I_in_stm 12 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_Decimation_atb/sim/in_2_Q_in_stm 12 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_Decimation_atb/sim/in_3_SampleIndex_stm 3 0 unsigned
add wave -noupdate -divider {Output Ports}
add wave -noupdate -format Logical /MCC150_TransceiverBPSK_Decimation_atb/dut/out_3_qv
add wave -noupdate -format Logical /MCC150_TransceiverBPSK_Decimation_atb/sim/out_3_qv_stm
add_fixpt_wave /MCC150_TransceiverBPSK_Decimation_atb/dut/out_4_qc 8 0 unsigned
add_fixpt_wave /MCC150_TransceiverBPSK_Decimation_atb/sim/out_4_qc_stm 8 0 unsigned
add_fixpt_wave /MCC150_TransceiverBPSK_Decimation_atb/dut/out_1_I_out 12 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_Decimation_atb/sim/out_1_I_out_stm 12 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_Decimation_atb/dut/out_2_Q_out 12 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_Decimation_atb/sim/out_2_Q_out_stm 12 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_Decimation_atb/dut/out_5_I_adj 12 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_Decimation_atb/sim/out_5_I_adj_stm 12 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_Decimation_atb/dut/out_6_Q_adj 12 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_Decimation_atb/sim/out_6_Q_adj_stm 12 0 signed
TreeUpdate [SetDefaultTree]
