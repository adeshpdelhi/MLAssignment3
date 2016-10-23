x1 = [0.001,0.1,1,10,100];
% y1 = [90.45,95.3,95.775,94.925,93.8,93.725];
y2 = [87.74, 91.12, 90.63, 89.8, 87.35];
plot(x1,y2,'DisplayName','Linear');
% hold on;
% plot(x1,y2,'DisplayName','minsup = 0.4');
% hold on;
% plot(x1,y3,'DisplayName','minsup = 0.35');
% legend('show');

xlabel('C');
ylabel('Accuracy');
title('C vs Accuracy');


C = 1.000000e-04  Accuracy 90.450000
C = 1.000000e-03  Accuracy 95.300000
C = 1.000000e-01  Accuracy 95.775000
C = 1  Accuracy 94.925000
C = 10  Accuracy 93.800000
C = 100  Accuracy 93.725000
C = 1000  Accuracy 93.725000


87.74, 91.12, 90.63, 89.8, 87.35
