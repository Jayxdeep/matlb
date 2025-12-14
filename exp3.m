%log normal shadowing
C = 3e8; % Speed of light in meters per second
WCDMACellular = 2100 * 1e6; % Frequency in Hz
TXAntennaGain = 1; % Transmit antenna gain in dB
RXAntennaGain = 1; % Receive antenna gain in dB
PTx = 1e-3; % Transmit power in watts
PathLossExponent = 2; % Line of sight default
PTxdBm = 10 * log10(PTx * 1000); % Convert power to dBm
% Ask user for the type of environment
e = input('Enter type of Environment (1 - Free Space, 2 - Urban area cellular radio, 3 - Shadowed urbancellular radio, 4 - In building line-of-sight, 5 - Obstructed in factories, 6 - Obstructed in building): ');
% Ask user for distance
d = input('Enter Distance in meter from 100 to 2000: ');
% Set PathLossExponent based on environment type
if e == 1
PathLossExponent = 2;
elseif e == 2
PathLossExponent = 3.1;
elseif e == 3
PathLossExponent = 4;
elseif e == 4
PathLossExponent = 1.7;
23
elseif e == 5
PathLossExponent = 2.5;
else
PathLossExponent = 5;
end
Wavelength = C / WCDMACellular; % Calculate wavelength
d0 = 1; % Reference distance in meters
% Calculate initial received power at reference distance d0
Pr0 = PTxdBm + TXAntennaGain + RXAntennaGain - (10 * PathLossExponent * log10(4 * pi /Wavelength));
% Display the received power at reference distance
disp(['The Received Power for your given data is Pr0 in dB: ', num2str(Pr0)]);
% Prepare for plotting
figure;
hold on;
% Plotting for entire range of distances from 100m to 2000m
h = waitbar(0, 'Plotting the Received Power for the entire range of distances, please wait...');
rstate = randn('state');
randn('state', d); % Random number generator state for consistency
% Store results for each environment type
distances = 100:2:2000;
Pr1_values = zeros(size(distances));
Pr2_values = zeros(size(distances));
Pr3_values = zeros(size(distances));
Pr4_values = zeros(size(distances));
Pr5_values = zeros(size(distances));
% Loop over distances and calculate received power for each environment type
for i = 1:length(distances)
    d = distances(i);
    GaussRandom = randn * 0.1; % Random Gaussian noise
% Calculate received power for each environment type
    Pr1_values(i) = Pr0 - (10 * 2 * log10(d / d0)) + GaussRandom;
    Pr2_values(i) = Pr0 - (10 * 3.1 * log10(d / d0)) + GaussRandom;
    Pr3_values(i) = Pr0 - (10 * 4 * log10(d / d0)) + GaussRandom;
    Pr4_values(i) = Pr0 - (10 * 1.7 * log10(d / d0)) + GaussRandom;
    Pr5_values(i) = Pr0 - (10 * 2.5 * log10(d / d0)) + GaussRandom;
% Update waitbar
    waitbar(i / length(distances), h);
end
% Plot the results for all environment types
plot(distances, Pr1_values, 'g', 'DisplayName', 'Free Space (2)');
plot(distances, Pr2_values, 'k', 'DisplayName', 'Urban Area (3.1)');
plot(distances, Pr3_values, 'r', 'DisplayName', 'Shadowed Urban (4)');
plot(distances, Pr4_values, 'b', 'DisplayName', 'In Building LOS (1.7)');
plot(distances, Pr5_values, 'c', 'DisplayName', 'In Factory (2.5)');
% Add title and labels
title('Received Power for Various Environments over Distance (100 to 2000 meters)');
xlabel('Distance (in meters)');
ylabel('Received Power (in dBm)');
% Show legend
legend('show', 'Location', 'southwest');
% Close waitbar
close(h);