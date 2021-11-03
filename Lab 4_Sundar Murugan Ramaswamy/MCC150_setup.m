% clear all;
% clc;
%% 
clockRate = 40e6; %Clock rate of DSP block
dataRate = 5e6; %Data rate of DSP block
sampleRate = clockRate %Sample rate of DSP block
stepSize = 1/sampleRate; %Step size of the simulation
stopTime = 1000*stepSize %Stop time of the simulation
wordLength = 12; %Word length of the signal
tx.N = 1024; %No of signals to transmit
tx.data = randsrc(tx.N, 1, [0 1]); %Generate Transmitted
chan.phase = pi/2*rand() - pi/4;
chan.snr = 30;
chan.dly = 4;
% Filter coefficients
filter.coefs = fi(rcosdesign(1, 6, sampleRate/dataRate), true, wordLength);
sampleIndex = 4; % Sample index used in decimation
str.averageLength = 64; % Length of STR averaging window
homeAssignment = 6;
SI = 7;

%% post lab home assignment
% lab 3
sample_index = readtable('signalflow.csv');
t = sample_index.timeUnit_S;
sample_index_Symb_Q = sample_index.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Symb_Q_11__0;
sample_index_Symb_I = sample_index.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Symb_I_x_11_;
sample_index_I_in = sample_index.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_I_in_x_11__0;
sample_index_Q_in = sample_index.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Q_in_11__0_;
sample_index_I_out = sample_index.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_I_out_11__0_;
sample_index_Q_out = sample_index.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Q_out_11__0_;
sample_index_actual = sample_index.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_SampleIndex_;

figure
x = cell2mat(sample_index_Symb_I);
e = 1:2050;
for i=2:length(x)
    e(i) =  typecast(uint16(bin2dec(x(i,:))),'int16');
end
e = e'-2048;

x = cell2mat(sample_index_Symb_Q);
f = 1:2050;
for i=2:length(x)
    f(i) =  typecast(uint16(bin2dec(x(i,:))),'int16');
end
f = f'-2048;

subplot(2,1,1)
plot(t,e,'m');
xlabel('Time')
ylabel('magnitude')
title('Symb I')
subplot(2,1,2)
plot(t,f,'k');
xlabel('Time')
ylabel('magnitude')
title('Symb Q')
% lab 4
signaltap = readtable('lab4signals.csv');
Phase_comp_I = signaltap.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Symb_I_x_13_;
Phase_comp_Q = signaltap.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Symb_Q_13__0;
Transmitted  = signaltap.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_I_in_x_11__0;
Demod_out = signaltap.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Demod_out_0_;

x = cell2mat(Phase_comp_I);
a = 1:2050;
for i=2:length(x)
    a(i) =  typecast(uint16(bin2dec(x(i,:))),'int16');
end
a = a'
% 
x = cell2mat(Phase_comp_Q);
b = 1:2050;
for i=2:length(x)
    b(i) =  typecast(uint16(bin2dec(x(i,:))),'int16');
end
b = b'

figure
subplot(2,1,1)
plot(signaltap.timeUnit_S,a)
xlabel('Time')
ylabel('magnitude')
title('Phase compensated I signal')
subplot(2,1,2)
plot(signaltap.timeUnit_S,b)
xlabel('Time')
ylabel('magnitude')
title('Phase compensated Q signal')

x= cell2mat(Transmitted);
for i=2:length(x)
c(i) = str2num(x(i));
end
c = c'

x= cell2mat(Demod_out);
for i=2:length(x)
d(i) = str2num(x(i));
end
d = d'

figure()
subplot(2,1,1)
plot(signaltap.timeUnit_S,c)
xlim([0 500])
ylim([0 1.2])
xlabel('Time')
ylabel('Magnitude')
title('Transmitted')
subplot(2,1,2)
plot(signaltap.timeUnit_S,d)
xlim([0 500])
ylim([0 1.2])
xlabel('Time')
ylabel('Magnitude')
title('Demodulated')


