clc; clear; close all;

% Constants
c = 3e8;
f = 2100e6;                 % WCDMA frequency
Pt = 1e-3;                  % Transmit power (W)
Gt = 1; Gr = 1;             % Antenna gains
Pt_dBm = 10*log10(Pt*1000);
lambda = c/f;
d0 = 1;

% Reference received power
Pr0 = Pt_dBm + Gt + Gr - 10*2*log10(4*pi/lambda);

% Display Pr0 (as in manual)
fprintf('The Received Power for your given data is Pr0 in dB: %.4f\n', Pr0);

% User-selected case (manual style)
env = 1;                    % 1 = Free Space
d_user = 100;               % Distance in meters
n_env = 2;                  % Path loss exponent for free space

% Received power at 100 m
Pr_user = Pr0 - 10*n_env*log10(d_user/d0);
fprintf('Received Power at %d m (Free Space) = %.4f dBm\n', d_user, Pr_user);

% Distance range
d = 100:2:2000;

% Path loss exponents for environments
n = [2 3.1 4 1.7 2.5];
labels = {'Free Space','Urban','Shadowed Urban','In-Building LOS','Factory'};
colors = {'g','k','r','b','c'};

% Plot shadowing curves
figure; hold on;
for k = 1:length(n)
    shadow = 0.1*randn(size(d));
    Pr = Pr0 - 10*n(k)*log10(d/d0) + shadow;
    plot(d,Pr,colors{k},'DisplayName',labels{k});
end

title('Log-Normal Shadowing Model');
xlabel('Distance (m)');
ylabel('Received Power (dBm)');
legend('Location','southwest');
grid on;
