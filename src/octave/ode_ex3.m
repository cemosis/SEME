 f=inline('(cos(t) - 0.1)*y','t','y');
 h=0.4; tspan=[0 12]; y0=1; Nh=12/h;
 % euler progressif
 [t_ep, y_ep] = feuler(f,tspan,y0,Nh);
 % heun
 [t_heun, y_heun] = heun(f,tspan,y0,Nh);

 sol_ex = inline('exp(-0.1*t + sin(t))','t');
 plot(t,feval(sol_ex,t),'b--'); hold on;
 h=0.4; Nh = 12/h;
 for i=1:4
   [t_ep, y_ep] = feuler(f,tspan,y0,Nh);
   plot(t_ep,y_ep)
    Nh = Nh*2;
  end

 h=0.4; Nh = 12/h; t=6; y6=feval(sol_ex,t);
 for i=1:5
   % euler progressif
   [t_ep, y_ep] = feuler(f,tspan,y0,Nh);
   err_ep(i) = abs(y6 - y_ep(fix(Nh/2)+1));
   % Heun
   [t_heun, y_heun] = heun(f,tspan,y0,Nh);
   err_heun(i) = abs(y6 - y_heun(fix(Nh/2)+1));
   Nh = Nh*2;
  end
 h=[0.4, 0.2, 0.1, 0.05, 0.025];
 loglog(h,err_ep,'b',h,err_heun,'r')
