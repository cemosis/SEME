# -*- mode: octave -*-
pkg load odepkg

Lp = 0.3;
Sigmap = 1;
Sigmas = 0.032; # [-0.02;0.2]
DeltaPi_s = -400;
#rho=8.31*300e-3/133.322; # gaz constant * body temperature (K)
#rho = 62.36e-3*300
rho = 2494.19/133.322
J=0.04*1e-6; # 0.04-0.18
#p_a = 30; # 30-35#normal : 31.1, hyper : 35.5, hypo : 26.6
DeltaPi_p = 25; #
p_e = 8; # 4-8 mm Hg
alpha = 1; # mm^3/mm Hg
R=2.5; # 2.5 - 5
Vstar=20;
C1=314.04 #mol/m^3
#C1=DeltaPi_s/rho + C2;
#clf(1);
#clf(2);
i = 1
j = 1
#for R=linspace(2.5,5,10)
lab = 1
label = ['LBP','NBP','HBP']
for p_a = [26.6,31.1,35.5]
  # [p,C2] = [vy(1),vy(2)]
  fvdb = @(vt,vy) [(Lp*(p_a-vy(1)-DeltaPi_p-Sigmas*DeltaPi_s)-(vy(1)-p_e)/R)/alpha; (Lp*(p_a-vy(1)-DeltaPi_p-Sigmas*DeltaPi_s)*( (1-Sigmas)*(DeltaPi_s/rho+2*vy(2))/2 - vy(2))+J)/Vstar];

  psteady = (R*Lp*(p_a-DeltaPi_p-Sigmas*DeltaPi_s)+p_e)/(R*Lp+1)

  vopt = odeset ("RelTol", 1e-8, "AbsTol", 1e-3,"NormControl", "on");
				%vopt = odeset ("RelTol", 1e-3, "AbsTol", 1e-3,"NormControl", "on", "OutputFcn");
  C2init = C1-DeltaPi_s/rho
  [t,y] = ode45(fvdb,[0,5000], [16 C2init], vopt);
  figure(1);
  plot(t,y(:,1),['@',int2str(i),int2str(j),strcat(';',label(lab:lab+2),';')]);
  title('IOP = f(time) (in mmHg)')
  print IOP_time.pdf
  hold on;
  figure(2);
  plot(t,y(:,2),['@',int2str(i),int2str(j),strcat(';',label(lab:lab+2),';')]);
  title('C2 = f(time) (in mol.m^{-3})')
  print C2_time.pdf
  hold on;
  i=i+1
  j = j+1
  lab = lab +3
end
hold off;
