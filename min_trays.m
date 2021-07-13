% for min number of trays
global yA_arr

% Equilibrium curve computation

xe = 0:0.01:1;
ye = yA_arr;

% up, Bottom mole fractions are equal to 85 % mol, 5 % mol.

xu = input('up mole fraction');
xb = input('bottom mole fraction');

% Computing the intersection of feed line and operating lines

hold on;
axis([0 1 0 1]);

% plotting equilibrium curve

plot(xe,ye,'r');
set(line([0  1],[0  1]),'Color',[0 1 0]);


% Plotting trays (min. trays) required
c = 0;
i = 1;
xp(1) = xb;
yp(1) = xb;
while(xp(i)<xu)
    
    pp = spline(xe,ye);
    yp(i+1) = ppval(pp,xp(i));
    set(line([xp(i) xp(i)],[yp(i) yp(i+1)]),'color',[0 0 1]);
    c = c+1;
    xp(i+1)=yp(i+1);
    set(line([xp(i) xp(i+1)],[yp(i+1) yp(i+1)]),'color',[0 0 1]);
   
    i = i + 1;
    
end


hold off;
disp("minimum number of trays")
disp(c)




