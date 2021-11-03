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
add wave -noupdate -format Logic /MCC150_TransceiverBPSK_atb/dut/clk
add wave -noupdate -format Logic /MCC150_TransceiverBPSK_atb/dut/areset_n
add_fixpt_wave /MCC150_TransceiverBPSK_atb/sim/I_in_x_stm 12 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_atb/sim/Q_in_stm 12 0 signed
add wave -noupdate -divider {Output Ports}
add_fixpt_wave /MCC150_TransceiverBPSK_atb/dut/I_out 12 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_atb/sim/I_out_stm 12 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_atb/dut/Q_out 12 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_atb/sim/Q_out_stm 12 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_atb/dut/Symb_I_x 14 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_atb/sim/Symb_I_x_stm 14 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_atb/dut/Symb_Q 14 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_atb/sim/Symb_Q_stm 14 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_atb/dut/SampleIndex 3 0 unsigned
add_fixpt_wave /MCC150_TransceiverBPSK_atb/sim/SampleIndex_stm 3 0 unsigned
add wave -noupdate -format Logical /MCC150_TransceiverBPSK_atb/dut/Demod_out
add wave -noupdate -format Logical /MCC150_TransceiverBPSK_atb/sim/Demod_out_stm
TreeUpdate [SetDefaultTree]
