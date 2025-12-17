hte=30:1:100; % base station antenna height
hre=input('enter the receiver antenna height 3m<hre<10m: '); % mobile
d=input ('Enter the distance from base station 1Km<d<100km:');
f=input ('Enter the frequency 150MHz<f<1920 MHz: ');
EIRP =input ('enter the EIRP value:'); 
Gr=input('enter receiver antenna gain: '); 
Grdb=10*log10(Gr);
EIRPdBm=10*log10(EIRP/10^-3);
c=3*(10^8);
lamda=(c)/(f*10^6);
Lf=-10*log10((lamda^2)/((4*pi)^2*d^2)); % free space 
Amu=43; %median attenuation relative to
Garea=9; %gain due to the
Ghte=20*log10(hte/200);
if(hre>3)
    Ghre=20*log10(hre/3);
else
    Ghre=10*log10(hre/3);
end
%propagation path loss
L50=Lf+Amu-Ghte-Ghre-Garea; 
disp('propagation path loss is: ');
% calculate the power
Prd= EIRPdBm-L50+Grdb; 
disp(Lf);
disp(Ghte);
disp(Ghre);
disp(lamda);
disp(L50);
disp(Grdb);
disp(EIRPdBm); disp(Prd);
plot(hte, L50,'LineWidth',1.5);
title('Okumura Model Analysis');
xlabel('Transmitter antenna Height(Km)'); 
ylabel('propagation path loss(db)at 50Km'); 
grid on;