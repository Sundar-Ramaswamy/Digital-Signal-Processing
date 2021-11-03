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