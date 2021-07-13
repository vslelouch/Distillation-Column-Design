%% binary system ethanol water

AntCon  = [8.11220 1592.864 226.184;7.96681  1668.210 228.000];
isPlot = true;
vLconst = [1.6798 0.9227];
P       = input('enter pressure'); %pressure [Pa]

hold on;
set(line([0  1],[0  1]),'Color',[0 1 0]);
[xA,yA] = txy_diagram (AntCon,vLconst,P,isPlot);


function [xA,yA] = txy_diagram (AntCon,vLconst,P,isPlot)
global yA_arr
A12 = vLconst(1);
A21 = vLconst(2);
%mole fractions
xA = 0:0.01:1;
xB = 1-xA;
%activity coefficients
gA = [0, exp(A12*(A21.*(1-xA(2:end-1))./(A12*xA(2:end-1)+A21*(1-xA(2:end-1)))).^2), 1];
gB = [1, exp(A21*(A12.*(xA(2:end-1))./(A21*(1-xA(2:end-1))+A12*(xA(2:end-1)))).^2), 0];

xA = xA(:);
xB = xB(:);
gA = gA(:);
gB = gB(:);

%boiling point of pure compound
tA = AntCon(1,2)/(AntCon(1,1)-log10(P))-AntCon(1,3);
tB = AntCon(2,2)/(AntCon(2,1)-log10(P))-AntCon(2,3);
x0   = linspace(tB,tA,length(xA));
spec = optimset('Display','notify');
Temp = fsolve(@Fun,x0,spec,AntCon,xA,xB,gA,gB,P);
yA   = compute_yA(Temp,AntCon,xA,gA,P);
yA_arr = yA;
if isPlot
    plot(xA,yA)
    xlabel('liquid mole fraction of ethanol')
    ylabel('vapor mole fraction of ethanol')
    title('x,y diagram')
    xlim([0 1])
end
%fprintf("%f\n",Temp);
end
function F = Fun (t,AC,xA,xB,gA,gB,P)
%nonlinear system of equations to solve
pA0 = antoineEq(AC(1,:),t);
pB0 = antoineEq(AC(2,:),t);
pA0 = pA0(:);
pB0 = pB0(:);
fA = 1;
fB = 1;
pA = pA0.*xA.*gA./fA;
pB = pB0.*xB.*gB./fB;
F  = pA+pB-P;
end

function F = compute_yA (t,AC,xA,gA,P)
% computes yA for xA
pA0 = antoineEq(AC(1,:),t);
pA0 = pA0(:);
F   = pA0/P.*xA.*gA;
end
function F = antoineEq (ACons,t)
%Antoine equation
t = t(:);
F = 10.^(ACons(1)-(ACons(2)./(ACons(3)+t)));
end



