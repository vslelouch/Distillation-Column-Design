%actual number of trays
global yA_arr

xe = 0:0.01:1;
ye = yA_arr;

% up, Bottom and Feed mole fractions are equal to 85 % mol, 5 % mol
% and 30 % mol respectively.
xu = input('up mole fraction');
xb = input('bottom mole fraction');
zf = input('feed mole fraction');

% xu=0.85;
% xb=0.05;
% zf=0.3;
% Reflux ratio is equal to 1.51435
R = input('Reflux ratio');
% R=1.51435;

% Feed is a Two-phase mixture with feed quality equal to 0.85
q = input('feed quality');
% q=0.85;

% Computing the intersection of feed line and operating lines

yi=(zf+xu*q/R)/(1+q/R);
xi=(-(q-1)*(1-R/(R+1))*xu-zf)/((q-1)*R/(R+1)-q);

hold on;
axis([0 1 0 1]);

% plotting operating and feed lines and equilibrium curve

plot(xe,ye,'r');
set(line([0  1],[0  1]),'Color',[0 1 0]);
set(line([xu xi],[xu yi]),'Color',[1 0 1]);
set(line([zf xi],[zf yi]),'Color',[1 0 1]);
set(line([xb xi],[xb yi]),'Color',[1 0 1]);


%Stripping Section
c=0;
i=1;
xp(1)=xb;
yp(1)=xb;
while(xp(i)<xi)
    
    pp = spline(xe,ye);
    yp(i+1) = ppval(pp,xp(i));
    set(line([xp(i) xp(i)],[yp(i) yp(i+1)]),'color',[0 0 1]);
    c=c+1;
    xp(i+1)=(yp(i+1)-xb)*((xi-xb)/(yi-xb))+xb;
    if(xp(i+1)<xi)
        set(line([xp(i) xp(i+1)],[yp(i+1) yp(i+1)]),'color',[0 0 1]);
        c=c+1;
    end
            i=i+1;
            
end

%Rectifying Section

xp(i)=(yp(i)-xu)*((xi-xu)/(yi-xu))+xu;
set(line([xp(i-1) xp(i)],[yp(i) yp(i)]),'color',[0 0 1]);
while(xp(i)>xi && xp(i)<xu)
    
    pp = spline(xe,ye);
    yp(i+1) = ppval(pp,xp(i));
    set(line([xp(i) xp(i)],[yp(i) yp(i+1)]),'color',[0 0 1]);
    c=c+1;
    xp(i+1)=(yp(i+1)-xu)*((xi-xu)/(yi-xu))+xu;
    set(line([xp(i) xp(i+1)],[yp(i+1) yp(i+1)]),'color',[0 0 1]);
    
    i=i+1;
    
end
hold off;

disp("Number of trays")
disp(c-1)
