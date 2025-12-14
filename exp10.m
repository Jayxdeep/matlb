%2x2 mimo
ndata = 2;                     % Number of random data
x = [2 3];                     % Input data generated

%% INPUT DATA BITS
Data_input_bit(1,1) = x(1,1);
Data_input_bit(1,2) = x(1,2);

figure;
plot(Data_input_bit);
title('Input Bits');

%% PERFORMING 16-QAM MODULATION
z = qammod(Data_input_bit,4);

%% CHANNEL COEFFICIENT MATRIX
h = [0.3  -0.2;
     0.1   0.11];

%% NOISE COEFFICIENTS
e = [0.1  0.1;
     0.1  0.1];

out = zeros(10,2);

%% ALAMOUTI ENCODING
for i = 1
    out(i,1)     = z(i);
    out(i+1,1)   = z(i+1);
    out(i,2)     = -conj(z(i+1));
    out(i+1,2)   = conj(z(i));
end

s1 = out(i,1);
s2 = out(i+1,1);

%% RECEIVED SIGNALS
% RX1 at time T
r(1,1) = h(1,1)*s1 + h(1,2)*s2 + e(1,1);

% RX1 at time T+1
r(1,2) = -h(1,1)*conj(s2) + h(1,2)*conj(s1) + e(1,2);

% RX2 at time T
r(2,1) = h(2,1)*s1 + h(2,2)*s2 + e(2,1);

% RX2 at time T+1
r(2,2) = -h(2,1)*conj(s2) + h(2,2)*conj(s1) + e(2,2);

%% ALAMOUTI COMBINING
t(1,1) = conj(h(1,1))*r(1,1);
t(1,2) = h(1,2)*conj(r(1,2));
t(2,1) = conj(h(2,1))*r(2,1);
t(2,2) = h(1,2)*conj(r(2,2));

c(1,1) = conj(h(1,2))*r(1,1);
c(1,2) = h(1,1)*conj(r(1,2));
c(2,1) = conj(h(2,2))*r(2,1);
c(2,2) = h(2,1)*conj(r(2,2));

%% MAXIMUM LIKELIHOOD DETECTION
s1_e = t(1,1) + t(1,2) + t(2,1) + t(2,2);
s2_e = c(1,1) - c(1,2) + c(2,1) - c(2,2);

%% 16-QAM DEMODULATION
final_output_Bits(1,1) = qamdemod(s1_e,4);
final_output_Bits(1,2) = qamdemod(s2_e,4);

figure;
plot(final_output_Bits);
title('Final Output Bits');
