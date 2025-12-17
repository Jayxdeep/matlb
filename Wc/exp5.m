%free space loss
f=input('enter the frequency in Mhz: ');
L=300/f; %calculating wavelength
disp('thus the wavelength is: ');
d=input('enter the distance in km: ');
Gt=input('enter the transmitting antenna gain in db: ');
Gr=input('enter the receiving antenna gain in db: ');
Wt=input('enter the transmitted power in dbm: ');
ls=32.44+20*log10(d)+20*log10(f); %calculating path loss
disp(sprintf('%s %d %s','the path loss is:',ls,'db'));%displaying path loss
Wr=Wt+Gt+Gr-ls; %calculating recieved power in db
disp(sprintf('%s %d %s','the recieved power is:',Wr,'db'));
wr=10^(Wr/10); %calculating recieved power in watts
disp(sprintf('%s %d %s','the recieved power is:',wr,'watts'));