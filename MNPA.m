clear all;
close all;

%Constants
G1 = 1/1;
C_const = 0.25;
G2 = 1/2;
L = 0.2;
G3 = 1/10;
a = 100;
G4 = 1/0.1;
G0 = 1/1000;

Vs_var = linspace(-10,10,100);
%G MATRIX
G = zeros(7,8);

%V1 Iin V2 V3 I3 V4 I4 Vo
%1   2  3  4  5  6  7  8
G(1,1) = G1;
G(1,2) = 1;
G(1,3) = -G1;

G(2,1) = 1;

G(3,1) = -G1;
G(3,3) = G1 + G2;
G(3,4) = G3;

G(4,3) = -1;
G(4,4) = 1;

G(5,7) = 1;
G(5,6) = G4;
G(5,8) = -G4;

G(6,6) = 1;
G(6,5) = -a;

G(7,8) = G4 + G0;
G(7,6) = -G4;
%C MATRIX
C = zeros(7,8);

C(3,1) = -C_const;
C(3,3) = C_const;
C(4,5) = L;

%F MATRIX
F = zeros(7,1);

%PLOT
figure(1)
V = zeros(1,length(Vs_var));
for i = 1:length(Vs_var)
    F(2,1) = Vs_var(i);
    V = G\F;
    plot(Vs_var(i),V(8), 'r.');
    hold on;
    plot(Vs_var(i),V(4), 'b.');
    pause(0.05);
end

%AC
w = linspace(0,100,101);
figure(2)
Vac_s = 10.*cos(w);
for i = 1:length(w)
    F(2,1) = Vac_s(i);
    V = (G+i*w(i)*C)\F;
    plot(w(i),V(8), 'r.');
    hold on;
    plot(w(i),V(4), 'b.');
    pause(0.05);
end



