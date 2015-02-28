clear;
clc;

L(1) = Link([0 0 0 -pi/2]);
L(2) = Link([0 0.149 0.4318 0]);
L(3) = Link([0 0 0.0203 pi/2]);
L(4) = Link([0 0.433 0 -pi/2]);
L(5) = Link([0 0 0 pi/2]);
L(6) = Link([0 0.562 0 0]);

L(1).offset = pi/2;
L(3).offset = pi/2;

 L(1).qlim = pi/180*[-160 160];
 L(2).qlim = pi/180*[-225 45];
 L(3).qlim = pi/180*[-45 225];
 L(4).qlim = pi/180*[-110 170];
 L(5).qlim = pi/180*[-100 100];
L(6).qlim = pi/180*[-266 266];
 PUMA560 = SerialLink(L);
PUMA560.name = 'PUMA560'; 
PUMA560.plot([0 0 0 0 0 0]); %home position 

PUMA560.plot([pi/2 -pi/3 pi/3 pi/5 pi/2 pi/2]);

a1 = sym('a1');
 a2 = sym('a2');
a3 = sym('a3');
a4 = sym('a4');
a5 = sym('a5');
a6 = sym('a6');
vpa(PUMA560.fkine([a1 a2 a3 a4 a5 a6]))
