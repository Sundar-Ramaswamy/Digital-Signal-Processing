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
add wave -noupdate -format Logic /MCC150_TransceiverBPSK_SingleRateFIR1_atb/dut/clk
add wave -noupdate -format Logic /MCC150_TransceiverBPSK_SingleRateFIR1_atb/dut/areset_n
add wave -noupdate -format Logical /MCC150_TransceiverBPSK_SingleRateFIR1_atb/sim/xIn_v_stm
add_fixpt_wave /MCC150_TransceiverBPSK_SingleRateFIR1_atb/sim/xIn_c_stm 8 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_SingleRateFIR1_atb/sim/xIn_0_stm 12 0 signed
add wave -noupdate -divider {Output Ports}
add wave -noupdate -format Logical /MCC150_TransceiverBPSK_SingleRateFIR1_atb/dut/xOut_v
add wave -noupdate -format Logical /MCC150_TransceiverBPSK_SingleRateFIR1_atb/sim/xOut_v_stm
add_fixpt_wave /MCC150_TransceiverBPSK_SingleRateFIR1_atb/dut/xOut_c 8 0 unsigned
add_fixpt_wave /MCC150_TransceiverBPSK_SingleRateFIR1_atb/sim/xOut_c_stm 8 0 unsigned
add_fixpt_wave /MCC150_TransceiverBPSK_SingleRateFIR1_atb/dut/xOut_0 30 0 signed
add_fixpt_wave /MCC150_TransceiverBPSK_SingleRateFIR1_atb/sim/xOut_0_stm 30 0 signed
TreeUpdate [SetDefaultTree]
