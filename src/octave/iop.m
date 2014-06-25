# -*- mode: octave -*-

Lp = 0.3;
Sigmap = 1;
Sigmas = 0.032; # [-0.02;0.2]
DeltaPi_s = -400;
rho=8.31*300; # gaz constant * body temperature (K)
J=0.04*1e-6; # 0.04-0.18
p_a = 30; # 30-35
DeltaPi_p = 25; #
p_e = 4; # 4-8 mm Hg
alpha = 1; # mm^3/mm Hg
R=2.5; # 2.5 - 5
Vstar=20;
#C1=DeltaPi_s/rho + C2;

# [p,C2] = [vy(1),vy(2)]
fvdb = @(vt,vy) [(Lp*(p_a-vy(1)-DeltaPi_p-sigmas*DeltaPi_s)-(vy(1)-p_e)/R)/alpha; ...
   (Lp*(p_a-vy(1)-DeltaPi_p-sigmas*DeltaPi_s))*( (1-sigmas)*(DeltaPi_s/rho+2*vy(2))/2 - vy(2))+J)Vstar];

%vopt = odeset ("RelTol", 1e-3, "AbsTol", 1e-3,"NormControl", "on", "OutputFcn", @odeplot);
vopt = odeset ("RelTol", 1e-3, "AbsTol", 1e-3,"NormControl", "on", "OutputFcn");
 [t,y] = ode45(fvdb,[0,20], [2 0], vopt);
t =linspace(t0,tf,100);
 y = lsode('fun2',y0,t');
