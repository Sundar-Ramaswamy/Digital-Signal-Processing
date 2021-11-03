clear all;
clc;
%% 1
tx.data = randsrc(1000, 1, [0 1]); %random bitstream
tx.symbols = exp(1i*pi.*tx.data); %bitstream to complex
chan.phase = pi/2*rand() - pi/4 %phase 
rx.symbols = tx.symbols.*exp(1i*chan.phase); %R(t)=[I(t)+Q(t)]*e^-j(phase)

demodulated_bitstream = (rx.symbols)*(cos(chan.phase)-(1i*sin(chan.phase))); %R(t)(cos(phase)-isin(phase))
for i=1:length(demodulated_bitstream) 
    if real((demodulated_bitstream(i))>0) %conversion of complex into real and storing in the array
        rx.data(i)=0;
    else
        rx.data(i)=1;
    end
end
rx.data=rx.data';
error_count= sum(xor(tx.data, rx.data)); %logical operator to find if there is any change in bitstream values.

%% 2
clear all;

tx.data = randsrc(1000, 1, [0 1]);%random bitstream
tx.symbols = exp(1i*pi.*tx.data);%bitstream to complex
chan.phase = cumsum(randn(size(tx.data))*1e-2);  %phase (random walk)
rx.symbols = tx.symbols.*exp(1i*chan.phase); %R(t)=[I(t)+Q(t)]*e^-j(phase)
phase = ((1/2) *angle(rx.symbols.^2));
% phase = ((1/2) *angle(rx.symbols.^2))\1.5; %prelab Q4
demodulated_bitstream = (rx.symbols).*(cos(phase)-(1i*sin(phase)));%R(t)(cos(phase)-isin(phase))
for i=1:length(demodulated_bitstream)
    if real((demodulated_bitstream(i))>0) %conversion of complex into real and storing in the array
        rx.data(i)=0;
    else
        rx.data(i)=1;
    end
end

rx.data=rx.data';
error_count= sum(xor(tx.data, rx.data)); %logical operator to find if there is any change in bitstream values.
