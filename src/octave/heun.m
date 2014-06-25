function [t, y] = heun (odefun,tspan,y,Nh,varargin)
%HEUN  Solve differential equations, two order method.
%   [T,Y] = HEUN(ODEFUN,TSPAN,Y0,NH) with TSPAN = [T0 TFINAL] integrates the
%   system of differential equations y' = f(t,y) from time T0 to TFINAL with
%   initial conditions Y0 using the Heun method on an equispaced
%   grid of NH intervals. Function ODEFUN(T,Y) must return a column vector
%   corresponding to f(t,y). Each column in the solution array Y corresponds to
%   a time returned in the row vector T. 
%   [T,Y] = FEULER(ODEFUN,TSPAN,Y0,NH,P1,P2,...) passes the additional
%   parameters P1,P2,... to the function ODEFUN as ODEFUN(T,Y,P1,P2...).


h=(tspan(2)-tspan(1))/Nh;
tt=linspace(tspan(1),tspan(2),Nh+1);
for t = tt(1:end-1)
  y=[y;y(end,:)+0.5*h*( feval(odefun,t,y(end,:),varargin{:}) + ...
     feval(odefun,t+h,y(end,:) + h*feval(odefun,t,y(end,:),varargin{:}),varargin{:}) )
    ];
end
t=tt';


return

