%link budget 
pt = input('Enter the input power in watts: ');
Pt = 10 * log10(pt); % Convert transmitted power to dB
gt = input('Enter the transmitting antenna gain in dB: ');
gs = input('Enter the receiving antenna gain in dB: ');
% Calculate EIRP (Effective Isotropic Radiated Power)
EIRP = Pt + gt;
% Display EIRP
fprintf('The EIRP is: %.2f dB\n', EIRP);
% Path loss calculation inputs
d = input('Enter the distance in km: ');
f = input('Enter the frequency in MHz: ');
% Calculate free space loss (FSL)
fsl = 32.4 + 20 * log10(d) + 20 * log10(f);
% Display free space loss
fprintf('The free space loss is: %.2f dB\n', fsl);
% Additional loss inputs
rfl = input('Enter the receiver feeder loss in dB: ');
aa = input('Enter the atmospheric absorption in dB: ');
aml = input('Enter the antenna misalignment loss in dB: ');
pl = input('Enter the polarization loss in dB: ');
% Calculate total losses
losses = fsl + rfl + aa + aml + pl;
% Display total losses
fprintf('Total losses: %.2f dB\n', losses);
% Calculate received power
P = EIRP + gs - losses;
% Display received power
fprintf('Total received power: %.2f dB\n', P)