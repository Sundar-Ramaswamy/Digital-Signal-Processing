clear all
clc

%% post lab assessment question 1
%result 1
load('results1.mat')
figure
plot(txSave.time,real(txSave.data(:,1)))
hold on
xlabel('time')
ylabel('Amplitude')
title('Transmitted signal as a function of time(sim 1)')
plot(rxSave.time,real(rxSave.data(:,1)))
xlabel('time')
ylabel('Amplitude')
title('received signal as a function of time(sim 1)')

%result 2
load('results2.mat')
figure
plot(txSave.time,real(txSave.data(:,1)))
xlabel('time')
ylabel('Amplitude')
title('Transmitted signal as a function of time(sim 2)')
hold on
plot(rxSave.time,real(rxSave.data(:,1)))
xlabel('time')
ylabel('Amplitude')
title('received signal as a function of time(sim 2)')

%% post lab Q2

%% post lab Q3
eyediagram(rxSave.data,2)

%% post lab Q4
a=downsample(rxSave.data,10);

%% post lab Q5
scatterplot(rxSave.data)
title('Constellation diagram of transmitted signal')
scatterplot(txSave.data)
title('Constellation diagram of received signal')
a=downsample(rxSave.data,1);
scatterplot(a)
title('Constellation diagram of downsampled signal')
