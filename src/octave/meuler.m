function [t, y] = meuler(f,tspan,y,Nh)

h=(tspan(2)-tspan(1))/Nh;             % le pas de temps
tt=linspace(tspan(1),tspan(2),Nh+1);  % le vecteur des temps tn
for t = tt(1:end-1)
  y=[y;y(end,:)+ h*( feval(f,t + 0.5*h,y(end,:) +
     0.5*h*feval(f,t,y(end,:))) )
    ];
end
t=tt';                                % on veut t vecteur colonne
