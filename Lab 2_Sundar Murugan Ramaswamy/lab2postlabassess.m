%%
clockRate = 40e6; %Clock rate of DSP block
dataRate = 5e6; %Data rate of DSP block
sampleRate = clockRate %Sample rate of DSP block
stepSize = 1/sampleRate; %Step size of the simulation
stopTime = 1000*stepSize %Stop time of the simulation
wordLength = 12; %Word length of the signal
tx.N = 1024; %No of signals to transmit
tx.data = randsrc(tx.N, 1, [0 1]); %Gererate PRBS
chan.phase = pi/2*rand() - pi/4;
chan.snr = 30;
chan.dly = 4;
% Filter coefficients
filter.coefs = fi(rcosdesign(1, 6, sampleRate/dataRate), true, wordLength);
sampleIndex = 4; % Sample index used in decimation


%% Q2
rec_data = rxSave.Data;
plot(SymbSave.Time,SymbSave.Data);
eyediagram(real(rec_data),80);
%% csv import
sample_index0 = readtable('data0index.csv');
t0 = sample_index0.timeUnit_S;
sample_index0_Symb_Q = sample_index0.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Symb_Q_11__0;
sample_index0_Symb_I = sample_index0.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Symb_I_x_11_;
sample_index0_I_in = sample_index0.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_I_in_x_11__0;
sample_index0_Q_in = sample_index0.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Q_in_11__0_;
sample_index1 = readtable('data1index.csv');
t1 = sample_index1.timeUnit_S;
sample_index1_Symb_Q = sample_index1.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Symb_Q_11__0;
sample_index1_Symb_I = sample_index1.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Symb_I_x_11_;
sample_index1_I_in = sample_index1.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_I_in_x_11__0;
sample_index1_Q_in = sample_index1.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Q_in_11__0_;
sample_index2 = readtable('data2index.csv');
t2 = sample_index2.timeUnit_S;
sample_index2_Symb_Q = sample_index2.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Symb_Q_11__0;
sample_index2_Symb_I = sample_index2.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Symb_I_x_11_;
sample_index2_I_in = sample_index2.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_I_in_x_11__0;
sample_index2_Q_in = sample_index2.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Q_in_11__0_;
sample_index3 = readtable('data3index.csv');
t3 = sample_index3.timeUnit_S;
sample_index3_Symb_Q = sample_index3.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Symb_Q_11__0;
sample_index3_Symb_I = sample_index3.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Symb_I_x_11_;
sample_index3_I_in = sample_index3.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_I_in_x_11__0;
sample_index3_Q_in = sample_index3.MCC150_TransceiverBPSK_MCC150_TransceiverBPSK_inst_Q_in_11__0_;
%% Q4 
x = cell2mat(sample_index0_Q_in);
a = 1:2050;
for i=2:length(x)
    a(i)=bin2dec(x(i,:));
end
a = a';
eyediagram(a,80)
ylim([-3000 5000])
title('Q in eye diagram')
x = cell2mat(sample_index0_I_in);
b = 1:2050;
for i=2:length(x)
    b(i)=bin2dec(x(i,:));
end
b = b';
eyediagram(b,80)
ylim([-3000 5000])
title('I in eye diagram')
%% Q3
x = cell2mat(sample_index3_Symb_I);
a = 1:2050;
for i=2:length(x)
    a(i) =  bin2dec(x(i,:));
end
a = a';

x = cell2mat(sample_index3_Symb_Q);
b = 1:2050;
for i=2:length(x)
    b(i) =  bin2dec(x(i,:));
end
b = b';

plot(t3,a,'LineWidth',1)
hold on
plot(t3,b)
ylim([2040 2050])
xlabel('Time')
ylabel('Symb')
legend({'SymbI','SymbQ'},'Location','best')