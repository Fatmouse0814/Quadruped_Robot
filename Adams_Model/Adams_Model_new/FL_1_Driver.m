function [sys,x0,str,ts] = FL_1_Driver(t,x,u,flag)

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
if u(1)<21
    Px = 300*sqrt(2)-25*sin(pi/20*(u(1)-1));
elseif u(1)<125
    Px = 300*sqrt(2);
elseif u(1)<145
    Px  = 300*sqrt(2);
end
if u(1)<85
    Py = -50;
elseif u(1)<95
    Py = -50+5*(u(1)-85);
else
    Py = 0;
end
if u(1)<21
    Pz = 5*(u(1)-1);
elseif u(1)<65
    Pz = 100;
else
    Pz = 100-5*(u(1)-65);
end
L_1 = 50;
L_2 = 300;
L_3 = 300;
xita_1 = atan(Py/Px)-atan(-L_1/(sqrt(Px^2+Py^2-L_1^2)));
%xita_3 = acos(((Px*cos(xita_1)+Py*sin(xita_1))^2+Pz^2-L_3^2-L_2^2)/(2*L_2*L_3));
%xita_2 = asin((Pz*(L_3*cos(xita_3)+L_2)-L_3*sin(xita_3)*(Px*cos(xita_1)+Py*sin(xita_1)))/((Px*cos(xita_1)+Py*sin(xita_1))^2+Pz^2));
if u(1)<(85)
    xita_1 = 0;
end
sys(1) = xita_1;