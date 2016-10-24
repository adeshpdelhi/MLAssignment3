% x1 = [0.0001,0.001,0.1,1,10,100];
% y1 = [90.45,95.3,96.1,94.925,93.8,93.725];
% y1=100-y1;
x2 = [0.001,0.1,1,10,100];
y2 = [87.74, 91.12, 90.63, 89.8, 87.35];
y2 = 100 - y2;
% plot(x1,y1,'DisplayName','Linear');
% figure;
plot(x2,y2,'DisplayName','Linear');
xlabel('C');
ylabel('Error');
title('C vs Error');



gx = [0.0000001, 0.000001, 0.00001];
gy = [87.83, 87.98, 87.32];
plot(gx,gy,'DisplayName','Linear');
xlabel('gamma');
ylabel('Error');
title('Gamma vs Error');

cx = [1, 10, 100];
cy = [87.60, 87.98, 87.83];
plot(cx,cy,'DisplayName','Linear');
xlabel('C');
ylabel('Error');
title('C vs Error');



C = 1.000000e-04  Accuracy 90.450000
C = 1.000000e-03  Accuracy 95.300000
C = 1.000000e-01  Accuracy 95.775000
C = 1  Accuracy 94.925000
C = 10  Accuracy 93.800000
C = 100  Accuracy 93.725000
C = 1000  Accuracy 93.725000


87.74, 91.12, 90.63, 89.8, 87.35
