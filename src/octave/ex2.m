 f = inline('- atan(y)', 't', 'y');
 tspan = [0 30]; y0 = 1; h1 = 1.5*2; Nh1 = 30/h1;
 [t1,y1] = feuler(f,tspan,y0,Nh1)

 h2 = 0.25*2; Nh2 = 30/h2;
 #[t2,y2] = feuler(f,tspan,y0,Nh2);
 plot(t1,y1,";h=3;");%,t2,y2,"b-x;h=0.5;");

 #plot(t1,y1); hold on; plot(t2,y2);
# print -depsc2 'ode_ex2_fig1.eps'; system("epstopdf ode_ex2_fig1.eps");
