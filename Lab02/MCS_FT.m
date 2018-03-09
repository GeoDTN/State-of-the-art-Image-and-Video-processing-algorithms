function [S] = MCS_FT(s,t,f)
dt=t(2)-t(1);
S=s*exp(-1i*2*pi*t'*f)*dt; 
end