clc; clear; close all;

% Parameters
fc = 2.4e9; v = 50/3.6; c = 3e8;
fd = (v/c)*fc; fs = 1e4;
t = (0:fs-1)/fs; M = 16;
a = 2*pi*rand(1,M); p = 2*pi*rand(1,M);
h = (1/sqrt(M)) * sum(exp(1j*(2*pi*fd*cos(a).' .* t + p.')),1);
h = h / sqrt(mean(abs(h).^2));
figure;
subplot(2,1,1);
plot(t,abs(h)); grid on;
ylabel('|h(t)|'); title('Fading Envelope');

subplot(2,1,2);
plot(t,unwrap(angle(h))); grid on;
xlabel('Time (s)'); ylabel('Phase (rad)');
title('Fading Phase');
figure;
[pxx,f] = pwelch(h,512,256,1024,fs);
plot(f-fs/2,fftshift(10*log10(pxx))); grid on;
xlabel('Frequency (Hz)'); ylabel('PSD (dB/Hz)');
title('Doppler Spectrum');
N = 1e4;
data = randi([0 3],N,1);
tx = exp(1j*(pi/4 + data*pi/2));
EbNo = 0:2:14; BER = zeros(size(EbNo));

for k = 1:length(EbNo)
    snr = EbNo(k) + 3;
    n = sqrt(1/(2*10^(snr/10))) * ...
        (randn(N,1)+1j*randn(N,1));
    rx = h(1:N).' .* tx + n;
    rx = rx ./ h(1:N).';
    dec = mod(round((angle(rx)-pi/4)/(pi/2)),4);
    BER(k) = mean(dec ~= data);
end
figure;
semilogy(EbNo,BER,'-o'); grid on;
xlabel('Eb/No (dB)'); ylabel('BER');
title('BER under Rayleigh Fading');
