function [x] = rect(t)
x=0.5*(abs(t)==0.5)+(abs(t)<0.5);
end