t=input('enter type of city(1-small or med city,2-large city)')
u=input('enter type of city(1-urban,2-suburban,3-rural)')
hte=input('enter ht of trans ant');
hre=input('enter ht of rec ante');
f=input('enter fred in Mhz');
d=input('dist from base station');
disp('median path loss for u given data');
if t==1
    cf=(1.1*log10(f)-0.7)*hre-(1.566*log10(f)-0.8)
else if f<=300
    cf=8.29*(log10(1.54*hre))^2-1.1;
else
    cf=3.2*(log10(11.75*hre))^2-4.97;
end
L50 = 69.55 + 26.16 * log10(f) - 13.82 * log10(hte) - cf + (44.9 - 6.55 * log10(hte)) * log10(d);
if u == 2
L50 = L50 - (2 * log10(f / 28))^2 - 5.4;
elseif u == 3
L50 = L50 - (4.78 * log10(f))^2 + 18.33 * log10(f) - 40.94;
end
display(L50);
display(cf);
figure; % Prepare for plotting
hold on; % Keep all plots on the same figure
% Store the range of frequencies and path loss values
frequencies = 150:2:1500;
L50_values = zeros(size(frequencies)); % Pre-allocate for efficiency
% Loop through the range of frequencies and calculate L50 for each
for idx = 1:length(frequencies)
f = frequencies(idx);
if t == 1
cf = (1.1 * log10(f) - 0.7) * hre - (1.566 * log10(f) - 0.8);
elseif f <= 300
cf = 8.29 * (log10(1.54 * hre))^2 - 1.1;
else
cf = 3.2 * (log10(11.75 * hre))^2 - 4.97;
end
L50 = 69.55 + 26.16 * log10(f) - 13.82 * log10(hte) - cf + (44.9 - 6.55 * log10(hte)) * log10(d);
if u == 2
L50 = L50 - (2 * log10(f / 28))^2 - 5.4;
elseif u == 3
L50 = L50 - (4.78 * log10(f))^2 + 18.33 * log10(f) - 40.94;
end
L50_values(idx) = L50; % Store L50 for this frequency
end
% Plot the results
plot(frequencies, L50_values, 'LineWidth', 2);
title('The plot for the entire range of frequencies from 150 MHz to 1500 MHz');
xlabel('Frequency (in MHz)');
ylabel('Median path loss in dB');
grid on;
hold off;