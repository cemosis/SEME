# -*- mode: octave -*-
pkg load odepkg
#CONSTANTS 
Lp = 0.3;
Sigmap = 1;
Sigmas = 0.032; # [-0.02;0.2]
DeltaPi_s = -400; #mmHg
DeltaPi_p = 25; # mmHg

#rho=8.31*300/133.322; # gaz constant * body temperature (K)
#rho = (2494.19/133.322)#mmHg*m^3.mol^-1
rho = (2494.19/133.322)*1e3#mmHg*mm^3.mumol^-1

J =  0.04#-0.18 #mumol.min-1

#p_a = 30; # 30-35#normal : 31.1, hyper : 35.5, hypo : 26.6

p_e = 4; # 4-8 mm Hg
alpha = 1; # mm^3/mm Hg

R=3.5; # 2.5 - 5 mmHg min mm^-3

Vstar=20;#mm^3 

#C1=314.04; #mumol/mL
C1 = 314.01*1e-3 ; #mumol/mm-3






#initial value of C2
C2init = C1-DeltaPi_s/rho
#labels (for plots)
label = ['LBP','NBP','HBP']
label2 = ['C2 LBP','C2 NBP','C2 HBP']
label3 = ['C2cst LBP','C2cst NBP','C2cst HBP']
#some values used for plots
lab = 1
lab2 = 1
lab3 = 1
i = 1
j = 1
# LOOP IN ARTERIAL PRESSURE
for p_a = [26.6,31.1,35.5]

  #initialisation of the equation [p, C2] = [vy(1),vy(2)]
  fvdb = @(vt,vy) [(Lp*(p_a-vy(1)-DeltaPi_p-Sigmas*DeltaPi_s)-(vy(1)-p_e)/R)/alpha; (Lp*(p_a-vy(1)-DeltaPi_p-Sigmas*DeltaPi_s)*( (1-Sigmas)*(DeltaPi_s/rho+2*vy(2))/2 - vy(2))+J)/Vstar];
  #comparison with psteady here computed
  psteady = (R*Lp*(p_a-DeltaPi_p-Sigmas*DeltaPi_s)+p_e)/(R*Lp+1)
  #option of ode 
  vopt = odeset ("RelTol", 1e-8, "AbsTol", 1e-3,"NormControl", "on");
				%vopt = odeset ("RelTol", 1e-3, "AbsTol", 1e-3,"NormControl", "on", "OutputFcn");
  #call to ode computation function
  [t,y] = ode45(fvdb,[0,500], [16 C2init], vopt);
  #fetching iop & C2
  iop = y(:,1);
  C2  = y(:,2);
  ##### Computing C2 constant from iop at the end
  length(t)
  pfin=iop(80) #basically equal to psteady
  cfin = C2(85)
  Fhstar = Lp*(p_a-pfin-DeltaPi_p-Sigmas*DeltaPi_s)
  C2st = [2 / (1+Sigmas)] * [ J/Fhstar + (1-Sigmas) * C1/2]

  #####
  #plot IOP
  figure(1);
  plot(t,iop,['@',int2str(i),int2str(j),strcat(';',label(lab:lab+2),';')]);
  title('IOP = f(time) (in mmHg)');
  print IOP_time.pdf;
  hold on;

  #plot C2 and C2 "steady"
  figure(2);
  plot(t,C2,['@',int2str(i),int2str(j),strcat(';',label2(lab2:lab2+5),';')]);
  hold on
  plot(t, C2st*ones(1,length(t)),['-',int2str(j),strcat(';',label3(lab3:lab3+8),';')]);
  title('C2 = f(time) (in mumol.mm^{-3})');
  print C2_time.pdf;
  hold on;

  #variables for labels issue
  i=i+1
  j = j+1
  lab = lab +3
  lab2= lab2+6
  lab3= lab3+9
end


hold off;
