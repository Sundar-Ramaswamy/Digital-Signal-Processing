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
str.averageLength = 64; % Length of STR averaging window
homeAssignment = 6;
SI = 7;
%% post lab assessment
rec_data = rxSave.Data;
plot(SymbSave.Time,SymbSave.Data);
eyediagram(real(rec_data),80);

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
x = cell2mat(sample_index_I_in);
a = 1:2050;
for i=2:length(x)
    a(i) =  bin2dec(x(i,:));
end
a = a';

x = cell2mat(sample_index_Q_in);
b = 1:2050;
for i=2:length(x)
    b(i) =  bin2dec(x(i,:));
end
b = b';

x = cell2mat(sample_index_I_out);
c = 1:2050;
for i=2:length(x)
    c(i) =  bin2dec(x(i,:));
end
c = c';

x = cell2mat(sample_index_Q_out);
d = 1:2050;
for i=2:length(x)
    d(i) =  bin2dec(x(i,:));
end
d = d';

x = cell2mat(sample_index_Symb_I);
e = 1:2050;
for i=2:length(x)
    e(i) =  bin2dec(x(i,:));
end
e = e';

x = cell2mat(sample_index_Symb_Q);
f = 1:2050;
for i=2:length(x)
    f(i) =  bin2dec(x(i,:));
end
f = f';

x = cell2mat(sample_index_actual);
g = 1:2050;
for i=2:length(x)
    g(i) =  bin2dec(x(i,:));
end
g = g';

plot(t,a,'r');
plot(t,b,'g');
plot(t,c,'b');
plot(t,d,'c');
plot(t,e,'m');
plot(t,f,'k');
plot(t,g,'k','LineWidth',2);



