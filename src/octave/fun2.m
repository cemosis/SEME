function dy=fun2(t,y)
  dy=zeros(2,1);
  dy(1) = 0.08*y(1) - 0.004*y(1)*y(2);
  dy(2) = -0.06*y(2) + 0.002*y(1)*y(2);
return
