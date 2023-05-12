function o = griewangk(x)
F2 = 1;
one = 0;
two = 1;
for i = 1:length(x)
    one = one + (x(i)^2/4000);
    two = two * (cos(x(i)/sqrt(i)));
end
o = F2 + one + two;
end