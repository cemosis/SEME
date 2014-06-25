# -*- mode: octave -*-

 f=inline('0.08*y.*(1-(y/70))', 't','y');
 tspan = [0 360]; y0=40; h = 1; Nh = 360/h;
 [t, y] = heun(f,tspan,y0,Nh); plot(t,y)
 plot(t,y(:,1),'b', t,y(:,2),'r')

% pause;
% y0=[40;20]; t0=0; tf=120;

fvdb = @(vt,vy) [vy(2); (1 - vy(1)^2) * vy(2) - vy(1)];

vopt = odeset ("RelTol", 1e-3, "AbsTol", 1e-3,"NormControl", "on", "OutputFcn", @odeplot);
vopt = odeset ("RelTol", 1e-3, "AbsTol", 1e-3,"NormControl", "on", "OutputFcn");
 [t,y] = ode45(fvdb,[0,20], [2 0], vopt);
t =linspace(t0,tf,100);
 y = lsode('fun2',y0,t');
