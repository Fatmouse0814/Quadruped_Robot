function [sys,x0,str,ts] = BR_3_Driver(t,x,u,flag)

switch flag
    case 0
        [sys,x0,str,ts] = mdlInitializeSizes;
    case 1
        sys = mdlDerivatives(t,x,u);
    case 3
        sys = mdlOutputs(t,x,u);
    case {2,4,9}
        sys = [];
    otherwise
        error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts] = mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates = 0;
sizes.NumDiscStates = 0;
sizes.NumOutputs = 1;
sizes.NumInputs = 1;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0 = [];
str = [];
ts = [0 0];
function sys=mdlOutputs(t,x,u)
if u(1)<41
    Px = 300*sqrt(2);
elseif u(1)<61
    Px = 300*sqrt(2)-50*sin(pi/20*(u(1)-41));
elseif u(1)<65
    Px = 300*sqrt(2);
elseif u(1)<85
    Px = 300*sqrt(2)-50*sin(pi/20*(u(1)-65));
else
    Px = 300*sqrt(2);
end
if u(1)<85
    Py = -50;
elseif u(1)<95
    Py = -50-5*(u(1)-85);
else
    Py = -100;
end
if u(1)<41
    Pz = 0;
elseif u(1)<61
    Pz = -10*(u(1)-41);
elseif u(1)<65
    Pz = -200;
elseif u(1)<85
    Pz = -200+15*(u(1)-65);
else
    Pz = 100-5*(u(1)-85);
end
L_1 = 50;
L_2 = 300;
L_3 = 300;
xita_1 = atan(Py/Px)-atan(-L_1/(sqrt(Px^2+Py^2-L_1^2)));
xita_3 = acos(((Px*cos(xita_1)+Py*sin(xita_1))^2+Pz^2-L_3^2-L_2^2)/(2*L_2*L_3));
xita_2 = asin((Pz*(L_3*cos(xita_3)+L_2)-L_3*sin(xita_3)*(Px*cos(xita_1)+Py*sin(xita_1)))/((Px*cos(xita_1)+Py*sin(xita_1))^2+Pz^2));
br_3_first_point = -pi/2;
if u(1)<(pi/4)
    xita_3 = -2*u(1);
elseif u(1)<41
    xita_3 = br_3_first_point;
elseif u(1)<61
    xita_3 = -xita_3;
elseif u(1)<65
    xita_3 = -1.3467;
else
    xita_3 = -xita_3;
end
sys(1) = xita_3;