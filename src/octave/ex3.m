f = inline('sqrt(y)./(1+t.^2)','t','y');
y0 = 1; tspan=[0, 20];
for Nh = [10, 50, 100, 500];
  [t, y] = beuler(f,tspan,y0,Nh); plot(t, y,[';Nh=' int2str(Nh) ';']); hold on;
end;
f_ex = inline('( 1 + 0.5 * atan(t) ).^2','t');
plot( [0:.1:20], feval(f_ex,[0:.1:20]), 'r-;sqrt(y)./(1+t.^2);' );
print -depsc2 'edo_ex3_fig1.eps'; system("epstopdf edo_ex3_fig1.eps");

iter = 0;
for Nh = [10, 50, 100, 500];
  iter = iter + 1;
  [t, y] = beuler(f,tspan,y0,Nh);
  err(iter) = max(abs(y - feval(f_ex,t)));
end;
err

loglog([10, 50, 100, 500],err);
grid;
print -depsc2 'edo_ex3_fig2.eps'; system("epstopdf edo_ex3_fig2.eps");

h1 = 20/50; h2 = 20/500;
p = log(err(2)/err(4))/log(h1/h2)

