%odfm transmitter
clc; clear; close all;

no_of_data_bits = 64;
M = 4;
block_size = 16;
cp_len = floor(0.1 * block_size);
cp_start = block_size - cp_len;

% Data generation (NO TOOLBOX)
data = randi([0 M-1], 1, no_of_data_bits);
figure(1); stem(data); grid on; title('Original Data');

% QPSK modulation (manual)
psk_modulated_data = exp(1j*(pi/4 + data*pi/2));
figure(2); stem(real(psk_modulated_data)); title('QPSK Modulated Data');

% Serial to Parallel
S2P = reshape(psk_modulated_data, no_of_data_bits/M, M);

% IFFT + Cyclic Prefix
for i = 1:M
    ifft_data(:,i) = ifft(S2P(:,i), block_size);
    cp(:,i) = ifft_data(cp_start+1:block_size,i);
    tx_cp(:,i) = [cp(:,i); ifft_data(:,i)];
end

% OFDM Signal
ofdm_signal = reshape(tx_cp,1,[]);
figure(3); plot(real(ofdm_signal)); grid on;
title('OFDM Transmitted Signal');
xlabel('Time'); ylabel('Amplitude');
