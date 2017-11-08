%Bin Model 1
clear
clc
addpath('C:Step1\dynopt\dynoptim');

options = optimset('LargeScale','on','Display','iter');
options = optimset(options,'GradObj','on','GradConstr','on');
options = optimset(options,'MaxFunEvals',1e7);
options = optimset(options,'MaxIter',500);  % maximum number of iterations
options = optimset (options,'TolFun',1e-7);
options = optimset (options,'TolCon',1e-7);
options = optimset (options,'TolX',1e-17);
options = optimset(options,'Algorithm','sqp'); %2010a
%options = optimset(options,'Algorithm','active-set'); %2008b

optimparam.optvar = 3; 
optimparam.objtype = []; 
optimparam.ncolx = 6;    % number of collocation points for states
optimparam.ncolu = 4;    % number of collocation points for traffic flow manipulation  
optimparam.li = ones(10,1) * (1/10);
optimparam.tf = 1;
optimparam.ui = ones(1,10) * 0.2; 
optimparam.par = []; 
optimparam.bdu = [0.1 0.5]; 
optimparam.bdx = [0 90; 0 90; 0 1e5];  % bounds of k1, k2, k3




optimparam.bdp =[];
optimparam.objfun = @objfun;
optimparam.confun = [];
optimparam.process = @process;
optimparam.options = options;

[optimout,optimparam]=dynopt(optimparam)
save optimresults optimout optimparam
[tplot,uplot,xplot] = profiles(optimout,optimparam,50);
save optimprofiles tplot uplot xplot 

graph