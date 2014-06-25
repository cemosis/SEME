 Nh1 = 50; Nh2 = 200;

 f = inline('-5*y', 't', 'y');
 tspan = [0, 20]; y0 = 1;
 [t1,y1] = heun(f,tspan,y0,Nh1);
 [t2,y2] = heun(f,tspan,y0,Nh2);
 plot(t1, y1, ";Heun Nh1;", t2, y2, ";Heun Nh2;");
 %% pour choisir de visualiser
 %% les ordonnees entre -0.5 et 1.5
 axis([0 20 -.5 1.5]);

 print -depsc2 'ode_ex1_fig1.eps'; system("epstopdf ode_ex1_fig1.eps");
 [t1_f,y1_f] = feuler(f,tspan,y0,Nh1);
 [t2_f,y2_f] = feuler(f,tspan,y0,Nh2);

 [t1_b,y1_b] = beuler(f,tspan,y0,Nh1);
 [t2_b,y2_b] = beuler(f,tspan,y0,Nh2);
 plot(t1_f,y1_f, t2_f,y2_f, t1_b,y1_b, t2_b,y2_b );
 print -depsc2 'ode_ex1_fig2.eps'; system("epstopdf ode_ex1_fig2.eps");
 [tcn_1,ycn_1] = meuler(f,tspan,y0,20/0.1);
 [tcn_2,ycn_2] = meuler(f,tspan,y0,20/0.01);

 Ecn_1 = max(abs(ycn_1 - feval(y,tcn_1)));
 Ecn_2 = max(abs(ycn_2 - feval(y,tcn_2)));

 p = log10(Ecn_1/Ecn_2)
