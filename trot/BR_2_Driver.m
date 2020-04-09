function [sys,x0,str,ts] = BR_2_Driver(t,x,u,flag)

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
elseif u(1)<105
    Py = -100;
elseif u(1)<110
    Py = -100+10*(u(1)-105);
else
    Py = -50;
end
if u(1)<41
    Pz = 0;
elseif u(1)<61
    Pz = -10*(u(1)-41);
elseif u(1)<65
    Pz = -200;
elseif u(1)<85
    Pz = -200+15*(u(1)-65);
elseif u(1)<105
    Pz = 100-5*(u(1)-85);
elseif u(1)<110
    Pz = 0;
else
    Pz = -5*(u(1)-110);
end
L_1 = 50;
L_2 = 300;
L_3 = 300;
xita_1 = atan(Py/Px)-atan(-L_1/(sqrt(Px^2+Py^2-L_1^2)));
xita_3 = acos(((Px*cos(xita_1)+Py*sin(xita_1))^2+Pz^2-L_3^2-L_2^2)/(2*L_2*L_3));
xita_2 = asin((Pz*(L_3*cos(xita_3)+L_2)-L_3*sin(xita_3)*(Px*cos(xita_1)+Py*sin(xita_1)))/((Px*cos(xita_1)+Py*sin(xita_1))^2+Pz^2));
br_2_first_point = pi/4;
if u(1)<(pi/4)
    xita_2 = u(1);
elseif u(1)<41
    xita_2 = br_2_first_point;
elseif u(1)<61
    xita_2 = -xita_2;
elseif u(1)<65
    xita_2 = 1.1139;
else
    xita_2 = -xita_2;
end
sys(1) = xita_2;