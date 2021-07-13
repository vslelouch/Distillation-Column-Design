% for minimum reflux ratio
global yA_arr

xe = 0:0.01:1;
ye = yA_arr;

% up, Bottom and Feed mole fractions are equal to 85 % mol, 5 % mol
% and 30 % mol respectively.

xu = input('up mole fraction');
xb = input('bottom mole fraction');
zf = input('feed mole fraction');
R = input('Reflux ratio');

% Reflux ratio is equal to 1.51435


% Feed is a Two-phase mixture with feed quality equal to 0.85

q = input('feed quality');

% Computing the intersection of feed line and operating lines

pp = spline(xe,ye);
yi = ppval(pp,zf);

hold on;
axis([0 1 0 1]);

% plotting operating and feed lines and equilibrium curve

plot(xe,ye,'r');
set(line([0  1],[0  1]),'Color',[0 1 0]);
set(line([xu zf],[xu yi]),'Color',[1 0 1]);
set(line([zf zf],[zf yi]),'Color',[1 0 1]);

% Slope for min. reflux ratio

slope_min_rr = ((xu-yi)/(xu-zf));
disp("minimum reflux ratio")
disp(slope_min_rr/(1-slope_min_rr))

